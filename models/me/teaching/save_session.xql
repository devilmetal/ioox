xquery version "1.0";
(: --------------------------------------

   -------------------------------------- :)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../../../oppidum/lib/util.xqm";

declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)

let $collection := '/sites/ioox/data/'
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]

let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
let $sid := $new//Session//SessionNumber
let $old := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]//Session[SessionNumber=$sid]
let $new2 := $new//Session
let $tosave := <Session>
                    {$new2/SessionNumber}
                    {$new2/Topics}
                    {$new2/Description}
                    {$new2/Date}
                    {$new2/StartTime}
                    {$new2/EndTime}
                    {$new2/Room}
                    {
                        let $test := exists($new2//Exercise)
                        return
                            if ($test) then
                                (
                                    <Exercise>
                                        {$new2/Exericse/ExerciceId}
                                        {$new2/Exercise/Description}
                                        {$new2/Exercise/Data}
                                        {
                                            let $test := exists($old/Exercise/Deliverables/Deliverable)
                                            return
                                            if ($test) then
                                                (
                                                    $old/Exercise/Deliverables
                                                )
                                                else
                                                (
                                                    <Deliverables/>
                                                )
                                        }
                                    </Exercise>
                                )
                                else
                                ((:Rien à faire:))
                        
                    }
                </Session>
                
        return (
        update replace $old with $tosave,
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )
