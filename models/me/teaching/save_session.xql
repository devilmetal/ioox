xquery version "1.0";
(: --------------------------------------
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      This query retrive and save the session edits
   -------------------------------------- :)
import module namespace session="http://exist-db.org/xquery/session";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace response = "http://exist-db.org/xquery/response";
import module namespace oppidum = "http://oppidoc.com/oppidum/util" at "../../../../oppidum/lib/util.xqm";
import module namespace text = "http://exist-db.org/xquery/text";
import module namespace util = "http://exist-db.org/xquery/util";

declare option exist:serialize "method=text media-type=text/plain indent=no";

(: Accepted file extensions normalized to construct an application/"ext" Mime Type string :)
declare variable $accepted-extensions := ('pdf');

(: FIXME: the request API does not allow to directly get file extension, hence we try to deduce it from the file name :)
declare function local:get-extension( $fname as xs:string ) as xs:string
{
  let $fn := normalize-space($fname)
  let $unparsed-extension := lower-case( (text:groups($fn, '\.(\w+)$'))[2] )
  return $unparsed-extension
};

(: ======================================================================
   Checks extension is a compatible file type.
   ======================================================================
:)declare function local:check-extension( $ext as xs:string ) as xs:string
{
  if ( empty(fn:index-of($accepted-extensions, $ext)) ) 
  then concat('Vous ne pouvez pas télécharger un fichier de format ', $ext, ' à cet emplacement')
  else 'ok'
};

(: ======================================================================
   Creates the 'images' collection with an 'index.xml' resource with a 
   LastIndex attribute inside the collection $home-uri if they do not 
   already exist, returns the path to the created collection.
   ======================================================================
:)
declare function local:create-collection-lazy ( $home-uri as xs:string, $user as xs:string, $group as xs:string ) as xs:string*
{
  let $path := concat($home-uri, '/docs')
  return
    if (xdb:collection-available($path)) then
      $path
    else
      if (xdb:create-collection($home-uri, 'docs')) then (
        xdb:set-collection-permissions($path, $user, $group, util:base-to-integer(0744, 8)),
        $path
        )[last()]
      else
        ()
};

declare function local:gen-error( $msg as xs:string, $status as xs:integer ) as xs:string {
  (: Shouldn't we use oppidum:render-error instead to make error messages configurable ? :)
  let $do1 := response:set-header('Content-Type', 'text/plain; charset=UTF-8')
  let $do2 := response:set-status-code($status)
  return $msg
};

(: ======================================================================
   Returns the relative path to the file that would be (preflight)
   or has been created (upload). The path always starts with "docs/"
   ======================================================================
:)
declare function local:gen-success( $id as xs:string, $ext as xs:string ) as xs:string {
  let $full-path := 'docs/'
  let $do := response:set-header('Content-Type', 'text/plain; charset=UTF-8')
  return
    concat($full-path, $id, '.', $ext)
};

(: ======================================================================
   Creates the image file into the database and update the LastIndex
   Generates the file name from the $cur-index.
   Pre-condition: $cur-index attribute MUST contain a number
   ======================================================================
:)
declare function local:do-upload( 
  $col-uri as xs:string,
  $user as xs:string,
  $group as xs:string, 
  $id as xs:string,
  $data as xs:base64Binary, 
  $ext as xs:string ) as xs:string
{
  let $filename := concat(normalize-space($id), '.', $ext)
  let $mime-type := concat('application/', $ext)
  let $log := oppidum:debug(('files/upload.xql creating file ', string($id), ' with mime-type ', string($mime-type)))
  return
    if (xdb:store($col-uri, $filename, $data, $mime-type)) then
      (
      xdb:set-resource-permissions($col-uri, $filename, $user, $group, util:base-to-integer(0774, 8)),
      (: update replace $cur-index with attribute LastIndex { number($id) +1 },:)
      response:set-status-code(201),
      (: response:set-header('Location', concat('/docs/', $id, '.', $ext)), :)
      local:gen-success(normalize-space($id), $ext)
      )[last()]
    else
      local:gen-error("Erreur interne lors de la sauvegarde du document, réessayez avec une autre", 400)
};

(: ======================================================================
   Returns 'ok' if the proposed name is valid and no other resource with the same name 
   already exists in the "docs/" collection, otherwise returns an error message.
   ======================================================================
:)
declare function local:validate-name( $name as xs:string ) as xs:string {
  if (string-length($name) = 0) then
    'Vous devez spécifier un nom pour enregistrer le document sur le serveur'
  else
    
    let $new := request:get-data()
    let $sid := $new//Session//SessionNumber   
    let $ref := request:get-attribute('oppidum.command')/@trail
    let $courseid := tokenize($ref,'/')[3]
            
    let $col-ref := concat('/courses/',$courseid,'/',$sid)
    let $doc-uri := concat($col-ref, '/docs/', $name, '.pdf')
(:    let $log  := oppidum:debug(('checking ', $doc-uri) ):)
    return
      if (util:binary-doc-available($doc-uri)) then
        concat('Il existe déjà un document “',$name, '” sur le serveur, proposez un autre nom')
      else
        'ok'
};

(: ======================================================================
   TODO: manage case without xt-file-id (i.e. no preflight)
   ======================================================================
:)
declare function local:upload( $user as xs:string, $group as xs:string, $id as xs:string ) as xs:string {
  (: get uploaded file binary stream :)
  let $data := request:get-uploaded-file-data('xt-file')
  return        
    if (not($data instance of xs:base64Binary)) 
      then local:gen-error('Le fichier téléchargé est invalide', 400)
    else
      (: check file binary stream has compatible MIME-TYPE :)
      let 
        $filename := request:get-uploaded-file-name('xt-file'),
        $ext:= local:get-extension($filename),        
        $mime-check := local:check-extension($ext)
      return
        if ( $mime-check != 'ok' ) 
          then local:gen-error($mime-check, 400)
          else 
            (: creates docs collection if it does not exist yet :)
            (:Note : the collection here is recreated:)
            
            let $new := request:get-data()
            let $sid := $new//Session//SessionNumber   
            let $ref := request:get-attribute('oppidum.command')/@trail
            let $courseid := tokenize($ref,'/')[3]
            
            let $col-ref := concat('/courses/',$courseid,'/',$sid)
            let $col-uri := local:create-collection-lazy($col-ref, $user, $group)
            return
              if (not(xdb:collection-available($col-uri)))
                then local:gen-error("Erreur sur le serveur: impossible de créer la collection pour recevoir le document", 500)
                else local:do-upload($col-uri, $user, $group, $id,  $data, $ext)
};



declare option exist:serialize "method=xml media-type=text/xml";

(:::::::::::::  BODY  ::::::::::::::)

let $collection := '/sites/ioox/data/'
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]

let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $cmd := request:get-attribute('oppidum.command')
let $new := request:get-data()
let $sid := $new//Session//SessionNumber
let $old := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]//Session[SessionNumber=$sid]
let $new2 := $new//Session
let $tosave := <Session>
                    {$new2/SessionNumber}
                    <Topics>
                    {
                        for $topic in $new2/Topics/Topic
                        return
                        <Topic>
                            {$topic/Title}
                            <Ressources>
                            {$topic/Ressources/Ressource[Link]}
                            {
                            for $ressource in $topic/Ressources/Ressource[ExternalDoc]
                            return
                            <Ressource> 
                                <ExternalDoc>
                                    <Title>{string($ressource/ExternalDoc/LinkRef/Attachments/PDFLink/LinkRef/@data-input)}</Title>
                                    <URL>{concat('/exist/rest//db/courses/',$courseid,'/',$sid,'/',$ressource/ExternalDoc/LinkRef/Attachments/PDFLink/LinkRef)}</URL>                 
                                </ExternalDoc>
                            </Ressource>
                            }
                            </Ressources>
                        </Topic>
                    }
                    </Topics>
                    {$new2/Description}
                    {$new2/Date}
                    {$new2/StartTime}
                    {$new2/EndTime}
                    {$new2/Room}
                    {
                        let $test := exists($new2//Exercise)
                        return
                            if ($test) then
                                (
                                    <Exercise>
                                        { if (exists($old/Exercise/ExerciceId)) then 
                                        ($old/Exercise/ExerciceId)
                                        else 
                                        (<ExerciceId>{concat($courseid,'s',$sid)}</ExerciceId>)
                                        }
                                        {$new2/Exercise/Description}
                                        <Data>
                                            {$new2/Exercise/Data//Link}
                                            {
                                                for $ExtDoc in $new2/Exercise/Data//ExternalDoc
                                                    return
                                                    <ExternalDoc>
                                                        <Title>{string($ExtDoc/LinkRef/Attachments/PDFLink/LinkRef/@data-input)}</Title>
                                                        <URL>{concat('/exist/rest//db/courses/',$courseid,'/',$sid,'/',$ExtDoc/LinkRef/Attachments/PDFLink/LinkRef)}</URL>
                                                    </ExternalDoc>
                                            }
                                        </Data>
                                        {
                                            let $test := exists($old/Exercise/Deliverables/Deliverable)
                                            return
                                            if ($test) then
                                                (
                                                    $old/Exercise/Deliverables
                                                )
                                                else
                                                (
                                                    <Deliverables/>
                                                )
                                        }
                                    </Exercise>
                                )
                                else
                                ((:Rien à faire:))
                        
                    }
                </Session>
                
        return (
        update replace $old with $tosave,
        oppidum:add-message('ACTION-UPDATE-SUCCESS', '', true()),
        response:set-status-code(201),
        response:set-header('Location', concat($cmd/@base-url, $cmd/@trail, if ($cmd/@type='collection') then '/' else ''))
        )
