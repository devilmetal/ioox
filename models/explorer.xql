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

let $data0 := doc(concat($collection, "AcademicYears.xml"))//Period[($curr-date >= ./End)] 
let $data1 := doc(concat($collection, "AcademicYears.xml"))//Period[($curr-date >= ./Start) and ($curr-date <= ./End)]
let $data2 := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments

order by $data0/Period/End
    return
    <Root>
        
        <CoursID>{$id}</CoursID>
        <PastPeriod>{$data0}</PastPeriod>
        <CurrentPeriod>{$data1}</CurrentPeriod>
        <Person>{$data2}</Person>
        
        
        <Session>
            <Connected>{session:get-attribute('id')}</Connected>
            <ID>{session:get-id()}</ID>
        </Session>
    </Root>
   

