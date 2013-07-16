xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL de la page faq, alias contact. Retour vide
:)
import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

    (:Comme c'est une page statique on retourne rien. Par contre on a utilisé un model au cas ou:)
    return
    <Root>
    </Root>