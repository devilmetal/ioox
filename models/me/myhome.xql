xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()

let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $teacher := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagments/Engagment[Role='Teacher'])
let $tutor := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagments/Engagment[Role='Tutor'])
let $user := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=session:get-attribute('id')]/Engagments/Engagment[Role='Student'])
                            

    return
    <Root>

    <Session>
        <Id>{$id}</Id>
        <Username>{$user}</Username>
        <CurrentRole>
            <Teacher>{$teacher}</Teacher>
            <Tutor>{$tutor}</Tutor>
            <Student>{$user}</Student>
        </CurrentRole>
   </Session>    
    </Root>
   
