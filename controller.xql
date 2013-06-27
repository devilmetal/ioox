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
  <rule action="home" role="u:admin" message="administrateur"/>
</access>;

(: ======================================================================
                  Site default actions
   ====================================================================== :)
declare variable $actions := <actions error="models/error.xql">
  <action name="login" depth="0" epilogue="standard"> <!-- may be GET or POST -->
    <model src="oppidum:actions/login.xql"/>
    <view src="oppidum:views/login.xsl"/>
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
    <error mesh="standard"/>
  
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
    <collection name="explorer" epilogue="standard">
        <model src="models/explorer.xql"/>
        <view src="views/explorer.xsl"/>
            <item>
                <model src="models/course.xql"/>
                <view src="views/course.xsl"/>
            </item>
    </collection>
  
    <!-- /FAQ page -->
    <item name="faq" epilogue="standard">
        <model src="models/faq.xql"/>
        <view src="views/faq.xsl"/>
    </item>
  
    <!-- /contact page -->
    <item name="contact" epilogue="standard">
        <model src="models/contact.xql"/>
    <view src="views/contact.xsl"/>
    </item>
  
    <!-- /me page (home page of ME section)-->
    <item name="me" epilogue="standard">
    <model src="models/me/me.xql"/>
    <view src="views/me/me.xsl"/>
    
        <!-- /me/mynote page -->
        <collection name="mynote" epilogue="standard" supported="modifier" method="POST" template="templates/note">
            <!-- Vue globale des notes prises + séléction -->
            <model src="models/me/mynote.xql"/>
            <view src="views/me/mynote.xsl"/>
            <action name="modifier" epilogue="standard">
                <model src="oppidum:actions/edit.xql"/>
                <view src="oppidum:views/edit.xsl"/>
            </action>
            <!-- détail / modification de chaque note-->
            <item>
                <model src="models/me/note.xql"/>
                <view src="views/me/note.xsl"/>
            </item>
          </collection>
          
         <!-- /me/todo page -->
        <item name="todo" epilogue="standard">
            <model src="models/me/todo.xql"/>
            <view src="views/me/todo.xsl"/>
        </item>
        
        <!-- /me/profile page -->
        <item name="profile" epilogue="standard">
            <model src="models/me/profile.xql"/>
            <view src="views/me/profile.xsl"/>
        </item>
        
        <!-- /me/grades page -->
        <collection name="grades">
            <!-- Vue global des notes / modification si prof-->
            <model src="models/me/grades.xql"/>
            <view src="views/me/grades.xsl"/>
            <!-- détail de chaque note (note précise + compte rendu du prof)-->
            <item >
                <model src="models/me/grade.xql"/>
                <view src="views/me/grade.xsl"/>
            </item>
          </collection>
          
        <!-- /me/courses page -->
        <collection name="courses" epilogue="standard">
            <model src="models/me/courses.xql"/>
            <view src="views/me/courses.xsl"/>
            <!-- détail de chaque cours -->
            <item epilogue="standard">
                <model src="models/me/course.xql"/>
                <view src="views/me/course.xsl"/>
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
    
    
  <collection name="templates" db="/db/www/xmoodle" collection="templates">
    <model src="oppidum:models/templates.xql"/>
    <item name="note" resource="note.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
  </collection>
  
</site>;

(: call oppidum:process with false() to disable ?debug=true mode :)
gen:process($exist:root, $exist:prefix, $exist:controller, $exist:path, 'fr', true(), $access, $actions, $mapping)
