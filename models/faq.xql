xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

    return
    <Root>
    </Root>