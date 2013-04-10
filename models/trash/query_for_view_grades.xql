xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";

let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $id :=  if ($method = 'POST') then (
                            request:get-parameter('coursid', '')
                            )
                        else(
                            1
                            )
let $data2 := doc(concat($collection, "db.xml"))/Moodle/Courses
let $data3 := doc(concat($collection, "db.xml"))/Moodle/Grades

    return
    <Root>
     {$data2}
     {$data3}
     <CourseId>{$id}</CourseId>
     </Root>
   
