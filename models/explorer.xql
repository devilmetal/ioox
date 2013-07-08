xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
                            

let $search := if($method = 'GET') then (

    (: retirive GET parameter and filtre him :)
    let $tmp := request:get-parameter('search','')
    
    let $data := doc(concat($collection, "AcademicYears.xml"))//Course[contains(upper-case(Title),upper-case($tmp)) or contains(upper-case(Acronym),upper-case($tmp)) or contains(upper-case(CourseNo),upper-case($tmp))]
    return
        <Search>
        <Query>{$tmp}</Query>
        <Period><Courses>{$data}</Courses></Period></Search>
)else(
        <Search/>
)
    
    
let $data0 := doc(concat($collection, "AcademicYears.xml"))//Period[$curr-date >= ./End] 
let $data1 := doc(concat($collection, "AcademicYears.xml"))//Period[($curr-date >= ./Start) and ($curr-date <= ./End)]
let $data2 := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments
let $data3 := doc(concat($collection, "Persons.xml"))//Person/Engagments/Engagment[Role='Tutor' or Role='Teacher']/ancestor::Person

    return
    <Root>
        
        
        
        <PastPeriod>
        {   for $p in doc(concat($collection, "AcademicYears.xml"))//Period[$curr-date >= ./End] 
            order by $p/End descending
            return $p
         }
        </PastPeriod>
        <CurrentPeriod>{$data1}</CurrentPeriod>
        <Person>{$data2}</Person>
        <Teacher>{$data3}</Teacher>
        
        
        
        <Session>
            <Connected>{session:get-attribute('id')}</Connected>
            <ID>{$id}</ID>
        </Session>
        {$search}
    </Root>
   

