xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQuery pour la génération de la home page
                    récupère des informations du site de l'université de Fribourg (www.unifr.ch)
:)
import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";

let $doc := if(doc-available('http://www.unifr.ch/webnews/rss2/fr/unifr/')) then (doc('http://www.unifr.ch/webnews/rss2/fr/unifr/')) else (<Empty/>)   

    return 
   <Unifr>
   {$doc}
   </Unifr>
   
