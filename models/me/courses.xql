xquery version "1.0";
(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Retrive data for the rappresentation of all subscribed courses
:)
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

(:  if the user is logeged retrive his ID and his personal information from the database
    second retrive all course where is engaged and not unsubscribed
    retrive the information of the period.
    
    In the for will be unified the information between the engagement and the person for return a structure Period/ info period + course subscribed of the period:)
    return
    <Root>
        {if (session:get-attribute('id')) then (
                            let $id := string(session:get-attribute('id'))
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                            let $courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef]
                            let $period := doc(concat($collection, "AcademicYears.xml"))//Period[Courses/Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef]]
                            return  
                                    <Courses>
                                    {$courses}
                                    {
                                    for $p in $period
                                    order by $p/Start descending
                                    return 
                                    <Period>
                                        {$p/Name}
                                        {$p/Start}
                                        {$p/End}
                                         {
                                        for $c in $p/Courses/Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef]
                                        return
                                        <Course>{$c/CourseId}{$c/CourseNo}{$c/Title}{$c/Acronym}{$person//Engagment[CoursRef=$c/CourseId]//Role}</Course>
                                        }

                                    </Period>
                                    }
                                    </Courses>
                                    
                            )
                        else(
                            <Null/>
                            )}
     </Root>