xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";

<<<<<<< HEAD

let $doc := if(doc-available('http://www.unifr.ch/webnews/rss2/fr/unifr/')) then (doc('http://www.unifr.ch/webnews/rss2/fr/unifr/')) else (<Empty/>)            
=======
let $doc := doc('http://www.unifr.ch/webnews/rss2/fr/unifr/')  
>>>>>>> f70c502804ff1fd6255787ac4d074d23c403a808

    return 
   <Unifr>
   {$doc}
   </Unifr>
   
