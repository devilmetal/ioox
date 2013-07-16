xquery version "1.0";
(: --------------------------------------
   
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Oppidum Klaxon installer

   -------------------------------------- :)

import module namespace install = "http://oppidoc.com/oppidum/install" at "../../oppidum/lib/install.xqm";   
import module namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare variable $policies := <policies xmlns="http://oppidoc.com/oppidum/install">
  <user name="membre" password="test" groups="site-member" home=""/> 
  <policy name="read" owner="admin" group="dba" perms="rwur--r--"/>
  <policy name="write" owner="admin" group="site-member" perms="rwur-ur--"/>
  <policy name="write-delete-add" owner="admin" group="site-member" perms="rwurwur--"/>
</policies>;

declare variable $site := <site xmlns="http://oppidoc.com/oppidum/install">
  <collection name="/db/sites/ioox" policy="read"/>
  <group name="data">
    <collection name="/db/sites/ioox/data" policy="write" inherit="true">
      <files pattern="init/AcademicYears.xml"/>
      <files pattern="init/Persons.xml"/>
    </collection>
    <!-- NOT REQUIRED I THINK
    <collection name="/db/sites/ioox/chapters" policy="write-delete-add"/>
    
    -->
  </group>
</site>;

declare variable $code := <code xmlns="http://oppidoc.com/oppidum/install">
  <collection name="/db/www/ioox" policy="read" inherit="true"/>
  <group name="config">
    <collection name="/db/www/ioox/config" policy="read" inherit="true">
      <files pattern="init/skin.xml"/>
    </collection>
  </group>
  <group name="mesh" mandatory="true">
    <collection name="/db/www/ioox/mesh">
      <files pattern="mesh/*.html"/>
    </collection>
  </group>
  <group name="templates" policy="read" inherit="true">
    <collection name="/db/www/ioox">
      <files pattern="templates/todo.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/note.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/course.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/evaluation.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/grades.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/session.xhtml" type="text/xml" preserve="true"/>
      <files pattern="templates/quizz.xhtml" type="text/xml" preserve="true"/>
      <files pattern="oppidum:templates/filter.xsl" type="text/xml" preserve="true"/>
    </collection>
  </group>
</code>;

declare variable $static := <static xmlns="http://oppidoc.com/oppidum/install">
  <group name="resources">
    <collection name="/db/www/oppidoc">
      <files pattern="resources/**/*.css" preserve="true"/>
      <files pattern="resources/**/*.js" preserve="true"/>
      <files pattern="resources/**/*.png" preserve="true"/>
      <files pattern="resources/**/*.jpg" preserve="true"/>
      <files pattern="resources/**/*.gif" preserve="true"/>
    </collection>
  </group>
</static>;

install:install("projets/ioox", $policies, $site, $code, $static, "ioox", ()),
(:Creation de la collection '/courses' :)
if (not(xdb:collection-available('/courses/'))) then 
    (
        xdb:create-collection('/','courses'),
        xdb:set-collection-permissions('/courses','admin','site-member',util:base-to-integer(0775, 8))
    )
    else
    ()
