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
declare function local:createID() as xs:string
{
    let $date := current-dateTime()
    let $year := year-from-dateTime($date)
    let $month := month-from-dateTime($date)
    let $day := day-from-dateTime($date)
    let $hours := hours-from-dateTime($date)
    let $minutes := minutes-from-dateTime($date)
    let $secondes := string(seconds-from-dateTime($date))
    let $id := concat(concat(concat(concat(concat($year,$month),$day),$hours),$minutes),substring-before($secondes,'.'))
  return 
    $id
};  
let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
let $courseid := string(request:get-attribute('oppidum.command')/resource/@name)
(:On reprend le titre du cours pour l'afficher ainsi que la periode du cours:)
let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
let $courseTitle := $course/Title
let $coursePeriod := $course/ancestor::Period/Name
let $pageTitle := concat(concat($coursePeriod,' - '),$courseTitle)


(:on controle aussi si la personne est bien un admin avant de chercher les données:)
let $core := if ($method='POST' and $role='dba') then 
    (
    (:C'est un POST, donc on doit soit afficher les utilisateurs qui découlent de la recherche soit supprimer un utilisateur:)
    if(request:get-parameter('search', '')!='') then
        (
        (:On recherche des utilisateurs:)
        (: on récupère les infos du formulaire:)
        let $lname := request:get-parameter('lname', '')
        let $fname := request:get-parameter('fname', '')
        let $username := request:get-parameter('username', '')
        let $uniqueID := request:get-parameter('uniqueID', '')
        (: on recherche les utilisateurs :)
        let $persons := doc(concat($collection, "Persons.xml"))//Person[contains(local:scale(Username),local:scale($username))][contains(local:scale(Firstname),local:scale($fname))][contains(local:scale(Lastname),local:scale($lname))][contains(local:scale(UniqueID),local:scale($uniqueID))]
        (:on les retournes:)
        (: si la recherche est vide on retourne <Search/> avec une <Error/> sinon la liste des utilisateurs :)
        let $test := if ($persons!='') then 
                        (
                            <Back>
                                {$persons}
                            </Back>
                        )
                        else
                        (
                            <Search>
                                <Error>No user matches the data was found.</Error>
                            </Search>
                        )
        return $test
        )
        else
        (
        (:BINDING:)
        (:On bind un user à un cours en tent que Teacher ou Tutor:)
        let $personid := request:get-parameter('personid', '')
        let $role := request:get-parameter('role', '')
        
        (:on test si l'user n'as pas déjà un tel role:)
        let $test := exists(doc(concat($collection, "Persons.xml"))//Person[PersonId=$personid]//Engagment[CoursRef=$courseid][Role=$role])
        
        let $query := if ($test) then
                            (
                            (:on a rien à faire, on retourne un message:)
                            <Message>This user is already registred to this course as {local:scale($role)}</Message>
                            )
                            else
                            (
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$personid]
                            let $query := update insert <Engagment>
                                                            <EngagementId>{local:createID()}</EngagementId>
                                                            <CoursRef>{$courseid}</CoursRef>
                                                            <Role>{$role}</Role>
                                                        </Engagment> 
                                                        into $person/Engagments
                            return
                                <Message>{$person/Lastname} {$person/Firstname} is now {$role} for this course</Message>
                            
                            )
        return  <Search>
                    {$query}
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
        <PageTitle>
            {$pageTitle}
        </PageTitle>
    </Root>
   

