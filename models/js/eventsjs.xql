xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL de la page eventsjs. On retourne les informations voulues dans la période de temps donnée. Cette periode est passée via des Unix Timestamp par des paramètres en GET.
:)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace functx = "http://www.functx.com" at "../../resources/library/functx.xq";
declare namespace me="http://me.com/me";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";



 
(:~ convert epoch seconds to dateTime :)
declare function me:convert-UTS($v) as xs:dateTime
{
  functx:dateTime('1970','01','01','00','00','00')
  (:les + 10'000 représente un léger scaling:)
  + functx:dayTimeDuration(xs:decimal(0),xs:decimal(0),xs:decimal(0),xs:decimal(number($v)+10000))
  (:Here we add a few minutes to be sur we are in the middle of the month to retrive the month no.:)
};

let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $start :=  if ($method = 'GET') then (
                            request:get-parameter('start', '')
                            )
                        else('')

let $readblestart := string(me:convert-UTS($start))

(:formattage de quelques dates :)
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
                            
let $person :=  doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]


(:on prend les sessions concernées 1) dans le bon intervalle de temps + lequels sont dans les cours suivits :)
let $sessions := doc(concat($collection, "AcademicYears.xml"))//Session[Date>=$dateDstart][Date<=$dateaddMonth][ancestor::Course/CourseId=$person//Engagment[Role!='Unsubscribed']/CoursRef]

(: Reprise de la todolist :)
let $todolist := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]//ToDoList

(: on reprend que les tâches voulues, ie celles dans le bon interval de temps :)
let $tasks := $todolist//Task[Deadline/Date>=$dateDstart][Deadline/Date<=$dateaddMonth]


(: On prend les vacances qui partent de la date donnée jusqu'à celles qui se terminent le même jour le 2ème mois après celui donné, comme ça on assure de toutes les avoir :) 
let $holidays1 := doc(concat($collection, "AcademicYears.xml"))//Holiday[Start>=$dateDstart][Start<=$dateaddMonth]
(: il existe aussi le cas d'un chevauchement dans les date quand l'holiday possède une fin et que la start donnée par le JS du calendar est au milieu de Start et End :)
let $holidays2 := doc(concat($collection, "AcademicYears.xml"))//Holiday[Start<=$dateDstart][End>=$dateDstart]


return
    <Root>
        <Sessions>
            {
            for $session in $sessions
            return 
            <SessionEnc>
                <CourseId>{$session/ancestor::Course/CourseId/text()}</CourseId>
                {$session}
            </SessionEnc>
            }
        </Sessions>
        <Tasks>
            {$tasks}
        </Tasks>
        <Holidays>
            {$holidays1}
            {$holidays2}
        </Holidays>
        <SessionId>
            <Id>{$id}</Id>
        </SessionId>
     </Root>
     
   
