xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

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
let $query := if($method='POST') then 
                (
                
                ) 
                else 
                (
                
                )

    return
    <Root>
        <Role>{xdb:get-user-groups(xdb:get-current-user())}</Role>
    </Root>
   

