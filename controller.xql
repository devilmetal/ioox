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
    <view src="oppidum:views/login.xsl"/>
  </action>
  <action name="logout" depth="0">
    <model src="oppidum:actions/logout.xql"/>
  </action>
  <!-- NOTE: unplug this action from @supported on mapping's root node in production -->
  <action name="install" depth="0">
    <model src="scripts/install.xql"/>
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
    <model src="models/query_for_view_home.xql"/>
    <view src="views/view_of_home.xsl">
        <param name="skin" value="home"/>
    </view>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_home.xql"/>
      <view src="views/view_of_home.xsl"/>
    </action>
  </item>
  
  <!-- /explorer page -->
  <item name="explorer" epilogue="standard" method="POST">
    <model src="models/query_for_view_explorer.xql"/>
    <view src="views/view_of_explorer.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_explorer.xql"/>
      <view src="views/view_of_explorer.xsl"/>
    </action>
  </item>
  
  <!-- /FAQ page -->
  <item name="FAQ" epilogue="standard" method="POST">
    <model src="models/query_for_view_FAQ.xql"/>
    <view src="views/view_of_FAQ.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_FAQ.xql"/>
      <view src="views/view_of_FAQ.xsl"/>
    </action>
  </item>
    <!-- /me page (home page of ME section)-->
  <item name="me" epilogue="standard" method="POST">
    <model src="models/me/query_for_view_me.xql"/>
    <view src="views/me/view_of_me.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/me/query_for_view_me.xql"/>
      <view src="views/me/view_of_me.xsl"/>
    </action>
        <!-- /me/mynote page -->
        <item name="mynote" epilogue="standard" method="POST">
            <model src="models/me/query_for_view_me_mynote.xql"/>
            <view src="views/me/view_of_me_mynote.xsl"/>
            <action epilogue="standard" name="POST">
                <model src="models/me/query_for_view_me_mynote.xql"/>
                <view src="views/me/view_of_me_mynote.xsl"/>
             </action>
          </item>
         <!-- /me/todo page -->
        <item name="todo" epilogue="standard" method="POST">
            <model src="models/me/query_for_view_me_todo.xql"/>
            <view src="views/me/view_of_me_todo.xsl"/>
            <action epilogue="standard" name="POST">
                <model src="models/me/query_for_view_me_todo.xql"/>
                <view src="views/me/view_of_me_todo.xsl"/>
            </action>
        </item>
        <!-- /me/profile page -->
        <item name="profile" epilogue="standard" method="POST">
            <model src="models/me/query_for_view_me_profile.xql"/>
            <view src="views/me/view_of_me_profile.xsl"/>
            <action epilogue="standard" name="POST">
                <model src="models/me/query_for_view_me_profile.xql"/>
                <view src="views/me/view_of_me_profile.xsl"/>
            </action>
        </item>
        <!-- /me/courses page -->
        <item name="courses" epilogue="standard" method="POST">
            <model src="models/me/query_for_view_me_courses.xql"/>
            <view src="views/me/view_of_me_courses.xsl"/>
            <action epilogue="standard" name="POST">
                <model src="models/me/query_for_view_me_courses.xql"/>
                <view src="views/me/view_of_me_courses.xsl"/>
            </action>
        </item>
        <!-- /me/grades page -->
        <item name="grades" epilogue="standard" method="POST">
            <model src="models/me/query_for_view_me_grades.xql"/>
            <view src="views/me/view_of_me_grades.xsl"/>
            <action epilogue="standard" name="POST">
                <model src="models/me/query_for_view_me_grades.xql"/>
                <view src="views/me/view_of_me_grades.xsl"/>
            </action>
        </item>
  </item>
  
  <!-- Axel/Axel-Form templates-->
  <collection name="templates" db="/db/www/ioox" collection="templates">
    <model src="oppidum:models/templates.xql"/>
    <item name="todos" resource="todos.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
  </collection>
</site>;

(: call oppidum:process with false() to disable ?debug=true mode :)
gen:process($exist:root, $exist:prefix, $exist:controller, $exist:path, 'fr', true(), $access, $actions, $mapping)
