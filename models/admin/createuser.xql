xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $core := if($method='POST') then 
                (
                (: on cree un utilisateurs si les conditions usuelles sont remplies, sinon on retour les erreurs avec les valeurs des formulaires :)
                     (: on reprend les paramêtres :)
                     let $lname := request:get-parameter('lname', '')
                     let $fname := request:get-parameter('fname', '')
                     let $username := request:get-parameter('username', '')
                     let $uniqueID := request:get-parameter('uniqueID', '')
                     
                     (:Création d'un mot de passe par hash md5 de la date courrante et subtring :)
                     let $curr-date := fn:current-date()
                     let $hash :=  util:hash($curr-date, 'md5')
                     let $password := substring($hash,1,8)
                     
                     (: on crée un nouvel id, on prend le max et on ajoute 1:)
                     let $persons := doc(concat($collection, "Persons.xml"))//Persons
                     let $personid := max($persons//Person/PersonId)+1
                     
                     (: ----------------- TESTS --------------- :)
                     (: ils réussissent si tout va bien :)
                     let $usertest := xdb:exists-user($username)
                     let $lnametest := $lname != ''
                     let $fnametest := $fname != ''
                     let $uniqueIDtest := $uniqueID != ''
                     let $iamadmin := $role='dba'
                     
                     
                     (: ----------------- AFFICHAGE SELON LES TESTS --------------- :)
                     (: test si l'username existe déjà, il doit être unique pour la database et le login :)
                     let $usernameForm := if ($usertest) then 
                        (
                        <Username>
                            <Text>{$username}</Text>
                            <Error>This username already exists</Error>
                        </Username>
                        ) 
                        else 
                        (
                        <Username><Text>{$username}</Text></Username>
                        )
                     (: test si le nom est vide :)
                     let $lastnameForm := if (not($lnametest)) then 
                        (
                        <Lastname>
                            <Text>{$lname}</Text>
                            <Error>Lastname can not be empty</Error>
                        </Lastname>
                        ) 
                        else 
                        (
                        <Lastname><Text>{$lname}</Text></Lastname>
                        )
                      (: test si le nom est vide :)
                     let $fistnameForm := if (not($fnametest)) then 
                        (
                        <Firstname>
                            <Text>{$fname}</Text>
                            <Error>Firstname can not be empty</Error>
                        </Firstname>
                        ) 
                        else 
                        (
                        <Firstname><Text>{$fname}</Text></Firstname>
                        )
                      (: l' uniqueID doit être non vide :)
                      let $uniqueIDForm := if (not($uniqueIDtest)) then 
                        (
                        <UniqueID>
                            <Text>{$uniqueID}</Text>
                            <Error>Unique ID can not be empty</Error>
                        </UniqueID>
                        ) 
                        else 
                        (
                        <UniqueID><Text>{$uniqueID}</Text></UniqueID>
                        )
                      
                      (: ------------ EXECUTION DE LA QUERY POUR LE SAVE DE L'UTILISATEUR SI LES TESTS SONT OK ----------------:)
                      let $query := if(not($usertest) and $lnametest and $fnametest and $uniqueIDtest and $iamadmin) then 
                        (
                        (:on crée l'utilisateur:)
                        let $create := xdb:create-user($username,$password,'site-member','')
                        let $exists := xdb:exists-user($username)
                        let $query := if($exists) then 
                            (
                            (: on l'ajout à la DB du site :) 
                            let $persons := doc(concat($collection, "Persons.xml"))//Persons
                            let $query := update insert <Person>
                                                            <PersonId>{$personid}</PersonId>
                                                            <Lastname>{$lname}</Lastname>
                                                            <Firstname>{$fname}</Firstname>
                                                            <Username>{$username}</Username>
                                                            <UniqueID>{$uniqueID}</UniqueID>
                                                            <Engagments/>
                                                            <ToDoList>
                                                                <Activity/>
                                                            </ToDoList>
                                                            <Notes/>
                                                            <Tokken/>
                                                        </Person> into $persons
                            return 'pass'
                            )
                            else
                            (
                            'notpassinsert'    
                            )
                            
                        return $query    
                        
                        ) 
                        else 
                        (
                        'notpassquery'
                        )
                      
                      
                     (: retours pour l'affichage :)
                     return 
                     if ($query = 'notpassquery') then (
                     <Form>
                        {$usernameForm}
                        {$fistnameForm}
                        {$lastnameForm}
                        {$uniqueIDForm}
                        {$query}
                     </Form>
                     )
                     else if ($query = 'notpassinsert') then( 
                            <Form>
                                {$usernameForm}
                                {$fistnameForm}
                                {$lastnameForm}
                                {$uniqueIDForm}
                                <Error>Something went wrong while creating user. Please retry</Error>
                            </Form> 
                          )
                     else (
                            <Done>
                                <Username>{$username}</Username>
                                <Password>{$password}</Password>
                            </Done> 
                     
                     )
                ) 
                else 
                (
                (: nothing to do we return an empty formual:)
                <Form>
                    <Username><Text>Username</Text></Username>
                    <Firstname><Text>Firstname</Text></Firstname>
                    <Lastname><Text>Lastname</Text></Lastname>
                    <UniqueID><Text>UniqueID</Text></UniqueID>
                </Form>
                )

    return
    <Root>
        <Role>{$role}</Role>
        <Core>
            {$core}
        </Core>
    </Root>
   

