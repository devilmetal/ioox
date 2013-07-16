xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL le page page course, cette page permet de créer un cours.
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";

(:permet de supprimer les cractère fâcheux comme les espaces et mettre en lowcase:)
declare function local:scale($string) as xs:string
{
    let $trim := replace(replace($string,'\s+$',''),'^\s+','')
    let $lowcase := lower-case($trim)
  return 
    $lowcase
};  

(:Crée un ID aussi unique que possible pour un cours grace à la date:)

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
let $param := string(request:get-parameter('id', 'nan'))

let $core := if ($courseid='new') then
        (
            (:c'est la création d'un cours ou le clône:)
            let $newID := local:createID()
            return
            if ($param='nan') then
                (
                    (:C'est la création d'un nouveau cours:)
                    <Course>
                        <CourseId>{$newID}</CourseId>
                        <CourseNo/>
                        <Title/>
                        <Acronym/>
                        <Description>
                            <Parag/>
                        </Description>
                    </Course>
                )
                else
                (
                    (:C'est le clône d'un cours existant:)
                    (:on va regarde si il existe, sinon, on va simplement afficher une erreure:)
                    let $test := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$param])
                    return
                    if ($test) then 
                        (
                            (:le cours exist et donc on peut le cloner:)
                            let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$param]
                            let $sessions := $course/Sessions
                            return 
                            <Course>
                                <CourseId>{$newID}</CourseId>
                                {$course/CourseNo}
                                {$course/Title}
                                {$course/Acronym}
                                {$course/Description}
                            </Course>
                        )
                        else
                        (   
                            (:on demande un cours qui n'existe pas:)
                            <Error>You asked to clone a course that does not exist</Error>
                        )
                )
        )
        else
        (
            (:c'est la modification d'un cours qui existe:)
            let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
            return 
            $course
        )

(:on prend tous les noms de periodes:)
(: Note : on passe le OLD ID pour sauvgarder au mieux après.:)
    return
    <Root>
        <Role>{$role}</Role>
        <Core>
            <OldId>{$param}</OldId>
            {$core}
        </Core>
        <Modifier>
            <Param>{$param}</Param>
            <CourseId>{$courseid}</CourseId>
        </Modifier>
    </Root>
   

