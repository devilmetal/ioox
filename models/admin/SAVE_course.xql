xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xml media-type=text/xml";

declare function local:scale($string) as xs:string
{
    let $trim := replace(replace($string,'\s+$',''),'^\s+','')
    let $lowcase := lower-case($trim)
  return 
    $lowcase
};  
declare function local:createID() as xs:string
{
    let $date := current-dateTime()
    let $year := year-from-dateTime($date)
    let $month := month-from-dateTime($date)
    let $day := day-from-dateTime($date)
    let $hours := hours-from-dateTime($date)
    let $minutes := minutes-from-dateTime($date)
    let $secondes := string(seconds-from-dateTime($date))
    let $id := concat(concat(concat(concat(concat($year,$month),$day),$hours),$minutes),substring-before($secondes,'.'))
  return 
    $id
};  



let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $role := xdb:get-user-groups(xdb:get-current-user())
let $courseid := string(request:get-attribute('oppidum.command')/resource/@name)
let $param := string(request:get-parameter('id', ''))
let $periods := doc(concat($collection, "AcademicYears.xml"))//Period

let $core := if ($courseid='new') then
        (
            (:c'est la création d'un cours ou le clône:)
            let $newID := local:createID()
            return
            if ($param='') then
                (
                    (:C'est la création d'un nouveau cours:)
                    <Course>
                        <CourseId>{$newID}</CourseId>
                        <CourseNo/>
                        <Title/>
                        <Acronym/>
                        <Description/>
                        <Evaluation/>
                        <Sessions>
                            {
                            for $i in (1 to $MAXNUMBERSESSIONS)
                            return
                            <Session>
                                <SessionNumber>{$i}</SessionNumber>
                                <Topics/>
                                <Description/>
                                <Date/>
                                <StartTime/>
                                <EndTime/>
                                <Room/>
                                <Resources/>
                                <Exercise>
                                    <ExerciseId>{$i}</ExerciseId>
                                    <Description/>
                                    <Data/>
                                    <Deliverables/>
                                </Exercise>
                            </Session>
                            }
                            
                        </Sessions>
                    </Course>
                )
                else
                (
                    (:C'est le clône d'un cours existant:)
                    (:on va regarde si il existe, sinon, on va simplement afficher une erreure:)
                    let $test := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$param])
                    return
                    if ($test) then 
                        (
                            (:le cours exist et donc on peut le cloner:)
                            let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$param]
                            let $sessions := $course/Sessions
                            return 
                            <Course>
                                <CourseId>{$newID}</CourseId>
                                <CourseNo>{$course/CourseNo}</CourseNo>
                                <Title>{$course/Title}</Title>
                                <Acronym>{$course/Acronym}</Acronym>
                                <Description>{$course/Description}</Description>
                                <Evaluation>{$course/Evaluation}</Evaluation>
                                <Sessions>
                                    {
                                    for $session in $sessions
                                    return
                                        <Session>
                                            {$session/SessionNumber}
                                            {$session/Topics}
                                            {$session/Description}
                                            <Date/>
                                            {$session/StartTime}
                                            {$session/EndTime}
                                            {$session/Room}
                                            <Exercise>
                                                {$session/Exercise/ExerciseId}
                                                {$session/Exercise/Description}
                                                {$session/Exercise/Data}
                                                <Deliverables/>
                                            </Exercise>
                                        </Session>
                                    }
                                </Sessions>
                            </Course>
                        )
                        else
                        (   
                            (:on demande un cours qui n'existe pas:)
                            <Error>You asked to clone a course that does not exist</Error>
                        )
                )
        )
        else
        (
            (:c'est la modification d'un cours qui existe:)
            let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
            return 
            $course
        )

(:on prend tous les noms de periodes:)
    return
    <Root>
        <Role>{$role}</Role>
        <Core>
            {$core}
        </Core>
        <Periods>
            {for $period in $periods
            order by $period/Start descending
            return $period/Name}
        </Periods>
        <Modifier>
            <Param>{$param}</Param>
            <CourseId>{$courseid}</CourseId>
        </Modifier>
    </Root>
   

