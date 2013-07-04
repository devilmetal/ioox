xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";

let $collection := '/sites/ioox/data/'

    return
    <Root>
        {if (session:get-attribute('id')) then (
                            let $id := string(session:get-attribute('id'))
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                            let $grades := $person//Engagment[Grade]
                            
                            (: NOTE : on retourne les cours classés par periode et uniquement les cours dont la personne possède un engagment (inscrit, desinscrit) :)
                            let $periods := doc(concat($collection, "AcademicYears.xml"))//Period[.//Course[CourseId=$person/Engagments//Engagment/CoursRef]]
                            return <Infos>
                                        <Periods>{
                                            for $period in $periods//Period
                                            return
                                            (
                                            <Period>
                                            <Name>{$period/Name/text()}</Name>
                                            <Courses>
                                                {$period//Course[CourseId=$person/Engagments//Engagment/CoursRef]}
                                            </Courses>
                                            </Period>
                                            )}
                                         </Periods>
                                        <Grades>{$grades}</Grades>
                                   </Infos>
                            )
                        else(
                            <Null/>
                            )}
     </Root>
