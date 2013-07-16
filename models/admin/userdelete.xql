xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour la page de suppression d'utilisateurs
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";

declare function local:scale($string) as xs:string
{
    let $trim := replace(replace($string,'\s+$',''),'^\s+','')
    let $lowcase := lower-case($trim)
  return 
    $lowcase
};  

let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
(:on controle aussi si la personne est bien un admin avant de chercher les données:)
let $core := if ($method='POST' and $role='dba') then 
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
        let $persons := doc(concat($collection, "Persons.xml"))//Person[contains(local:scale(Username),local:scale($username))][contains(local:scale(Firstname),local:scale($fname))][contains(local:scale(Lastname),local:scale($lname))][contains(local:scale(UniqueID),local:scale($uniqueID))]
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
        (:SUPPRESSION:)
        (:On supprime un utilisateur:)
        let $username := request:get-parameter('username', '')
        
        (:Supression de la base de donnée:)
        let $test1 := exists(doc(concat($collection, "Persons.xml"))//Person[Username=$username])
        (:si l'utilisateur est dans la BD, normalement c'est le cas... alors on supprime:)
        let $BDdelete := if($test1) then 
                    (
                    let $query := update delete doc(concat($collection, "Persons.xml"))//Person[Username=$username]
                    return <Message>The user has been deleted from the Database</Message>
                    ) 
                    else 
                    (
                    <Message>The user was not in the Database. But it is ok.</Message>
                    )
        (:Supression de l'utilisateur base de donnée eXist:)
        let $test2 := xdb:exists-user($username)
        let $eXistDelete := if ($test2) then 
                    (
                        let $query := xdb:delete-user($username)
                        return <Message>The eXist user has been deleted</Message>
                    )
                    else
                    (
                        <Message>The user was not an eXist user. But it is ok.</Message>
                    )
        return  <Search>
                    {$BDdelete}
                    {$eXistDelete}
                </Search>
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
   

