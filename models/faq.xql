xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

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
let $user := xdb:get-current-user()
let $currentID := if ($user = 'guest') then (
                            -1
                            )
                        else(
                            doc(concat($collection, "db.xml"))//Person[Username=$user]/PersonId
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
    <UserBuildID>
    {$currentID}
    </UserBuildID>
    </Root>
   
