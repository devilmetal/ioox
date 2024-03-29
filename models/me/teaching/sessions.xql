xquery version "1.0";

(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      this query retrive the session and topic information for generate the list fo session
:)

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]


let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )


let $data2 := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]/Sessions

let $teacher := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Teacher'][CoursRef=$courseid])
let $tutor := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Tutor'][CoursRef=$courseid])
let $user := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Student'][CoursRef=$courseid])
 
    return
    <Root>
    <Sessions>
    {
    for $s in $data2//Session
    order by $s/Date, $s/SessionNumber
    return
        <Session>
            {$s/SessionNumber}
            {$s/Topics}
            {$s/Description}
            {$s/Date}
            {$s/StartTime}
            {$s/EndTime}
            {$s/Room}
        </Session>
    } 
    </Sessions>
    <sysinfo>
        <CourseId>{$courseid}</CourseId>
        <Session>
            <Id>{$id}</Id>
            <CurrentRole>
                <Teacher>{$teacher}</Teacher>
                <Tutor>{$tutor}</Tutor>
                <Student>{$user}</Student>
            </CurrentRole>
            </Session>
    </sysinfo>
    </Root>
