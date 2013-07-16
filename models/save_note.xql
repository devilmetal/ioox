xquery version "1.0";
(: --------------------------------------
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour la sauvegarde d'une note
   -------------------------------------- :)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../oppidum/lib/util.xqm";

declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)

let $collection := '/sites/ioox/data/'
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
(:On récupère la nouvelle note:)
let $noteId := $new//NoteId
(:On récupère l'ancienne:)
let $old := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Notes/Note[NoteId=$noteId]
let $tosave := $new//Note
        return (
        (:Update:)
        update replace $old with $tosave,
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )
