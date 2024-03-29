xquery version "1.0";
(: -----------------------------------------------
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Controller du website, définit la structure REST du site.
        
   ----------------------------------------------- :)

import module namespace gen = "http://oppidoc.com/oppidum/generator" at "../oppidum/lib/pipeline.xqm";

(: ======================================================================
                  Site default access rights
   ====================================================================== :)
declare variable $access := <access>
  <rule action="install" role="u:admin" message="administrateur"/>
  <rule action="ajouter modifier" role="u:admin g:site-member" message="membre"/>
  <rule action="POST" role="all" message="tous"/>
</access>;

(: ======================================================================
                  Site default actions
   ====================================================================== :)
declare variable $actions := <actions error="models/error.xql">
  <action name="login" depth="0" epilogue="standard"> <!-- may be GET or POST -->
    <model src="oppidum:actions/login.xql"/>
    <view src="views/login.xsl">
        <param name="skin" value="login"/>
    </view>
  </action>
  <action name="logout" depth="0">
    <model src="oppidum:actions/logout.xql"/>
  </action>
  <!-- NOTE: unplug this action from @supported on mapping's root node in production -->
  <action name="install" depth="0">
    <model src="scripts/install.xql"/>
  </action>
  <action name="home" depth="0">
    <model src="models/home.xql"/>
  </action>
</actions>;
 
(: ======================================================================
                  Site mappings
   ====================================================================== :)
declare variable $mapping := <site db="/db/sites/ioox" confbase="/db/www/ioox" startref="home" supported="login logout install" key="ioox" mode="dev">
(:  <!-- low level error mesh -->:)
    <error mesh="standard" epilogue="standard"/>
  
    <!-- /home page -->
    <item name="home" epilogue="standard" method="POST">
        <model src="models/home.xql"/>
        <view src="views/home.xsl"/>
        <action epilogue="standard" name="POST">
            <model src="models/home.xql"/>
            <view src="views/home.xsl"/>
        </action>
    </item>
  
    <!-- /explorer page -->
    <item name="explorer" epilogue="standard" method="POST">
        <model src="models/explorer.xql"/>
        <view src="views/explorer.xsl"/>
        <action name="POST" epilogue="standard">
            <model src="models/explorer.xql"/>
            <view src="views/explorer.xsl"/>
        </action>
    </item>
  
    <!-- /FAQ page -->
    <item name="faq" epilogue="standard">
        <model src="models/faq.xql"/>
        <view src="views/faq.xsl"/>
    </item>
    
    <!--admin page -->
    <item name="admin" epilogue="standard" method="POST">
        <!-- Page de base pour l'admin-->
        <model src="models/admin/admin.xql"/>
        <view src="views/admin/admin.xsl"/>
        <action name="POST" epilogue="standard">
            <model src="models/admin/admin.xql"/>
            <view src="views/admin/admin.xsl"/>
        </action>
        <!-- Création d'utilisateurs-->
        <item name="usercreation" epilogue="standard" method="POST">
            <model src="models/admin/createuser.xql"/>
            <view src="views/admin/createuser.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/admin/createuser.xql"/>
                <view src="views/admin/createuser.xsl"/>
            </action>
        </item>
        <!-- Suppression d'utilisateurs -->
        <item name="userdelete" epilogue="standard" method="POST">
            <model src="models/admin/userdelete.xql"/>
            <view src="views/admin/userdelete.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/admin/userdelete.xql"/>
                <view src="views/admin/userdelete.xsl"/>
            </action>
        </item>
        <!-- Gestion des cours -->
        <collection name="courses" epilogue="standard" method="POST">
            <!-- vue global des cours, demande pour en créer un formulaire de recherche POST : formulaire de recherche et suppression du cours.-->
            <model src="models/admin/courses.xql"/>
            <view src="views/admin/courses.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/admin/courses.xql"/>
                <view src="views/admin/courses.xsl"/>
            </action>
            <!-- vu détaillée par cours, modification via Axel et création si item demandé n'exist pas, POST=sauvgarde de modification 
            Dans le cas d'une demande de clone, on arrive avec un paramêtre GET sur la page avec l'id du cours à clôner-->
            <item epilogue="standard" supported="modifier" method="POST" template="templates/course">
                <model src="models/admin/course.xql"/>
                <view src="views/admin/course.xsl"/>
                <action epilogue="standard" name="modifier">
                        <model src="models/admin/edit.xql"/>
                        <view src="views/edit.xsl"/>
                </action>
                <action name="POST" epilogue="standard" >
                    <model src="models/admin/save_course.xql"/>
                </action>
            </item>
        </collection>
        <!-- Cette page permet de lier un cours à un professeur -->
        <collection name="bind" epilogue="standard" method="POST">
            <!-- recherche d'un cours -->
            <model src="models/admin/bind.xql"/>
            <view src="views/admin/bind.xsl"/>
            <action name="POST" epilogue="standard">
                    <model src="models/admin/bind.xql"/>
                    <view src="views/admin/bind.xsl"/>
            </action>
            <!-- l'item renvoye sur un cours qui donne un fomulaire pour chercher un utilisateur ensuite on affiche les user demander avec un bouton bind -->
            <item epilogue="standard" method="POST">
                <model src="models/admin/bindcourse.xql"/>
                <view src="views/admin/bindcourse.xsl"/>
                <action name="POST" epilogue="standard">
                    <model src="models/admin/bindcourse.xql"/>
                    <view src="views/admin/bindcourse.xsl"/>
                </action>
            </item>
        </collection>
    </item>
  
    <!-- /me page (home page of ME section)-->
    <item name="me" epilogue="standard">
    <model src="models/me/myhome.xql"/>
    <view src="views/me/myhome.xsl"/>
    
        <!-- /me/mynote page -->
        <collection name="mynotes" epilogue="standard">
            <!-- affichage de tous les cours dispos avec une "mynote" -->
            <model src="models/me/mynotes.xql"/>
            <view src="views/me/mynotes.xsl"/>
            <!-- détail de chaque cours -->
            <item epilogue="standard" method="POST">
                <model src="models/me/mynotes_courses.xql"/>
                <view src="views/me/mynotes_courses.xsl"/>
                <action epilogue="standard" name="POST">
                    <model src="models/me/mynotes_courses.xql"/>
                    <view src="views/me/mynotes_courses.xsl"/>
                </action>
                <!-- Détail de chaque note (par session) -->
                <item epilogue="standard" supported="modifier" method="POST" template="templates/note">
                    <model src="models/me/mynotes_session.xql"/>
                    <view src="views/me/mynotes_session.xsl"/>
                    <action epilogue="standard" name="modifier">
                        <model src="oppidum:actions/edit.xql"/>
                        <view src="views/edit.xsl"/>
                    </action>
                    <action name="POST">
                        <model src="models/save_note.xql"/>
                    </action>
                </item>
            </item>
          </collection>
          
         <!-- /me/todo page -->
        <item name="todo" epilogue="standard" supported="modifier" method="POST" template="templates/todo">
            <model src="models/me/todo.xql"/>
            <view src="views/me/todo.xsl"/>
            <action name="modifier" epilogue="standard">
                <model src="oppidum:actions/edit.xql"/>
                <view src="views/edit.xsl"/>
            </action>
            <action name="POST">
                <model src="models/save_todo.xql"/>
            </action>
        </item>
        
        <!-- /me/profile page -->
        <item name="profil" epilogue="standard" method="POST">
            <model src="models/me/profil.xql"/>
            <view src="views/me/profil.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/me/profil.xql"/>
                <view src="views/me/profil.xsl"/>
            </action>
        </item>
        
        <!-- /me/grades page -->
        <item name="grades" epilogue="standard">
            <!-- Vue global des notes -->
            <model src="models/me/grades.xql"/>
            <view src="views/me/grades.xsl"/>
          </item>
          
        <!-- /me/docs page -->
        <!-- permet de transformer les mynotes en PDF -->
        <collection name="docs" epilogue="standard">
            <!-- Vue global de tous les cours avec des Mynotes -->
            <model src="models/me/docs.xql"/>
            <view src="views/me/docs.xsl"/>
            <!-- PDF du cours demandé-->
            <item epilogue="standard2">
                <model src="models/me/docscourse.xql"/>
                <view src="views/me/docscourse.xsl"/>
            </item>
          </collection>
          
        <!-- /me/courses page -->
        <collection name="courses" epilogue="standard">
            <model src="models/me/courses.xql"/>
            <view src="views/me/courses.xsl"/>
            <!-- détail de chaque cours -->
            <item epilogue="standard" method="POST">
                <model src="models/me/course.xql"/>
                <view src="views/me/course.xsl"/>
                <action epilogue="standard" name="POST">
                    <model src="models/me/course.xql"/>
                    <view src="views/me/course.xsl"/>
                </action>
                
                <!-- Quizz pour le cours -->
                <item name="quizz" epilogue="standard" supported="modifier" method="POST" template="templates/quizz">
                    <model src="models/me/quizz.xql"/>
                    <view src="views/me/quizz.xsl"/>
                    <action epilogue="standard" name="POST">
                        <model src="models/save_quizz.xql"/>
                    </action>
                    <action epilogue="standard" name="modifier">
                        <model src="oppidum:actions/edit.xql"/>
                        <view src="views/edit.xsl"/>
                    </action>
                </item>
                <!-- Détail de chaque exercice (rendu et donnée) -->
                <item epilogue="standard" method="POST">
                    <model src="models/me/exercice.xql"/>
                    <view src="views/me/exercice.xsl"/>
                    <action epilogue="standard" name="POST">
                        <model src="models/me/exercice.xql"/>
                        <view src="views/me/exercice.xsl"/>
                    </action>
                </item>
                <!-- teacher edit mode of the course -->
                <collection epilogue="standard" name="teaching">
                    <model src="models/me/teaching/sessions.xql"/>
                    <view src="views/me/teaching/sessions.xsl"/>
                    <!-- Edition de chaque session -->
                    <item epilogue="standard" supported="modifier" method="POST" template="templates/session">
                        <model src="models/me/teaching/session.xql"/>
                        <view src="views/me/teaching/session.xsl"/>
                        <action epilogue="standard" name="modifier">
                            <model src="oppidum:actions/edit.xql"/>
                            <view src="views/edit.xsl"/>
                        </action>
                        <action name="POST">
                            <model src="models/me/teaching/save_session.xql"/>
                        </action>
                        <item name="docs" method="POST">
                            <action name="POST">
                                <model src="models/upload.xql"/>
                            </action>
                        </item>
                    </item>
                    <!-- teacher evaluation manager -->
                    <item name="info" epilogue="standard" supported="modifier" method="POST" template="templates/evaluation">
                        <model src="models/me/teaching/info.xql"/>
                        <view src="views/me/teaching/info.xsl"/>
                        <action epilogue="standard" name="modifier">
                            <model src="oppidum:actions/edit.xql"/>
                            <view src="views/edit.xsl"/>
                        </action>
                        <action name="POST">
                            <model src="models/me/teaching/save_info.xql"/>
                        </action>
                    </item>
                    <!-- teacher grades manager -->
                    <collection epilogue="standard" name="grades">
                        <!-- vue de base avec l'affichage de tous les étudiants du cours -->
                        <model src="models/me/teaching/grades.xql"/>
                        <view src="views/me/teaching/grades.xsl"/>
                        <!-- Chagrement des notes par rapport à l'evaluation de base du cours -->
                        <item epilogue="standard" method="POST" supported="modifier" template="templates/grades">
                        <model src="models/me/teaching/studentgrades.xql"/>
                        <view src="views/me/teaching/studentgrades.xsl"/>
                        <action epilogue="standard" name="modifier">
                            <model src="oppidum:actions/edit.xql"/>
                            <view src="views/edit.xsl"/>
                        </action>
                        <action name="POST">
                            <model src="models/me/teaching/save_grades.xql"/>
                        </action>
                        </item>
                    </collection>
                </collection>
            </item>
          </collection>
    </item>
    
    
    <!-- Utilées pour la génération des events dans la page Myhome pour le FullCalendar-->
    <item name="eventsjs">
        <model src="models/js/eventsjs.xql"/>
        <view src="views/js/eventsjs.xsl"/>
    </item>
    <item name="caljs">
        <model src="models/js/caljs.xql"/>
        <view src="views/js/caljs.xsl"/>
    </item>
    
    <!-- Templates -->
  <collection name="templates" db="/db/www/ioox" collection="templates">
    <model src="oppidum:models/templates.xql"/>
    <item name="note" resource="note.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="todo" resource="todo.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="course" resource="course.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="evaluation" resource="evaluation.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="grades" resource="grades.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="session" resource="session.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
    <item name="quizz" resource="quizz.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
  </collection>
</site>;

(: call oppidum:process with false() to disable ?debug=true mode :)
gen:process($exist:root, $exist:prefix, $exist:controller, $exist:path, 'fr', true(), $access, $actions, $mapping)
