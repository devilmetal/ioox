xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
                            
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $data3 := doc(concat($collection, "db.xml"))/Moodle/Persons
let $ref := request:get-attribute('oppidum.command')/resource/@name
let $ref2 := string($ref)
let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref2]
let $teachers := doc(concat($collection, "Persons.xml"))//Person/Engagments/Engagment[(Role='Tutor' or Role='Teacher') and CoursRef=$ref2]/ancestor::Person
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
let $grades :=  $person//Engagment[Grade][CoursRef=$ref2]
                            


    return
    <Root>
        <Teachers>
            {$teachers}
        </Teachers>
     {$course}
     <Grades>
        {$grades}
     </Grades>
     </Root>
    
