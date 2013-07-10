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
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]
let $studentId := tokenize($ref,'/')[6]

let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
let $old := doc(concat($collection, "Persons.xml"))//Person[PersonId=$studentId]//Engagment[Role='Student'][CoursRef=$courseid]/Grade

let $tosave :=  <Grade>
                    {$new//ExamGrade}
                    <ExercicesGrades>
                    {
                    for $exercice in $new//ExercicesGrades/Exercice
                    return
                    <Exercice>
                        {$exercice/ExerciceId}
                        {$exercice/ExerciceGrade}
                    </Exercice>
                    }
                    
                    </ExercicesGrades>
                    {$new//ProjectGrades}
                </Grade>
                
        return (
        update replace $old with $tosave,
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )
