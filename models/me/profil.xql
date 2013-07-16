xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL l'affichage du profil. Permet aussi de sauvegrader ce qui doit l'être en cas de POST. Il calcule aussi le hash pour le profile gravatar et le retourne sous forme XML.
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

import module namespace session="http://exist-db.org/xquery/session";
declare option exist:serialize "method=xml media-type=text/xml";

let $collection := '/sites/ioox/data/'
let $method := request:get-method()


let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]                            
let $username := $person/Username                   
                            
(: si on a un POST, on va modifier ce qui doit être fait 
    1) Nom et prénom
    2) password si il est répété 2 fois la même :)
    
let $query := if($method = 'POST') then (
    (: on récupère les paramêtres :)
    let $fname := request:get-parameter('f_name', '')
    let $pass1 := request:get-parameter('pass1', '')
    let $pass2 := request:get-parameter('pass2', '')
    return
    (: cas 2) :)
    if($pass1=$pass2) then 
        (
        (: on change le pass, on délog et on relog :)
        xdb:change-user($username,$pass1,'site-member',''),
        xdb:login("/db", "guest", "guest"),
        xdb:login("/db",$username,$pass1,true()),
        session:set-attribute('id', doc(concat($collection, "Persons.xml"))//Person[Username=$username]/PersonId/text())
        )
        else
        (
        if($pass2='') then () else (
        <error/>)
        )
    ) else ((:nothing to do:))

let $queryFname := if($method = 'POST') then (
    (: on récupère les paramêtres :)
    let $fname := request:get-parameter('f_name', '')
    return
    update replace $person/Firstname with <Firstname>{$fname}</Firstname>
    ) else ((:nothing to do:))
let $queryLname := if($method = 'POST') then (
    (: on récupère les paramêtres :)
    let $lname := request:get-parameter('l_name', '')
    return
    update replace $person/Lastname with <Lastname>{$lname}</Lastname>
    ) else ((:nothing to do:))
let $queryGravatar := if($method = 'POST') then (
    (: on récupère les paramêtres :)
    let $gravemail := request:get-parameter('gravemail', '')
    return
    update replace $person/GravatarEmail with <GravatarEmail>{$gravemail}</GravatarEmail>
    ) else ((:nothing to do:))
    
(:Calcul du Hash gravatar pour récupérer le profile.:)
let $gravemail := $person/GravatarEmail
let $trim := replace(replace($gravemail,'\s+$',''),'^\s+','')
let $lowcase := lower-case($trim)
let $md5 := util:hash($lowcase, 'md5')
let $gravatarURI := concat(concat('http://fr.gravatar.com/',$md5),'.xml')
(:Profile Gravatar:)
let $gravatarRespons := doc($gravatarURI)

    return
    <Root>
        {$person}
        <GravatarHash>
            {$gravatarRespons}
        </GravatarHash>
        <session>
            {$id}
        </session>
        {$query}
    </Root>
   
