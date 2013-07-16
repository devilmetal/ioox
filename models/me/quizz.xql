xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour l'affichage du Quizz retourne le quizz et les erreurs de login
 :)
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()

let $ref := request:get-attribute('oppidum.command')/@trail
let $ref2 := substring-after(substring-after(string($ref),'/'),'/')
let $courseid := string(substring-before($ref2,'/'))

let $user := xdb:get-current-user()
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $quizz := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]/Quizz
let $isEngagInCourse := exists(doc(concat($collection, "Persons.xml"))//Engagment[CoursRef=$courseid])
                            

    return
        if($isEngagInCourse) then
            (
                $quizz
            )
            else
            (
                if($id='-1') then
                    (
                        <Error>You must be logged to access this page.</Error>
                    )
                    else
                    (   
                        <Error>You must be registred into this course to access this page.</Error>
                    )
            )
   
