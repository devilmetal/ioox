xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()

let $year :=  if ($method = 'POST') then (
                            request:get-parameter('yearno', '')
                            )
                        else(
                            fn:year-from-date($curr-date)
                            )
let $data1 := doc(concat($collection, "Calendar.xml"))/Calendar/Year[No=$year]
let $data2 := doc(concat($collection, "AcademicYears.xml"))//Course
let $data3 := doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]
let $teacher := doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagements/Engagement[Role='Teacher' ]
let $tutor := doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagements/Engagement[Role='Tutor']
let $user := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagements/Engagement[Role='Student'])
let $month :=  if ($method = 'POST') then (
                            request:get-parameter('monthno', '')
                            )
                        else(
                            fn:month-from-date($curr-date)
                            )

let $year :=  if ($method = 'POST') then (
                            request:get-parameter('yearno', '')
                            )
                        else(
                            fn:year-from-date($curr-date)
                            )
                            
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
                            

    return
    <Root>

    <Session>
        <Id>{$id}</Id>
        <Username>{$user}</Username>
        <CurrentRole>
            <Teacher>{$teacher}</Teacher>
            <Tutor>{$tutor}</Tutor>
            <Student>{$user}</Student>
        </CurrentRole>
   </Session>    
    </Root>
   
