xquery version "1.0";

import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";

(: Si la note existe avec les coordonnées données dans la page, on l'affiche directement.
    SINON : On crée la note (update insert) et on va la rechercher pour l'afficher pour la modifier par la suite
    ON DOIT VERIFIER : l'utilisateur est bien inscrit au cours :)
    
let $collection := '/sites/ioox/data/'
let $ref := request:get-attribute('oppidum.command')/@trail
let $ref2 := substring-after(substring-after(string($ref),'/'),'/')
let $courseid := string(substring-before($ref2,'/'))
let $sessionNumber := string(substring-after($ref2,'/'))
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]

(: 1 On test si une note existe déjà :)
let $noteExist := exists($person//Notes/Note[CourseRef=$courseid][SessionRef=$sessionNumber])

(: 2 On test si la personne est enregristrée au cours (et par la même occasion si la combinaison des IDs cours/session existe bien) :)
let $courseTest := exists($person/Engagments/Engagment[CoursRef=$courseid]) and exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]//Session[SessionNumber=$sessionNumber])

let $query := if (not($noteExist) and $courseTest) then
                (
                (: la note n'existe pas mais la combinaison existe, donc on la crée :)
                update insert <Note><NoteId>{concat(concat($id,$courseid),$sessionNumber)}</NoteId><CourseRef>{$courseid}</CourseRef><SessionRef>{$sessionNumber}</SessionRef><Content><Parag><Fragment/></Parag></Content></Note> into $person/Notes
                )
                else
                ()
let $note := $person//Note[CourseRef=$courseid][SessionRef=$sessionNumber]
let $courseName := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]/Title/text()
let $sessionTopic := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]//Session[SessionNumber=$sessionNumber]/Topics
let $sessions := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]//Sessions

(: pour les boutons de navigations :)
let $next-topic1 := $person//Notes/Note[CourseRef=$courseid][SessionRef>$sessionNumber]
let $next-topic := $next-topic1//Note[SessionRef=min(SessionRef)]/SessionRef/text()
let $prev-topic1 := $person//Notes/Note[CourseRef=$courseid][SessionRef<$sessionNumber]
let $prev-topic := $prev-topic1//Note[SessionRef=max(SessionRef)]/SessionRef/text()

    return
    <Root>
     {$note}
     
     <NoteInfos>
        <CourseName>{$courseName}</CourseName>
        <SessionTopic>{$sessionTopic}</SessionTopic>
        <LastEdit>{xdb:last-modified('/sites/ioox/data/','Persons.xml')}</LastEdit>
        <PrevT>{$prev-topic}</PrevT>
        <NextT>{$next-topic}</NextT>
     </NoteInfos>
     </Root>
   
