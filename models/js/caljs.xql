xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL de la page caljs, retour vide.
:)
import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";



let $collection := '/sites/ioox/data/'                      

    return
     <Null/>
   
