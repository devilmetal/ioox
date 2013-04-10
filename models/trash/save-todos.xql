
xquery version "1.0";
(: --------------------------------------
   Oppidum: write a resource to the DB

   Author: Stéphane Sire <s.sire@free.fr>

   Writes a resource to a collection and returns an XML success or error
   message. This design is adapted for simple XML pipeline (no view, no
   epilogue) to be called from an Ajax request.

   TODO:
   - manage image collections associated with the resource
     (delete dandling images)

   NOTE: as an alternative it should be possible to use eXist-db REST API
   instead of this ?

   August 2011
   -------------------------------------- :)

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../oppidum/lib/util.xqm";

declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)

let
  $cmd := request:get-attribute('oppidum.command'),
  $new := request:get-data(),
  $old := doc('/sites/ioox/data/db.xml')//Student[PersonRef=1]/ToDoList,
  $tosave := $new/ToDoList
return (
  oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else '')),  
  update replace $old with $tosave
)
  


