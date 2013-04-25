xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";

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

    return
    <Root>
     {$data1}
     {$data2}
     {$data3}
     </Root>
   
