xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]

let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
(:Test pour savoir si le cours existe:)                            
let $isAcourse := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid])

(:Test pour savoir si des étudiants sont incrits au cours :)
let $engagments := doc(concat($collection, "Persons.xml"))//Person/Engagments/Engagment[Role='Student'][CoursRef=$courseid]
let $hasStudent := exists($engagments)     
(:Test pour savoir si on est un prof inscrit pour ce cours:)
let $teacherCount := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Teacher' or Role='Tutor'][CoursRef=$courseid])
let $isTeacher := $teacherCount>0
(:Traitement des erreurs si il y a lieu:)
let $backHasStudent := if ($hasStudent) then () else (<Message>No student has suscribed in your course yet.</Message>)
let $backIsACourse := if ($isAcourse) then () else (<Error>This is not a valid course.</Error>)
let $backIsTeacher := if ($isTeacher) then () else (<Error>You are not a teacher for this course.</Error>)


    return
        (:on test si il y a bien des engagments si on est connecté en tant que prof pour ce cours et si un tel cours exist:)
        if ($hasStudent and $isAcourse and $isTeacher) then 
            (
            <Root>
            <CourseId>{$courseid}</CourseId>
            <Students>
            {
            for $engagment in $engagments
            return
                <Student>
                    {$engagment/ancestor::Person/Lastname}
                    {$engagment/ancestor::Person/Firstname}
                    {$engagment/ancestor::Person/PersonId}
                    {$engagment/ancestor::Person/UniqueID}
                </Student>
            }
            <Trail>{string($ref)}</Trail>
            </Students>
            </Root>
            )
            else
            (
            (:Il y a un erreure:)
            <Root>
                <CourseId>{$courseid}</CourseId>
                {$backHasStudent}
                {$backIsACourse}
                {$backIsTeacher}
            </Root>
            )
   
