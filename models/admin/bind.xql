xquery version "1.0";

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
    (:C'est un POST, donc on doit soit afficher les cours qui découlent de la recherche soit supprimer un teacher:)
        (:Si le parametre search est passé c'est un recherche:)
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
        (: si la recherche est vide on retourne <Search/> avec une <Error/> sinon la liste des utilisateurs :)
        let $test := if ($courses!='') then 
                        (
                            let $persons := doc(concat($collection, "Persons.xml"))//Persons
                            
                            return
                            <Back>
                                {for $course in $courses
                                return
                                    let $id := $course/CourseId
                                    return
                                    <Course>
                                        <Period>{$course/ancestor::Period/Name}</Period>
                                        {$course/Title}
                                        {$course/CourseNo}
                                        {$course/Acronym}
                                        {$id}
                                        <Teachers>
                                            {
                                            for $person in $persons/Person
                                            where $person//Engagment[(Role='Teacher' and CoursRef=$id) or (Role='Tutor' and CoursRef=$id)]
                                            return
                                                <Teacher>
                                                    <Name>{$person/Lastname} {$person/Firstname}</Name>
                                                    <Username>{$person/Username/text()}</Username>
                                                </Teacher>
                                            }
                                        </Teachers>
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
        (:On enlève un teacher de son cours:)
        (:1 on reprend l'username passé:)
        let $username := request:get-parameter('username', '')
        let $courseid := request:get-parameter('courseid', '')
        (:2 on reprend la personne:)
        let $teacher := doc(concat($collection, "Persons.xml"))//Person[Username=$username]
        let $fname := $teacher/Firstname
        let $lname := $teacher/Lastname
        let $query := update delete $teacher//Engagment[(Role='Teacher' or Role='Tutor') and CoursRef=$courseid]
        
        return
        <Search>
            <Message>Teacher : {$lname} {$fname} was removed from this course.</Message>
        </Search>
        )
    )
    else
    (
        (: C'est pas POST, donc on affiche la boite de recherche des cours :)
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
   

