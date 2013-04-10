xquery version "1.0";
(: -----------------------------------------------
   ioox controller

   Author: Stéphane Sire <s.sire@free.fr>

   November 2011 - Copyright (c) Oppidoc S.A.R.L
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
  <!-- low level error mesh -->
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
  <!-- Courses page -->
  <item name="courses" epilogue="standard" method="POST">
    <model src="models/query_for_view_courses.xql"/>
    <view src="views/view_of_courses.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_courses.xql"/>
      <view src="views/view_of_courses.xsl"/>
    </action>
  </item>
  
<!-- Todos page -->
  <item name="todos" epilogue="standard2" supported="modifier" method="POST" template="templates/todos">
    <model src="models/query_for_view_todos.xql"/>
    <view src="views/view_of_todos.xsl"/>
    <action name="modifier" epilogue="standard2">
      <model src="oppidum:actions/edit.xql"/>
      <view src="views/edit.xsl">
      </view>
    </action>
    <action name="POST">
      <model src="models/save-todos.xql"/>
    </action>
  </item>

<!-- Grades page -->
  <item name="grades" epilogue="standard" method="POST">
    <model src="models/query_for_view_grades.xql"/>
    <view src="views/view_of_grades.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_grades.xql"/>
      <view src="views/view_of_grades.xsl"/>
    </action>
  </item>
  <!-- ePPT presentation page -->
  <item name="ePPT" epilogue="standard" method="POST">
    <model src="models/query_for_view_ePPT.xql"/>
    <view src="views/view_of_ePPT.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_ePPT.xql"/>
      <view src="views/view_of_ePPT.xsl"/>
    </action>
  </item>
<!-- The Big presentation page -->
  <item name="recursive" epilogue="standard" method="POST">
    <model src="models/query_for_view_recursive.xql"/>
    <view src="views/view_of_recursive.xsl"/>
    <action epilogue="standard" name="POST">
      <model src="models/query_for_view_recursive.xql"/>
      <view src="views/view_of_recursive.xsl"/>
    </action>
  </item>
  
  <collection name="templates" db="/db/www/ioox" collection="templates">
    <model src="oppidum:models/templates.xql"/>
    <item name="todos" resource="todos.xhtml">
      <model src="oppidum:models/template.xql"/>
    </item>
  </collection>
</site>;

(: call oppidum:process with false() to disable ?debug=true mode :)
gen:process($exist:root, $exist:prefix, $exist:controller, $exist:path, 'fr', true(), $access, $actions, $mapping)
