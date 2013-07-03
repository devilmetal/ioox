xquery version "1.0";
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

    return
    <Root>
        {if (session:get-attribute('id')) then (
                            let $id := string(session:get-attribute('id'))
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                            let $courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef]
                            return <Courses>{$courses}</Courses>
                            )
                        else(
                            <Null/>
                            )}
     </Root>