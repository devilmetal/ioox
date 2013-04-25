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
let $data1 := doc(concat($collection, "db.xml"))/Moodle/Calendar/Year[No=$year]
let $data2 := doc(concat($collection, "db.xml"))/Moodle/Courses
let $data3 := doc(concat($collection, "db.xml"))/Moodle/Students

let $month :=  if ($method = 'POST') then (
                            request:get-parameter('monthno', '')
                            )
                        else(
                            fn:month-from-date($curr-date)
                            )
                            
let $role := if (session:get-attribute('role')) then (
                            session:get-attribute('role')
                            )
                        else(
                            -1
                            )
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            -1
                            )
                            

    return
    <Root>
    <Moodle>
    <Calendar>
     {$data1}
    </Calendar>
     {$data2}
    </Moodle>
    <DataCal>
        <CalMonthNo>{$month}</CalMonthNo>
        <CalYearNo>{$year}</CalYearNo>
    </DataCal>
    {$data3}
    <Session>
        <Id>{$id}</Id>
        <Role>{$role}</Role>
   </Session>
    </Root>
   
