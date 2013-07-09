xquery version "1.0";
(: --------------------------------------

   -------------------------------------- :)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../../oppidum/lib/util.xqm";

declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)
(:CECI EST UNE VARIABLE DE CREATION POUR LE NOMBRE DE SESSION A CREER DE BASE :)
let $MAXNUMBERSESSIONS := 14
let $collection := '/sites/ioox/data/'
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
(:on récupère les old id passé:)
let $oldId := $new//OldId
let $newCourse := $new//Course
let $newId := $newCourse/CourseId
let $maxperiodstart := max(doc(concat($collection, "AcademicYears.xml"))//Period/replace(string(Start),'-',''))
let $courses := doc(concat($collection, "AcademicYears.xml"))//Period[replace(string(Start),'-','')=$maxperiodstart]/Courses

let $test := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$newId])
(:si oldid est vide et il n'existe aucun cours avec newID donc c'est un nouveau cours, sinon si le nouvel id est identique on fait un replace du cours.:)
let $query := if ($oldId='nan' and not($test)) then
        (
            (:Dans ce cas, on fait une insertion d'un nouveau cours:)
            (:on profite de créer la nouvelle collection pour le cours :)
            let $query1 := xdb:create-collection('/courses/',$newId)
            (:On change les droits:)
            let $courseCollection := concat(concat('/courses/',$newId),'/')
            let $query2 := xdb:set-collection-permissions($courseCollection,'admin','site-member',util:base-to-integer(0775, 8))
            let $course:=   <Course>
                                {$newCourse/CourseId}
                                {$newCourse/CourseNo}
                                {$newCourse/Title}
                                {$newCourse/Acronym}
                                {$newCourse/Description}
                                <Evaluation/>
                                <Sessions>
                                    {
                                    for $i in (1 to $MAXNUMBERSESSIONS)
                                    (:on profite de créer les collection avec les droit aussi:)
                                    let $query1 := xdb:create-collection($courseCollection,string($i))
                                    (:On change les droits:)
                                    let $sessionCollection := concat(concat($courseCollection,string($i)),'/')
                                    let $query2 := xdb:set-collection-permissions($sessionCollection,'admin','site-member',util:base-to-integer(0775, 8))
                                    return
                                    <Session>
                                        <SessionNumber>{$i}</SessionNumber>
                                        <Topics/>
                                        <Description/>
                                        <Date/>
                                        <StartTime/>
                                        <EndTime/>
                                        <Room/>
                                        <Resources/>
                                    </Session>
                                    }
                                </Sessions>
                            </Course>
            let $query3 := update insert $course into $courses

            return
                <Done/>    
        )
        else
        (
            (:Dans ce cas, on va modifier un cours ou le cloner:)
            (:s'il existe un cours avec newID donc on est en mode modification:)
            if ($test) then
                (
                    (:Dans ce cas, on va modifier le cours.:)
                    let $oldcourse := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$newId]
                    let $course :=  
                            <Course>
                                {$newCourse/CourseId}
                                {$newCourse/CourseNo}
                                {$newCourse/Title}
                                {$newCourse/Acronym}
                                {$newCourse/Description}
                                {$oldcourse/Evaluation}
                                <Sessions>
                                    {
                                    for $session in $oldcourse/Sessions
                                    return
                                    <Session>
                                        {$session/SessionNumber}
                                        {$session/Topics}
                                        {$session/Description}
                                        {$session/Date}
                                        {$session/StartTime}
                                        {$session/EndTime}
                                        {$session/Room}
                                        {$session/Ressources}
                                        {
                                        (:si il y a un exercice pour la session on le reprend, sinon pas:)
                                        if(exists($session/Exercise)) then
                                            (
                                                <Exercise>
                                                    {$session/Exercise/ExerciseId}
                                                    {$session/Exercise/Description}
                                                    {$session/Exercise/Data}
                                                    <Deliverables/>
                                                </Exercise>
                                            )
                                            else
                                            ((:Rien:))
                                        }
                                    </Session>
                                    }
                                </Sessions>
                            </Course>
                    let $query := update replace $oldcourse with $course
                return
                    <Done/>
                )
                else
                (
                    (:Dans ce cas, on va cloner le cours :)
                    (:on profite de créer la nouvelle collection pour le cours :)
                    let $query1 := xdb:create-collection('/courses/',$newId)
                    (:On change les droits:)
                    let $courseCollection := concat(concat('/courses/',$newId),'/')
                    let $query2 := xdb:set-collection-permissions($courseCollection,'admin','site-member',util:base-to-integer(0775, 8))
                    let $oldcourse := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$oldId]
                    let $course :=  
                            <Course>
                                {$newCourse/CourseId}
                                {$newCourse/CourseNo}
                                {$newCourse/Title}
                                {$newCourse/Acronym}
                                {$newCourse/Description}
                                {$oldcourse/Evaluation}
                                <Sessions>
                                    {
                                    for $session in $oldcourse/Sessions/Session
                                    (:on profite de créer les collection avec les droit aussi:)
                                    let $query1 := xdb:create-collection($courseCollection,string($session/SessionNumber))
                                    (:On change les droits:)
                                    let $sessionCollection := concat(concat($courseCollection,string($session/SessionNumber)),'/')
                                    let $query2 := xdb:set-collection-permissions($sessionCollection,'admin','site-member',util:base-to-integer(0775, 8))
                                    return
                                    <Session>
                                        {$session/SessionNumber}
                                        {$session/Topics}
                                        {$session/Description}
                                        {$session/Date}
                                        {$session/StartTime}
                                        {$session/EndTime}
                                        {$session/Room}
                                        {$session/Ressources}
                                        {
                                        (:si il y a un exercice pour la session on le reprend, sinon pas:)
                                        if(exists($session/Exercise)) then
                                            (
                                                <Exercise>
                                                    {$session/Exercise/ExerciseId}
                                                    {$session/Exercise/Description}
                                                    {$session/Exercise/Data}
                                                    <Deliverables/>
                                                </Exercise>
                                            )
                                            else
                                            ((:Rien:))
                                        }
                                    </Session>
                                    }
                                </Sessions>
                            </Course>
                let $query3 := update insert $course into $courses
                return
                    <Done/>
                )
        )
        


        return (
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )
