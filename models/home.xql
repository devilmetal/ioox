xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";

let $doc := doc('http://www.unifr.ch/webnews/rss2/fr/unifr/')                            

    return 
   <Unifr>
    {$doc}
   </Unifr>
   
