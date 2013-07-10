xquery version "1.0";

import module namespace request="http://exist-db.org/xquery/request";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()
let $ref := request:get-attribute('oppidum.command')/@trail
let $courseid := tokenize($ref,'/')[3]
let $studentId := tokenize($ref,'/')[6]
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
(:Test pour vérifier la validité de la demande de page:)
(:savoir si l'étudiant existe et est enregristé à ce cours:)
let $student := doc(concat($collection, "Persons.xml"))//Person[PersonId=$studentId]
let $testStudent := exists($student)
(:savoir si on est connecté en tant que prof pour ce cours:)
let $teacherCount := count(doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]/Engagments/Engagment[Role='Teacher' or Role='Tutor'][CoursRef=$courseid])
let $isTeacher := $teacherCount>0
(:savoir si le cours exists bien:)
let $course := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$courseid]
let $isAcourse := exists($course)

(:traitement des messages d'erreur au cas ou :)
let $backStudent := if($testStudent) then () else (<Error>This student is not registred on your course.</Error>)
let $backIsACourse := if ($isAcourse) then () else (<Error>This is not a valid course.</Error>)
let $backIsTeacher := if ($isTeacher) then () else (<Error>You are not a teacher for this course.</Error>)

(:Coeur de la query, on va, si tout est ok, parcourri le Course/Evaluation pour créer la bonne instance d'évaluation, on la remplit en fonction de ce que l'étudiant possède déjà:)
let $core := if ($testStudent and $isTeacher and $isAcourse ) then 
            (
                (:Tout va bien, on fait le traitement:)
                let $currGrade := $student//Engagment[CoursRef=$courseid][Role='Student']/Grade
                let $courseEval := $course/Evaluation
                return
                <Grade>
                    <Infos>
                        <Name>
                            {$student/Lastname}
                            {$student/Firstname}
                        </Name>
                        {$student/UniqueID}
                    </Infos>
                     {
                     (:Si l'Exam existe on produit l'ExamGrade:)
                     if(exists($courseEval/Exam)) then 
                        (
                            <ExamGrade>{$currGrade/ExamGrade/text()}</ExamGrade>
                        )
                        else
                        (
                        (:Rien a ajouter, pas d'examen pour ce cours:)
                        )
                     }
                     {
                     if(exists($courseEval/Exercices)) then
                        (
                            <ExercicesGrades>
                            {
                            (:On fait l'insance pour tous les exercises, et on la remplit si ils ont déjà été évalués:)
                            let $sessions := $course//Session
                            for $session in $sessions
                            return 
                                if (exists($session/Exercise)) then
                                    (
                                        let $exerciceId := $session/Exercise/ExerciceId/text()
                                        return
                                        <Exercice>
                                            <Topics>
                                            {
                                            for $topic in $session/Topics/Topic
                                            return
                                                $topic}
                                            </Topics>
                                            <ExerciceId>{$exerciceId}</ExerciceId>
                                            <ExerciceGrade>{$currGrade/ExercicesGrades/Exercice[ExerciceId=$exerciceId]/ExerciceGrade/text()}</ExerciceGrade>
                                        </Exercice>
                                    )
                                    else
                                    (
                                        (:il n'y a pas d'exercice pour cette session:)
                                    )
                            }
                            </ExercicesGrades>
                        )
                        else
                        (
                        (:Rien a ajouter, pas d'evaluation pour les exercices sur ce cours:)
                        )
                     }
                     {
                     (:MAYBE
                     ON DOIT CHIOISIR SI LES REPORTGRADE, PROJECTGRADE et PERSENTATIONGRADE sont optionnels !!!:)
                     if(exists($courseEval/Project)) then
                        (
                            <ProjectGrades>
                                <ProjectGrade>{$currGrade/ProjectGrades/ProjectGrade/text()}</ProjectGrade>
                                <PresentationGrade>{$currGrade/ProjectGrades/PresentationGrade/text()}</PresentationGrade>
                                <ReportGrade>{$currGrade/ProjectGrades/ReportGrade/text()}</ReportGrade>
                            </ProjectGrades>
                        )
                        else
                        (
                        (:Rien a ajouter, pas d'evaluation pour le projet sur ce cours:)
                        )
                     }
                    
                </Grade>
            )
            else
            (
                (:il y a des erreurs, on ne fait rien, elle sont retournée via le traitement plus haut:)
            )


    return
    <Root>
    {$backIsACourse}
    {$backIsTeacher}
    {$backStudent}
    {$core}
    <CourseId>
        {$courseid}
    </CourseId>
    </Root>
   
