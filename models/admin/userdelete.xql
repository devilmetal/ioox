xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
let $core := if ($method='POST') then 
    (
    (:C'est un POST, donc on doit soit afficher les utilisateurs qui découlent de la recherche soit supprimer un utilisateur:)
    if(request:get-parameter('search', '')!='') then
        (
        (:On recherche des utilisateurs:)
        (: on récupère les infos du formulaire:)
        let $lname := request:get-parameter('lname', '')
        let $fname := request:get-parameter('fname', '')
        let $username := request:get-parameter('username', '')
        let $uniqueID := request:get-parameter('uniqueID', '')
        (: on recherche les utilisateurs :)
        let $persons := doc(concat($collection, "Persons.xml"))//Person[contains(Username,$username)][contains(Firstname,$fname)][contains(Lastname,$lname)][contains(UniqueID,$uniqueID)]
        (:on les retournes:)
        (: si la recherche est vide on retourne <Search/> avec une <Error/> sinon la liste des utilisateurs :)
        let $test := if ($persons!='') then 
                        (
                            <Back>
                                {$persons}
                            </Back>
                        )
                        else
                        (
                            <Search>
                                <Error>No user matches the data was found.</Error>
                            </Search>
                        )
        return $test
        )
        else
        (
        (:On supprime un utilisateur:)
        )
    )
    else
    (
    (: C'est pas POST, donc on affiche la boite de recherche des utilisateurs :)
        <Search/>
    )
    return
    <Root>
        <Role>{$role}</Role>
        <Core>
            {$core}
        </Core>
    </Root>
   

