xquery version "1.0";
(: --------------------------------------
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour la sauvegarde d'un quizz modifié
   -------------------------------------- :)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../oppidum/lib/util.xqm";

declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)
let $collection := '/sites/ioox/data/'
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
(:on prend les infos du cours et on test si la personne connectées est un prof pour ce cours.:)
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]
let $studentId := tokenize($ref,'/')[6]
let $isTeacher := exists(doc(concat($collection, "Persons.xml"))//Engagment[CoursRef=$courseid][Role='Teacher' or Role='Tutor'])

let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
let $old := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]/Quizz

let $tosave :=  $new//Quizz

(:on sauvegarde le quizz modifié si la personne est un prof du cours.:)
let $query := if($isTeacher) then 
                    (
                     let $query := update replace $old with $tosave
                     return
                        $query
                    ) 
                    else 
                    ((:is not a teacher:))
                
        return (
        
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )