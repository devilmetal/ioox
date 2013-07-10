xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";

let $collection := '/sites/ioox/data/'

    return
    <Root>
        {
        if (session:get-attribute('id')) then (
                            let $id := string(session:get-attribute('id'))
                            let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                            let $engagment := $person//Engagment[Role='Student']
                            
                            (: NOTE : on retourne les cours classés par periode et uniquement les cours dont la personne possède un engagment (inscrit, desinscrit) :)
                            let $periods := doc(concat($collection, "AcademicYears.xml"))//Period[.//Course[CourseId=$person/Engagments//Engagment[Role='Student']/CoursRef]]
                            return <Infos>
                                        <Periods>
                                            {
                                            for $period in $periods
                                            order by $period/Start
                                            return
                                            (
                                            <Period>
                                            <Name>{$period/Name/text()}</Name>
                                            <Courses>
                                                {
                                                let $courses := $period/Courses/Course[CourseId=$engagment//CoursRef]
                                                return 
                                                  for $course in $courses
                                                    let $courseId := $course/CourseId
                                                    let $exam := exists($course/Evaluation/Exam)
                                                    let $exercice := exists($course/Evaluation/Exercices)
                                                    let $project := exists($course/Evaluation/Project)
                                                    return
                                                    <Course>
                                                        {$course/CourseId}
                                                        <CourseTitle>{$course/CourseNo/text()} - ({$course/Acronym/text()}) {$course/Title/text()}</CourseTitle>
                                                        {
                                                        if($exam) then
                                                            (
                                                                <ExamGrade>
                                                                    <Grade>{$engagment[Role='Student'][CoursRef=$courseId]/Grade/ExamGrade/text()}</Grade>
                                                                    {$course/Evaluation/Exam/Weight}
                                                                </ExamGrade>
                                                            )
                                                            else
                                                            (
                                                                (:Pas d'examen pour ce cours:)
                                                            )
                                                        }
                                                        {
                                                        if($project) then
                                                            (
                                                                let $projectgrade := exists($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades)
                                                                return
                                                                    <ProjectGrades>
                                                                        {$course/Evaluation/Project/Weight}
                                                                        {
                                                                        if ($projectgrade) then 
                                                                            (
                                                                                <Grades>
                                                                                    <ProjectMean>
                                                                                      {
                                                                                        (:moyene pour le projet:)
                                                                                        let $meanTest :=    $engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ReportGrade != '' or
                                                                                                            $engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/PresentationGrade != '' or
                                                                                                            $engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ProjectGrade != ''
                                                                                        return
                                                                                        if($meanTest) then 
                                                                                            (
                                                                                                (:on transforme les string en number:)
                                                                                                let $ReptGrade := if ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ReportGrade!='') then ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ReportGrade/text()) else (0)
                                                                                                let $PersGrade := if ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/PresentationGrade!='') then ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/PresentationGrade/text()) else (0)
                                                                                                let $ProjGrade := if ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ProjectGrade!='') then ($engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ProjectGrade/text()) else (0)
                                                                                                
                                                                                                (:calcule des pourcentages:)
                                                                                                let $reptW := $course/Evaluation/Project/Report/Weight
                                                                                                let $PresW := $course/Evaluation/Project/Presentation/Weight
                                                                                                let $ProjW := $course/Evaluation/Project/Project/Weight
                                                                                                let $totalsum := $reptW + $PresW + $ProjW
                                                                                                
                                                                                                let $reptPerc := $reptW div $totalsum
                                                                                                let $presPerc := $PresW div $totalsum
                                                                                                let $projPerc := $ProjW div $totalsum
                                                                                               
                                                                                                return
                                                                                                (   ($ReptGrade * $reptPerc) +
                                                                                                    ($PersGrade * $presPerc) +
                                                                                                    ($ProjGrade * $projPerc) )                                                                                             )
                                                                                            else 
                                                                                            (
                                                                                                (:Pas encore de note entrée pour le project:)
                                                                                            )
                                                                                     }
                                                                                    </ProjectMean>
                                                                                    <ReportGrade>{$engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ReportGrade/text()}</ReportGrade>
                                                                                    <PresentationGrade>{$engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/PresentationGrade/text()}</PresentationGrade>
                                                                                    <ProjectGrade>{$engagment[Role='Student'][CoursRef=$courseId]/Grade/ProjectGrades/ProjectGrade/text()}</ProjectGrade>
                                                                                </Grades>
                                                                        )
                                                                        else
                                                                        ((:Pas encore de note pour le projet pour ce cours:))
                                                                        }
                                                                        </ProjectGrades>
                                                                        
                                                                
                                                            )
                                                            else
                                                            (
                                                                (:Pas de project pour ce cours:)
                                                            )
                                                        }
                                                        {
                                                        if($exercice) then
                                                            (
                                                                let $exerciceGrade := exists($engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades)
                                                                return
                                                                    if ($exerciceGrade) then 
                                                                        (
                                                                            <ExercicesGrades>
                                                                                {$course/Evaluation/Exercices/Weight}
                                                                                <ExerciceMean>
                                                                                  {
                                                                                    let $meanTest :=    exists($engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades/Exercice[ExerciceGrade!=''])
                                                                                    return
                                                                                    if($meanTest) then 
                                                                                        (
                                                                                            sum($engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades/Exercice/ExerciceGrade) div count($engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades/Exercice/ExerciceGrade)
                                                                                        )
                                                                                        else 
                                                                                        (
                                                                                            (:Pas encore de note entrée pour les exercices:)
                                                                                        )
                                                                                 }
                                                                                </ExerciceMean>
                                                                                <Exercices>
                                                                                    {
                                                                                        for $exo in $course/Sessions/Session/Exercise
                                                                                        return
                                                                                        (
                                                                                                let $id := $exo/ExerciceId
                                                                                                let $test := exists($engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades/Exercice[ExerciceId=$id][ExerciceGrade!=''])
                                                                                                return 
                                                                                                if($test) then 
                                                                                                    (
                                                                                                        <Exercice>
                                                                                                            <ExerciceGrade>{$engagment[Role='Student'][CoursRef=$courseId]/Grade/ExercicesGrades/Exercice[ExerciceId=$id]/ExerciceGrade/text()}</ExerciceGrade>
                                                                                                            <ExerciceTopics>{$exo/ancestor::Session/Topics}</ExerciceTopics>
                                                                                                        </Exercice>
                                                                                                    )
                                                                                                    else
                                                                                                    (
                                                                                                        (:Note pas encore entrée pour cet exercice:)
                                                                                                    )
                                                                                            )
                                                                                    }
                                                                                </Exercices>
                                                                            </ExercicesGrades>
                                                                        )
                                                                        else
                                                                        ((:Pas encore de note pour les exercices pour ce cours:))
                                                                
                                                            )
                                                            else
                                                            (
                                                                (:Pas de notes sur les exercices pour ce cours:)
                                                            )
                                                        }
                                                    </Course>
                                                }
                                            </Courses>
                                            </Period>
                                            )
                                            }
                                         </Periods>
                                   </Infos>
                            )
                        else(
                            <Error>You must be logged in order to acess this page.</Error>
                            )
     }
     </Root>
