xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $id :=  if ($method = 'POST') then (
                            request:get-parameter('coursid', '')
                            )
                        else(
                            1
                            )
                            
let $sort_name :=  if ($method = 'POST') then (
                            request:get-parameter('sort_name', '')
                            )
                        else(
                            ''
                            )
let $sort_id :=  if ($method = 'POST') then (
                            request:get-parameter('sort_id', '')
                            )
                        else(
                            ''
                            )
let $sort_teacher :=  if ($method = 'POST') then (
                            request:get-parameter('sort_teacher', '')
                            )
                        else(
                            ''
                            )
let $order :=  if ($method = 'POST') then (
                            request:get-parameter('order', '')
                            )
                        else(
                            'ascending'
                            )
let $data2 := doc(concat($collection, "db.xml"))/Moodle/Courses
let $data3 := doc(concat($collection, "db.xml"))/Moodle/Persons
let $session-attributes := session:get-attribute-names()
    return
    <Root>
     {$data2}
     <CoursID>{$id}</CoursID>
     {$data3}
     <Sort>
        <SortID>{$sort_id}</SortID>
        <SortName>{$sort_name}</SortName>
        <SortTeacher>{$sort_teacher}</SortTeacher>
        <Order>{$order}</Order>
        <Session>
   <Connected>{session:get-attribute('id')}</Connected>
   <ID>{session:get-id()}</ID>
   </Session>
     </Sort>
     </Root>
   
