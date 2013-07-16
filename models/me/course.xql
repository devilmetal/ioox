xquery version "1.0";

(:
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Retrive the data for the course (id retrived by url via oppidum)
                    this page implement the action of register in a cours
:)
import module namespace request="http://exist-db.org/xquery/request";
import module namespace session="http://exist-db.org/xquery/session";

declare option exist:serialize "method=xml media-type=text/xml";


let $collection := '/sites/ioox/data/'
let $method := request:get-method()
let $curr-date := fn:current-date()

(: Récupération de l'ID de la personne connectée :)
let $id := if (session:get-attribute('id')) then (
                            session:get-attribute('id')
                            )
                        else(
                            '-1'
                            )
let $person := doc(concat($collection, "Persons.xml"))//Person[PersonId=$id]
                      
(: Récupération de l'ID du cours:)
let $ref := request:get-attribute('oppidum.command')/resource/@name
let $ref2 := string($ref)

(: Récupération du cours :)
let $courseBase := doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref2]

(:On test si la personne n'est pas un prof ( dans ce cas, il ne peux pas se desinscrire comme ça... :)
let $isteacher := exists($person//Engagment[CoursRef=$ref2][Role='Teacher' or Role='Tutor'])
(:On test si le cours est dans la période actuelle, ie, la current-date est contenu dans l'intérval donné de la période :)
let $isAcourse := exists(doc(concat($collection, "AcademicYears.xml"))//Course[CourseId=$ref2])
let $periodstartday := $courseBase/ancestor::Period/Start
let $periodendday := $courseBase/ancestor::Period/End
let $isgoodperiod := $isAcourse and ($curr-date <= $periodendday) and ($curr-date >= $periodstartday)

(: Si la method est un POST, dans ce cas on s'inscrit/desinscrit au cours 
    (ie on remplace le role par desinscrit, comme ça on conserve la note)  
    choses à vérifier pour lancer la query 
        1) la personne est connectée
        2) ce n'est pas un prof (ce cas est traité ailleurs)
        3) le cours est dans la période actuelle
    :)

let $query := if ($method ='POST' and $id!='-1' and not($isteacher) and $isgoodperiod) then 
                            (
                                (: on fait le traitement de l'inscription/desinscription:)
                                if (request:get-parameter('type', '') ='subscrib') then 
                                   (
                                        (: on test si un engagment existe déjà (ie on a remplacé le role par désinscrit:)
                                        if ($person//Engagments/Engagment[CoursRef=$ref2]) then 
                                            (
                                            (: Dans ce cas, l'engagment existe et on remplace le rôle par Student :)
                                            update replace $person//Engagments/Engagment[CoursRef=$ref2]/Role with <Role>Student</Role>                                            
                                            )
                                            else
                                            (
                                            (: on inscrit la personne au cours, IE on crée un engagement avec le role 'Student' :)
                                            update insert <Engagment><EngagementId>{$id}{$ref2}</EngagementId><Role>Student</Role><CoursRef>{$ref2}</CoursRef><Grade/></Engagment> into $person//Engagments           
                                            )
                                        
                                    ) 
                                    else
                                    (
                                        if (request:get-parameter('type', '') ='unsubscrib') then
                                        (
                                            (: on desinscrit la personne du cours, IE on remplace le role par desinscrit (comme ça on conserve la note) :)
                                            update replace $person//Engagments/Engagment[CoursRef=$ref2]/Role with <Role>Unsubscribed</Role>
                                        )
                                        else
                                        (
                                            (:impossible or hack:)
                                        )
                                    )
                            )
                            else
                            (
                                (:rien à faire:)
                            )
                            
                            
      

let $teachers := doc(concat($collection, "Persons.xml"))//Person/Engagments/Engagment[(Role='Tutor' or Role='Teacher') and (CoursRef=$ref2) ]/ancestor::Person

let $grades :=  $person//Engagment[Grade][CoursRef=$ref2]
let $everygrades :=  doc(concat($collection, "Persons.xml"))//Engagment[Grade][CoursRef=$ref2]
(: si la personne est inscrite, on prend le cours en entier, sinon, juste les infos, dans ce cas, ça va modifier l'affichage par la suite ::)
let $course := if ($person//Engagment[Role != 'Unsubscribed']/CoursRef = $ref2) then ($courseBase) else (   <Course>
                                                                                        {$courseBase/CourseId}
                                                                                        {$courseBase/CourseNo}
                                                                                        {$courseBase/Acronym}
                                                                                        {$courseBase/Description}
                                                                                    </Course>)     
let $means :=   <Means>
                    {
                    (:Savoir si l'examen exist et il y a des notes:)
                    let $test1 := exists($course/Evaluation/Exam)
                    let $test2 := exists($everygrades//Grade[ExamGrade!=''])
                    let $test3 := exists($grades//Grade[ExamGrade!=''])
                    return
                        if($test1) then
                            (
                                (:il existe un examen:)
                                if($test2) then
                                    (
                                        (:une moyenne est calculable:)
                                        <ExamMean>
                                            <Others>{sum($everygrades//Grade[ExamGrade!='']/ExamGrade) div count($everygrades//Grade[ExamGrade!='']/ExamGrade)}</Others>
                                            <Me>
                                            {
                                                if($test3) then
                                                (
                                                    $grades//Grade/ExamGrade/text()
                                                )
                                                else
                                                ()
                                            }
                                            </Me>
                                       </ExamMean>
                                    )
                                    else
                                    ()
                            )
                            else
                            ()
                    }
                    {
                    (:Savoir si le project exist et il y a des notes:)
                    let $test1 := exists($course/Evaluation/Project)
                    (:si le project exist, on va teste pour les sous-moyennes project/report/presentation:)
                    return
                    if($test1) then
                        (
                        <ProjectMean>
                        {
                        (:sous-test pour le project:)
                        let $test1 := exists($everygrades//Grade/ProjectGrades[ProjectGrade!=''])
                        let $test2 := exists($grades//Grade/ProjectGrades[ProjectGrade!=''])
                        return
                        if($test1) then 
                            (
                                <Project>
                                    <Others>{sum($everygrades//Grade/ProjectGrades[ProjectGrade!='']/ProjectGrade) div count($everygrades//Grade/ProjectGrades[ProjectGrade!='']/ProjectGrade)}</Others>                                    
                                    <Me>
                                        {
                                            if($test2) then
                                            (
                                                $grades//Grade/ProjectGrades/ProjectGrade/text()
                                            )
                                            else
                                            ()
                                        }
                                    </Me>
                                </Project>
                            )
                            else
                            ()
                        }
                        {
                        (:sous-test pour le rapport:)
                        let $test1 := exists($everygrades//Grade/ProjectGrades[ReportGrade!=''])
                        let $test2 := exists($grades//Grade/ProjectGrades[ReportGrade!=''])
                        return
                        if($test1) then 
                            (
                                <Report>
                                    <Others>{sum($everygrades//Grade/ProjectGrades[ReportGrade!='']/ReportGrade) div count($everygrades//Grade/ProjectGrades[ReportGrade!='']/ReportGrade)}</Others>                                    
                                    <Me>
                                        {
                                            if($test2) then
                                            (
                                                $grades//Grade/ProjectGrades/ReportGrade/text()
                                            )
                                            else
                                            ()
                                        }
                                    </Me>
                                </Report>
                            )
                            else
                            ()
                        }
                        {
                        (:sous-test pour la presentation:)
                        let $test1 := exists($everygrades//Grade/ProjectGrades[PresentationGrade!=''])
                        let $test2 := exists($grades//Grade/ProjectGrades[PresentationGrade!=''])
                        return
                        if($test1) then 
                            (
                                <Presentation>
                                    <Others>{sum($everygrades//Grade/ProjectGrades[PresentationGrade!='']/PresentationGrade) div count($everygrades//Grade/ProjectGrades[PresentationGrade!='']/PresentationGrade)}</Others>                                    
                                    <Me>
                                        {
                                            if($test2) then
                                            (
                                                $grades//Grade/ProjectGrades/PresentationGrade/text()
                                            )
                                            else
                                            ()
                                        }
                                    </Me>
                                </Presentation>
                            )
                            else
                            ()
                        }
                        </ProjectMean>)
                        else
                        ()
                    
                    }
                    {
                    (:Savoir si les exercices existent et il y a des notes:)
                    let $test1 := exists($course/Evaluation/Exercices)
                    let $test2 := exists($everygrades//Grade/ExercicesGrades/Exercice[ExerciceGrade!=''])
                    let $test3 := exists($grades//Grade/ExercicesGrades/Exercice[ExerciceGrade!=''])
                    return
                        if($test1) then
                            (
                                (:il existe des exercices:)
                                if($test2) then
                                    (
                                        (:une moyenne est calculable:)
                                        <ExercicesMean>
                                            <Others>{sum($everygrades//Grade/ExercicesGrades/Exercice[ExerciceGrade!='']/ExerciceGrade) div count($everygrades//Grade/ExercicesGrades/Exercice[ExerciceGrade!='']/ExerciceGrade)}</Others>
                                            <Me>
                                            {
                                                if($test3) then
                                                (
                                                    sum($grades//Grade/ExercicesGrades/Exercice[ExerciceGrade!='']/ExerciceGrade) div count($grades//Grade/ExercicesGrades/Exercice[ExerciceGrade!='']/ExerciceGrade)
                                                )
                                                else
                                                ()
                                            }
                                            </Me>
                                       </ExercicesMean>
                                    )
                                    else
                                    ()
                            )
                            else
                            ()
                    }
                </Means>
let $period := $courseBase/ancestor::Period
let $error := if ($isgoodperiod or $isteacher) then () else ( <Error>You can not subscrib a course which is in not in the current period</Error>)
    return
        if ($isAcourse) then 
        (
        <Root>
        
        {$means}
        {$period}
        <Teachers>
            {$teachers}
        </Teachers>
        {$course}
        {$error}
        </Root>
        )
        else
        (
        <Root>
        <Error>This is not a valid course.</Error>
        </Root>
        )
    
