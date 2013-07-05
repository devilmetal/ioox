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

let $dateDstart := substring-before($readblestart,'T')
let $datestart := concat(substring-before($readblestart,'T'),'+00:00')
let $dateaddMonth := functx:add-months($dateDstart,2)
let $year := year-from-date(xs:date($datestart))
let $month := month-from-date(xs:date($datestart))


let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $data1 := doc(concat($collection, "Calendar.xml"))/Calendar/Year[No=$year]
let $person :=  doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
(: on reprend que les cours de la period concernée par la date start envoyée par le JS du calendrier et uniquement ceux dont la personne y est inscrit et pas desinscrit :)
let $data2 := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$person//Engagment[Role!='Unsubscribed']/CoursRef][./ancestor::Period/Start<=$dateDstart][./ancestor::Period/End>=$dateDstart]

let $todolist := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]//ToDoList

(: On prend les vacances qui partent de la date donnée jusqu'à celles qui se terminent le même jour le 2ème mois après celui donné, comme ça on assure de toutes les avoir :) 
let $holidays1 := doc(concat($collection, "AcademicYears.xml"))//Holiday[Start>=$dateDstart][Start<=$dateaddMonth]
(: il existe aussi le cas d'un chevauchement dans les date quand l'holiday possède une fin et que la start donnée par le JS du calendar est au milieu de Start et End :)
let $holidays2 := doc(concat($collection, "AcademicYears.xml"))//Holiday[Start<=$dateDstart][End>=$dateDstart]
    return
    <Root>
        <Date>
            <Year>{$year}</Year>
            <Month>{$month}</Month>
        </Date>
        <Calendar>
            {$data1}
        </Calendar>
        <Courses>
            {$data2}
        </Courses>
        <Session>
            <Id>{$id}</Id>
        </Session>
        <ToDoListPerson>
            {$todolist}
        </ToDoListPerson>
        <Holidays>
            {$holidays1}
            {$holidays2}
        </Holidays>
        {$dateDstart}
     </Root>
     
   
