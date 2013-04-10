xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/xmoodle/data/'
let $data := doc(concat($collection, "db.xml"))//Student[PersonRef='1']
                            

    return $data
   
