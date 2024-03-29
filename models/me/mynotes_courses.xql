xquery version "1.0";
(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Retrive data for list of course where there are note of the connected user
:)
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
                            
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]

(: Si la method est un post, donc on fait la suppresion d'une note :)               
let $query := if($method='POST') then
        (
            let $delete := request:get-parameter('delete', '')
            let $sessionNumber := substring-after($delete,'-_-')
            let $courseId := substring-before($delete,'-_-')
            return update delete $person//Note[SessionRef=$sessionNumber][CourseRef=$courseId]
        ) 
        else ((: nothing to do:))
let $notes  := $person/Notes
let $ref := string(request:get-attribute('oppidum.command')/resource/@name)
let $usables-session := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref]/Sessions/Session[SessionNumber=$notes//Note/SessionRef]
let $all-session := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref]/Sessions
let $name := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref]/Title
        

    return
    <Root>
     {$usables-session}
     <AllSession>
     {
     for $session in $all-session/Session
     order by dateTime($session/Date,$session/StartTime)
     return <Session>{$session/SessionNumber} {$session/Topics} {$session/Date} {$session/StartTime} {$session/EndTime}</Session>
     }
     </AllSession>
     <Infos>
        <CourseRef>{$ref}</CourseRef>
        {$name}
     </Infos>
     <Session>
        <Id>
            {$id}
        </Id>
     </Session>
     </Root>
   
