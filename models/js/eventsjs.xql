xquery version "1.0";
import module namespace session="http://exist-db.org/xquery/session";
import module namespace functx = "http://www.functx.com" at "../../resources/library/functx.xq";
declare namespace me="http://me.com/me";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";



 
(:~ convert epoch seconds to dateTime :)
declare function me:convert-UTS($v) as xs:dateTime
{
  functx:dateTime('1970','01','01','00','00','00')
  + functx:dayTimeDuration(xs:decimal(0),xs:decimal(0),xs:decimal(0),xs:decimal(number($v)+864000))
  (:Here we add 10 days to be sur we are in the middle of the month to retrive the month no.:)
};

let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $start :=  if ($method = 'GET') then (
                            request:get-parameter('start', '')
                            )
                        else('')

let $readblestart := string(me:convert-UTS($start))

let $datestart := concat(substring-before($readblestart,'T'),'+00:00')

let $year := year-from-date(xs:date($datestart))
let $month := month-from-date(xs:date($datestart))


let $data1 := doc(concat($collection, "Calendar.xml"))/Calendar/Year[No=$year]
let $data2 := doc(concat($collection, "AcademicYears.xml"))//Course
let $data3 := doc(concat($collection, "Persons.xml"))//Person[Engagments/Engagment/Role='Student']
let $role := if (session:get-attribute('role')) then (
                            session:get-attribute('role')
                            )
                        else(
                            '-1'
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
     <Date>
        <Year>{$year}</Year>
        <Month>{$month}</Month>
     </Date>
    <Session>
        <Id>{$id}</Id>
        <Role>{$role}</Role>
   </Session>
     </Root>
   
