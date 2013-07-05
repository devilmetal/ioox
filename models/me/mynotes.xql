xquery version "1.0";

import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace xdb="http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $id :=  if ($method = 'POST') then (
                            request:get-parameter('coursid', '')
                            )
                        else(
                            1
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
let $notes  := $person/Notes
let $engagments := $person//Engagments

(:let $usables-courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$notes//Note/CourseRef]:)
let $usables-courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$engagments//Engagment[Role != 'Unsubscribed']/CoursRef]

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
        return
        <Course>{$c/CourseId}{$c/CourseNo}{$c/Title}{$c/Acronym}</Course>
        }
        
     </Period>
     }
     </Periods>
     </Root>
   
