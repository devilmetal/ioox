xquery version "1.0";
(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      This query retrive the information on the selected session
:)
import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $ref := request:get-attribute('oppidum.command')/@trail
let $sid := string(request:get-attribute('oppidum.command')/resource/@name)
let $courseid := tokenize($ref,'/')[3]

(: check login:)
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )

(:retrive data of the current session:)
let $data2 := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]/Sessions/Session[SessionNumber=$sid]
(: retrive some usesfull information:)
let $teacher := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Teacher'][CoursRef=$courseid])
let $tutor := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Tutor'][CoursRef=$courseid])
let $user := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Student'][CoursRef=$courseid])

let $personsFollowers :=  doc(concat($collection, "Persons.xml"))//Person[.//Engagment[Role='Student'][CoursRef=$courseid]]
 
    return
    <Root>
    {$data2}
    <sysinfo>
        <CourseId>{$courseid}</CourseId>
        <SessionNumber>{$sid}</SessionNumber>
        <Session>
            <Id>{$id}</Id>
            <CurrentRole>
                <Teacher>{$teacher}</Teacher>
                <Tutor>{$tutor}</Tutor>
                <Student>{$user}</Student>
            </CurrentRole>
            </Session>
     <Persons>
            {
            for $person in $personsFollowers
            return
            <Person>
                {$person/UniqueID}
                {$person/Lastname}
                {$person/Firstname}
                {$person/PersonId}
            </Person>
            }
     </Persons>
    </sysinfo>
    </Root>
