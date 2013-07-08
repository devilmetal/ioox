xquery version "1.0";
(: -----------------------------------------------
   ioox controller

   Author: Carnevale Luca & Luyet Gil / UNIFR
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
        <model src="models/admin/admin.xql"/>
        <view src="views/admin/admin.xsl"/>
        <action name="POST" epilogue="standard">
            <model src="models/admin/admin.xql"/>
            <view src="views/admin/admin.xsl"/>
        </action>
        <item name="usercreation" epilogue="standard" method="POST">
            <model src="models/admin/createuser.xql"/>
            <view src="views/admin/createuser.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/admin/createuser.xql"/>
                <view src="views/admin/createuser.xsl"/>
            </action>
        </item>
        <item name="userdelete" epilogue="standard" method="POST">
            <model src="models/admin/userdelete.xql"/>
            <view src="views/admin/userdelete.xsl"/>
            <action name="POST" epilogue="standard">
                <model src="models/admin/userdelete.xql"/>
                <view src="views/admin/userdelete.xsl"/>
            </action>
        </item>
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
                    <model src="models/admin/save-course.xql"/>
                </action>
            </item>
        </collection>
    </item>
  
    <!-- /contact page -->
    <item name="contact" epilogue="standard">
        <model src="models/contact.xql"/>
    <view src="views/contact.xsl"/>
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
        <collection name="grades" epilogue="standard">
            <!-- Vue global des notes / modification si prof-->
            <model src="models/me/grades.xql"/>
            <view src="views/me/grades.xsl"/>
            <!-- détail de chaque note (note précise + compte rendu du prof, On renvoye sur la page du cours ??? )-->
            <item epilogue="standard">
                <model src="models/me/grade.xql"/>
                <view src="views/me/grade.xsl"/>
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
                <!-- Détail de chaque exercice (rendu et donnée) -->
                <item epilogue="standard" method="POST">
                    <model src="models/me/exercice.xql"/>
                    <view src="views/me/exercice.xsl"/>
                    <action epilogue="standard" name="POST">
                        <model src="models/me/exercice.xql"/>
                        <view src="views/me/exercice.xsl"/>
                    </action>
                </item>
            </item>
          </collection>
    </item>
    
    <item name="eventsjs">
        <model src="models/js/eventsjs.xql"/>
        <view src="views/js/eventsjs.xsl"/>
    </item>
    
    <item name="caljs">
        <model src="models/js/caljs.xql"/>
        <view src="views/js/caljs.xsl"/>
    </item>
    
    
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
  </collection>
  
</site>;

(: call oppidum:process with false() to disable ?debug=true mode :)
gen:process($exist:root, $exist:prefix, $exist:controller, $exist:path, 'fr', true(), $access, $actions, $mapping)
