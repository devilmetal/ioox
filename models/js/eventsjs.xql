xquery version "1.0";
declare namespace me="http://me.com/me";
declare namespace request="http://exist-db.org/xquery/request";
import module namespace functx = "http://www.functx.com" at "../../resources/library/functx.xq";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";



 
(:~ convert epoch seconds to dateTime :)
declare function me:convert-UTS($v) as xs:dateTime
{
  functx:dateTime('1970','01','01','00','00','00')
  + functx:dayTimeDuration(xs:decimal(0),xs:decimal(0),xs:decimal(0),xs:decimal($v))
};

let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $start :=  if ($method = 'GET') then (
                            request:get-parameter('start', '')
                            )
                        else('1365051600')

let $readblestart := string(me:convert-UTS($start))

let $datestart := concat(substring-before($readblestart,'T'),'+00:00')

let $year := year-from-date(xs:date($datestart))
let $month := month-from-date(xs:date($datestart))

let $data1 := doc(concat($collection, "db.xml"))/Moodle/Calendar/Year[No=$year]/Month[No=$month]
let $data2 := doc(concat($collection, "db.xml"))/Moodle/Courses
let $data3 := doc(concat($collection, "db.xml"))/Moodle/Students

    return
    <Root>
     {$data1}
     {$data2}
     {$data3}
     <Date>
        <Year>{$year}</Year>
        <Month>{$month}</Month>
     </Date>
     </Root>
   
