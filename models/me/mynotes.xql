xquery version "1.0";
(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Retrive data for the current user and current cours where exist a note
:)
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
(:connected or not:)
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
let $notes  := $person/Notes
let $engagments := $person//Engagments

(: old call ==> let $usables-courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$notes//Note/CourseRef]:)
(:  retrive cours engagements where i'm engaged and my role isn't unsubscribed:)
let $usables-courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$engagments//Engagment[Role != 'Unsubscribed']/CoursRef]

(:  retrive the note :)
let $period := doc(concat($collection, "AcademicYears.xml"))//Period[Courses/Course/CourseId=$notes//Note/CourseRef]
                            

    return
    <Root>
     {$usables-courses}
     <Periods>
     {
     for $p in $period
     order by $p/Date
     return
     <Period>
        {$p/Name}
        {$p/Start}
        {$p/End}
        {
        for $c in $period/Courses/Course
        (:This where grant to print only course where at last 1 session note is make:)
        where $c/CourseId=$notes//Note/CourseRef  
        return
        <Course>{$c/CourseId}{$c/CourseNo}{$c/Title}{$c/Acronym}</Course>
        }
        
     </Period>
     }
     </Periods>
     <Session>
        <Id>
            {$id}
        </Id>
     </Session>
     </Root>
   
