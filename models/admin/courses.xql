xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL le page page courses admin, cette page permet de chercher dans les cours pour la création/mofification/clonage/suppression d'un cours.
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";

declare function local:scale($string) as xs:string
{
    let $trim := replace(replace($string,'\s+$',''),'^\s+','')
    let $lowcase := lower-case($trim)
  return 
    $lowcase
};  


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
(:on prend tous les noms de periodes:)
let $periods := doc(concat($collection, "AcademicYears.xml"))//Period

(:on controle aussi si la personne est bien un admin avant de chercher les données:)
let $core := if ($method='POST' and $role='dba') then 
    (
    (:C'est un POST, donc on doit soit afficher les utilisateurs qui découlent de la recherche soit supprimer un utilisateur:)
    if(request:get-parameter('search', '')!='') then
        (
        (:On recherche des utilisateurs:)
        (: on récupère les infos du formulaire:)
        let $period := local:scale(request:get-parameter('period', ''))
        let $courseno := local:scale(request:get-parameter('courseno', ''))
        let $title := local:scale(request:get-parameter('title', ''))
        let $acronym := local:scale(request:get-parameter('acronym', ''))
        (: on recherche les utilisateurs :)
        let $courses := doc(concat($collection, "AcademicYears.xml"))//Course[contains(local:scale(./ancestor::Period/Name),$period)][contains(local:scale(CourseNo),$courseno)][contains(local:scale(Title),$title)][contains(local:scale(Acronym),$acronym)]
        (:on les retournes:)
        (: si la recherche est vide on retourne <Search/> avec une <Error/> sinon la liste des cours :)
        let $test := if ($courses!='') then 
                        (
                            <Back>
                                {for $course in $courses
                                return
                                    <Course>
                                        <Period>{$course/ancestor::Period/Name}</Period>
                                        {$course/Title}
                                        {$course/CourseNo}
                                        {$course/Acronym}
                                        {$course/CourseId}
                                    </Course>}
                            </Back>
                        )
                        else
                        (
                            <Search>
                                <Error>No course matches the data was found.</Error>
                            </Search>
                        )
        return $test
        )
        else
        (
        (:SUPPRESSION:)
        (:On supprime un utilisateur:)
        let $courseid := request:get-parameter('courseid', '')
        
        (:Supression de la base de donnée:)
        let $test1 := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid])
        (:si l'utilisateur est dans la BD, normalement c'est le cas... alors on supprime:)
        let $BDdelete := if($test1) then 
                    (
                    (:On supprime le cours:)
                    let $query1 := update delete doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
                    (:On supprime toute trace d'engagement ainsi que les notes qui vont avec:)
                    let $query2 := update delete doc(concat($collection, "Persons.xml"))//Person//Engagment[CoursRef=$courseid]
                    return <Message>The course has been deleted from the Database</Message>
                    ) 
                    else 
                    (
                    <Message>The course was not in the eXist Database. But it is ok.</Message>
                    )
        (: suppression de la collection dans la base de donnée si elle existe:)
        let $courseCollection := concat('/courses/',$courseid)
        let $test2 := xdb:collection-available($courseCollection)
        let $eXistCourseDelete := if($test2) then
                    (
                    let $query := xdb:remove($courseCollection)
                    return <Message>The collection of this course has been deleted from the eXist Database</Message>
                    ) 
                    else 
                    (
                    <Message>The collection of this course was not in the eXist Database. But it is ok.</Message>
                    )
        return  <Search>
                    {$BDdelete}
                    {$eXistCourseDelete}
                </Search>
        )
    )
    else
    (
        (: C'est pas POST, donc on affiche la boite de recherche des utilisateurs :)
        <Search/>
    )
    return
    <Root>
        <Role>{$role}</Role>
        <Core>
            {$core}
        </Core>
        <Periods>
            {for $period in $periods
            order by $period/Start descending
            return $period/Name}
        </Periods>
    </Root>
   

