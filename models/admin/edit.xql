xquery version "1.0";
(: --------------------------------------
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     Version modifiée de l'edit.xql qui permet d'utiliser les paramètres passés en GET pour le clone d'un cours.
  -------------------------------------- :)

import module namespace xdb = "http://exist-db.org/xquery/xmldb";  
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../../oppidum/lib/util.xqm";   
                                              
let $cmd := request:get-attribute('oppidum.command')
(:Paramètre passé via GET:)
let $param := string(request:get-parameter('id', ''))
return
  <Edit>
    {
    if ($param='') then
        (
            <Resource>{concat($cmd/@base-url, $cmd/@trail)}.xml</Resource>
        )
        else
        (
            <Resource>{concat($cmd/@base-url, $cmd/@trail)}.xml?id={$param}</Resource>
        )
    
    }
    
    { 
      if ($cmd/resource/@template) then
        <Template>{concat($cmd/@base-url, $cmd/resource/@template)}</Template>
      else
        oppidum:add-error('ACTION-EDIT-NO-TEMPLATE', $cmd/@trail, true())
    }
  </Edit>
