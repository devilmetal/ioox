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
   (:: On va controler si la personne est bien liée au cours. Ceci va donc aussi faire preuve de controle de login
        Dans le cas d'un non-login ou que la personne n'est pas liée, l'element Root sera simplement vide::)
let $engament :=  doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]//Engagments
let $session := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid][CourseId=$engament//Engagment[Role!='Unsubscribed']/CoursRef]/Sessions/Session[SessionNumber=$sessionNumber]

let $method := request:get-method()
let $done := if ($method='POST') then (
                (: make sure you use the right user permissions that has write access to this collection => done with the registration (group=site-member):)
                let $collection := concat(concat(concat('/db/courses/',$courseid),'/'),$sessionNumber)
                let $filename := string(replace(request:get-uploaded-file-name('file'), ' ', '%20'))
 
                (: make sure you use the right user permissions that has write access to this collection 
                let $login := xdb:login($collection, 'admin', 'my-admin-password'):)
                let $store := xdb:store($collection, $filename, request:get-uploaded-file-data('file'),'application/octet-stream')
 		(: From here, the file has been stored into the database, we must now upload the info into the Course element :)
		let $newDeliv := <Deliverable><PersonRef>{$id}</PersonRef><File><LinkText>{$filename}</LinkText><LinkRef>/exist/rest//db/courses/{$courseid}/{$sessionNumber}/{$filename}</LinkRef></File></Deliverable>
		let $query := if (exists($session/Exercise/Deliverables/Deliverable[PersonRef=$id]))
		then (
		      (:remove the current document if it exists :)
		      if(exists(doc(concat($collection,$session/Exercise/Deliverables/Deliverable[PersonRef=$id]/File/LinkText)))) then (
		      xdb:remove($collection,$session/Exercise/Deliverables/Deliverable[PersonRef=$id]/File/LinkText)
		      )
		          else
		              ((:if the docuement does not exist, we do not have to delete it :)),
		      (:update the status:)
		      update replace $session/Exercise/Deliverables/Deliverable[PersonRef=$id] with $newDeliv)
		      
		else (update insert $newDeliv into $session/Exercise/Deliverables)
            return
                <results>
                    <message>File {$filename} has been stored.</message>
                </results>
                )
            else
            <False/>
let $docCollection := concat(concat(concat(concat('/db/courses/',$courseid),'/'),$sessionNumber),'/')
let $docName := $session//Deliverables/Deliverable[PersonRef=$id]/File/LinkText/text()
let $docLink := $session//Deliverables/Deliverable[PersonRef=$id]/File/LinkRef/text()

let $previousDocumentTime := 'na' (:if(exists(concat($docCollection,$docName))) then (xdb:last-modified($docCollection,$docName)) else ('na'):)        
 
    return

    <Root>
        <Upload>
            {$done}
        </Upload>
        {$session}
	<Infos>
		<CurrentUserId>
		{$id}
		</CurrentUserId>
		<CourseId>
		{$courseid}
		</CourseId>
		<SessionId>
		{$sessionNumber}
		</SessionId>
	</Infos>
	<PreviousInfos>
	   <Name>{$docName}</Name>
	   <Link>{$docLink}</Link>
	   <Date>{$previousDocumentTime}</Date>
	</PreviousInfos>
		
     </Root>
