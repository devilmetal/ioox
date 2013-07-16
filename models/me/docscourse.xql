xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour la génération du PDF des Mynotes d'un cours.
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()

(: Récupération de l'ID de la personne connectée :)
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                      
(: Récupération de l'ID du cours:)
let $ref := request:get-attribute('oppidum.command')/resource/@name
let $courseid := string($ref)

(: Récupération du cours :)
let $courseBase := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
let $isAcourse := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid])
(:test pour savoir si la personne a des mynotes pour ce cours:)
let $asNotes := exists($person//Note[CourseRef=$courseid])
    return
        <Root>
        {
        if ($isAcourse) then 
            (
            if ($asNotes) then
                (
                    let $notesInOrder := 
                                        <Notes>
                                            {
                                                (:Retour des mynotes mis en ordre suivant les dates des sessions.:)
                                                let $sessions := $courseBase//Sessions
                                                for $session in $sessions/Session
                                                order by $session/Date
                                                return
                                                    (
                                                    let $sessionid := $session/SessionNumber
                                                    let $asNote := exists($person//Note[CourseRef=$courseid][SessionRef=$sessionid])
                                                    return
                                                        <Note>
                                                            {$session/Topics}
                                                            {$person//Note[CourseRef=$courseid][SessionRef=$sessionid]/Content}
                                                        </Note>
                                                    )
                                            }
                                        </Notes>
                    return
                    <Data>
                        {$courseBase/Title}
                        {$courseBase/CourseNo}
                        {$notesInOrder}
                    </Data>
                )
                else
                (
                    <Error>You have no mynotes for this course.</Error>
                )
            )
            else
            (
                <Error>This is not a valid course.</Error>
            )
        }
        </Root>
        
    
