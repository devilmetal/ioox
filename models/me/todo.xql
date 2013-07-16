xquery version "1.0";
(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Query that retrive the personal todolist
:)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";

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
let $todolist :=  doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]//ToDoList
                            

    return
    <Root>
     {$todolist}
     </Root>
   
