xquery version "1.0";
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

let $ref := request:get-attribute('oppidum.command')/@trail
let $ref2 := substring-after(substring-after(string($ref),'/'),'/')
let $courseid := string(substring-before($ref2,'/'))
let $sessionNumber := string(substring-after($ref2,'/'))

let $user := xdb:get-current-user()
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $method := request:get-method()
let $done := if ($method='POST') then (
                (: make sure you use the right user permissions that has write access to this collection => done with the registration (group=site-member):)
                let $collection := '/db/test'
                let $filename := request:get-uploaded-file-name('file')
 
                (: make sure you use the right user permissions that has write access to this collection :)
                let $login := xdb:login($collection, 'admin', 'my-admin-password')
                let $store := xdb:store($collection, $filename, request:get-uploaded-file-data('file'))
 
            return
                <results>
                    <message>File {$filename} has been stored at collection={$collection}.</message>
                </results>
                )
            else
            <False/>
            
    (:: On va controler si la personne est bien liée au cours. Ceci va donc aussi faire preuve de controle de login
        Dans le cas d'un non-login ou que la personne n'est pas liée, l'element Root sera simplement vide::)
let $engament :=  doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]//Engagments
let $session := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid][CourseId=$engament//Engagment/CoursRef]/Sessions/Session[SessionNumber=$sessionNumber]
    return
    <Root>
        <Upload>
            {$done}
        </Upload>
        {$session}
     </Root>