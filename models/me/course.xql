xquery version "1.0";

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
let $isteacher := exists($person//Engagment[CoursRef=$ref2][Role='Teacher'])
(:On test si le cours est dans la période actuelle, ie, la current-date est contenu dans l'intérval donné de la période :)
let $periodstartday := $courseBase/ancestor::Period/Start
let $periodendday := $courseBase/ancestor::Period/End
let $isgoodperiod := ($curr-date <= $periodendday) and ($curr-date >= $periodstartday)

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
                                            update insert <Engagment><EngagementId>{$id}{$ref2}</EngagementId><Role>Student</Role><CoursRef>{$ref2}</CoursRef></Engagment> into $person//Engagments           
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
                            
                            
      

let $teachers := doc(concat($collection, "Persons.xml"))//Person/Engagments/Engagment[(Role='Tutor' or Role='Teacher') and CoursRef=$ref2]/ancestor::Person
let $grades :=  $person//Engagment[Grade][CoursRef=$ref2]
let $everygrades :=  doc(concat($collection, "Persons.xml"))//Engagment[Grade][CoursRef=$ref2]
(: si la personne est inscrite, on prend le cours en entier, sinon, juste les infos, dans ce cas, ça va modifier l'affichage par la suite ::)
let $course := if ($person//Engagment[Role != 'Unsubscribed']/CoursRef = $ref2) then ($courseBase) else (   <Course>
                                                                                        {$courseBase/CourseId}
                                                                                        {$courseBase/CourseNo}
                                                                                        {$courseBase/Acronym}
                                                                                        {$courseBase/Description}
                                                                                    </Course>)                        
let $period := $courseBase/ancestor::Period

    return
    <Root>
        {$period}
        <Teachers>
            {$teachers}
        </Teachers>
     {$course}
     <Grades>
        {$grades}
     </Grades>
     <EverybodyGrades>
        {$everygrades}
     </EverybodyGrades>
     </Root>
    
