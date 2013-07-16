xquery version "1.0";
(:
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour l'affichage de la page vers les pdf des cours suivits avec des Mynotes.
:)
import module namespace session="http://exist-db.org/xquery/session";

import module namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'

    return
    <Root>
        {
        (:On test si la personne est connectée:)
        if (session:get-attribute('id')) then (
                            let $id := string(session:get-attribute('id'))
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                            let $courses := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef and CourseId=$person//Note/CourseRef]
                            let $period := doc(concat($collection, "AcademicYears.xml"))//Period[Courses/Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef]]
                            return  
                                    <Courses>
                                    {$courses}
                                    {
                                    for $p in $period
                                    order by $p/Date
                                    return 
                                    <Period>
                                        {$p/Name}
                                        {$p/Start}
                                        {$p/End}
                                         {
                                        (:Retour uniquement des cours avec des notes et auquel on est enregristré:)
                                        for $c in $p/Courses/Course[CourseId=$person/Engagments//Engagment[Role!='Unsubscribed']/CoursRef and CourseId=$person//Note/CourseRef]
                                        return
                                        <Course>{$c/CourseId}{$c/CourseNo}{$c/Title}{$c/Acronym}{$person//Engagment[CoursRef=$c/CourseId]//Role}</Course>
                                        }

                                    </Period>
                                    }
                                    </Courses>
                                    
                            )
                        else(
                            <Error>You must be logged to access this page.</Error>
                            )}
     </Root>