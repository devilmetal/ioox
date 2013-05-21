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
let $data3 := doc(concat($collection, "Persons.xml"))//Person[Engagments/Engagment/Role='Student']
let $user := xdb:get-current-user()
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
    <Calendar>
     {$data1}
    </Calendar>
    <Courses>
        {$data2}
    </Courses>
    <Persons>
        {$data3}
    </Persons>
    <Session>
        <Id>{$id}</Id>
        <Username>{$user}</Username>
   </Session>
    <DataCal>
        <CalMonthNo>{$month}</CalMonthNo>
        <CalYearNo>{$year}</CalYearNo>
    </DataCal>
    </Root>
   
