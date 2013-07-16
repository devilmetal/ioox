<?xml version="1.0" encoding="UTF-8"?>
<!--
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XQL pour la modification des notes pour un étudiant, on affiche les notes qui sont déjà rentrées. Et le bouton vers la modification.
                     Le traitement des erreurs est aussi effectué.
                    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
   xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
   extension-element-prefixes="date" version="2.0">
   <xsl:output method="xml" media-type="text/xhtml" omit-xml-declaration="yes" indent="no"/>

   <xsl:param name="xslt.rights"/>
   <xsl:param name="xslt.base-url">/</xsl:param>
   <xsl:template match="/">
      <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
         />static/ioox</xsl:variable>
      <site:view>
         <site:change>
            <div class="style_switcher">
               <div class="sepH_c">
                  <p>Backgrounds:</p>
                  <div class="clearfix">
                     <span class="style_item jQptrn style_active ptrn_def" title=""/>
                     <span class="ssw_ptrn_a style_item jQptrn" title="ptrn_a"/>
                     <span class="ssw_ptrn_b style_item jQptrn" title="ptrn_b"/>
                     <span class="ssw_ptrn_c style_item jQptrn" title="ptrn_c"/>
                     <span class="ssw_ptrn_d style_item jQptrn" title="ptrn_d"/>
                     <span class="ssw_ptrn_e style_item jQptrn" title="ptrn_e"/>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Layout:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_layout"
                           id="ssw_layout_fluid" value=""/> Fluid</label>
                     <label class="radio inline"><input type="radio" name="ssw_layout"
                           id="ssw_layout_fixed" value="gebo-fixed"/> Fixed</label>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Sidebar position:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_sidebar"
                           id="ssw_sidebar_left" value=""/> Left</label>
                     <label class="radio inline"><input type="radio" name="ssw_sidebar"
                           id="ssw_sidebar_right" value="sidebar_right"/> Right</label>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Show top menu on:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_menu"
                           id="ssw_menu_click" value=""/> Click</label>
                     <label class="radio inline"><input type="radio" name="ssw_menu"
                           id="ssw_menu_hover" value="menu_hover"/> Hover</label>
                  </div>
               </div>

               <div class="gh_button-group">
                  <a href="#" id="showCss" class="btn btn-primary btn-mini">Show CSS</a>
                  <a href="#" id="resetDefault" class="btn btn-mini">Reset</a>
               </div>
               <div class="hide">
                  <ul id="ssw_styles">
                     <li class="small ssw_mbColor sepH_a" style="display:none">body {<span
                           class="ssw_mColor sepH_a" style="display:none"> color: #<span/>;</span>
                        <span class="ssw_bColor" style="display:none">background-color: #<span/>
                        </span>}</li>
                     <li class="small ssw_lColor sepH_a" style="display:none">a { color: #<span/>
                        }</li>
                  </ul>
               </div>
            </div>
         </site:change>
         <site:header>

            <!--[if lte IE 8]>
            <link  href="css/ie.css" />
                <script src="js/ie/html5.js"></script>
 	             <script src="js/ie/respond.min.js"></script>
            <![endif]-->
            <script type="application/javascript">
               //* hide all elements and show preloader
               document.documentElement.className += 'js';
            </script>
            <link rel="shortcut icon" href="{$xslt-ressource-url}/img/gCons/connections.png"/>
            <!-- calendar -->
            <link rel="stylesheet"
               href="{$xslt-ressource-url}/lib/fullcalendar/fullcalendar_gebo.css"/>
         </site:header>

         <!-- MENU DEFINITION -->
         <site:menu> </site:menu>
         <!-- SITE CONTENT -->
         <site:navbar/>



         <site:content>
            <xsl:variable name="courseid">
               <xsl:value-of select="/Root/CourseId"/>
            </xsl:variable>
            <div class="navbar">

               <div class="navbar-inner">
                  <div class="container-fluid">

                     <ul class="nav">
                        <li>
                           <a href="{$xslt.base-url}me/courses/{$courseid}/teaching"><img
                                 src="{$xslt-ressource-url}/img/gCons-mini-white/configuration.png"
                                 alt=""/> My Teaching </a>
                        </li>
                        <li class="divider-vertical hidden-phone hidden-tablet"/>
                        <li>
                           <a href="{$xslt.base-url}me/courses/{$courseid}/teaching/info"><img
                                 src="{$xslt-ressource-url}/img/gCons-mini-white/multi-agents.png"
                                 alt=""/> Cours evaluation </a>
                        </li>
                        <li class="divider-vertical hidden-phone hidden-tablet"/>
                        <li>
                           <a href="{$xslt.base-url}me/courses/{$courseid}/teaching/grades"><img
                                 src="{$xslt-ressource-url}/img/gCons-mini-white/bar-chart.png"
                                 alt=""/> Manage Grades </a>
                        </li>
                        <li> </li>
                     </ul>
                  </div>
               </div>

            </div>

            <h2 class="heading">Grade management</h2>
            <xsl:apply-templates select="/Root/child::node()"/>



         </site:content>
         <site:javascript>
            <script src="{$xslt-ressource-url}/js/jquery.min.js"/>
            <script src="{$xslt-ressource-url}/js/jquery-migrate.min.js"/>
            <!-- smart resize event -->
            <script src="{$xslt-ressource-url}/js/jquery.debouncedresize.min.js"/>
            <!-- hidden elements width/height -->
            <script src="{$xslt-ressource-url}/js/jquery.actual.min.js"/>
            <!-- js cookie plugin -->
            <script src="{$xslt-ressource-url}/js/jquery_cookie.min.js"/>
            <!-- main bootstrap js -->
            <script src="{$xslt-ressource-url}/bootstrap/js/bootstrap.min.js"/>
            <!-- bootstrap plugins -->
            <script src="{$xslt-ressource-url}/js/bootstrap.plugins.min.js"/>
            <!-- tooltips -->
            <script src="{$xslt-ressource-url}/lib/qtip2/jquery.qtip.min.js"/>
            <!-- jBreadcrumbs -->
            <script src="{$xslt-ressource-url}/lib/jBreadcrumbs/js/jquery.jBreadCrumb.1.1.min.js"/>
            <!-- sticky messages -->
            <script src="{$xslt-ressource-url}/lib/sticky/sticky.min.js"/>
            <!-- fix for ios orientation change -->
            <script src="{$xslt-ressource-url}/js/ios-orientationchange-fix.js"/>
            <!-- scrollbar -->
            <script src="{$xslt-ressource-url}/lib/antiscroll/antiscroll.js"/>
            <script src="{$xslt-ressource-url}/lib/antiscroll/jquery-mousewheel.js"/>
            <!-- lightbox -->
            <script src="{$xslt-ressource-url}/lib/colorbox/jquery.colorbox.min.js"/>
            <!-- mobile nav -->
            <script src="{$xslt-ressource-url}/js/selectNav.js"/>
            <!-- common functions -->
            <script src="{$xslt-ressource-url}/js/gebo_common.js"/>

            <!-- jQuery UI -->
            <script src="{$xslt-ressource-url}/lib/jquery-ui/jquery-ui-1.10.0.custom.min.js"/>
            <!-- touch events for jQuery UI -->
            <script src="{$xslt-ressource-url}/js/forms/jquery.ui.touch-punch.min.js"/>

            <script src="{$xslt-ressource-url}/lib/fullcalendar/fullcalendar.js"/>
            <!--<script src="lib/fullcalendar/gcal.js"></script>-->
            <!-- calendar functions -->

            <script src="{$xslt-ressource-url}/js/gebo_btns.js"/>
            <script src="{$xslt.base-url}caljs"/>
         </site:javascript>
      </site:view>
   </xsl:template>

   <xsl:template match="Grade">
      <h3 class="heading">
         <xsl:value-of select="Infos/UniqueID"/>
         <xsl:text> - </xsl:text>
         <xsl:value-of select="Infos/Name/Lastname"/>
         <xsl:text> </xsl:text>
         <xsl:value-of select="Infos/Name/Firstname"/>
      </h3>
      <div class="doc_view">
         <div class="doc_view_header"> </div>
         <div class="doc_view_content">
            <xsl:apply-templates select="ExamGrade"/>
            <xsl:apply-templates select="ExercicesGrades"/>
            <xsl:apply-templates select="ProjectGrades"/>
         </div>
         <div class="doc_view_footer clearfix"> </div>
      </div>

      <button title="Modifier la page" onclick="javascript:window.location.href+='/modifier'"
         class="btn btn-inverse faq_right "><i class="splashy-pencil"/> Modify</button>
   </xsl:template>

   <xsl:template match="ExamGrade">
      <h3 class="heading">Exam Grade</h3>
      <dd>
         <xsl:value-of select="."/>
      </dd>
   </xsl:template>

   <xsl:template match="ExercicesGrades">
      <h3 class="heading">Exercices Grades</h3>
      <xsl:for-each select="Exercice">
         <h4 class="heading">Exercice : <xsl:apply-templates select="Topics"/></h4>
         <dd>
            <xsl:value-of select="ExerciceGrade"/>
         </dd>
      </xsl:for-each>
   </xsl:template>

   <xsl:template match="ProjectGrades">
      <h3 class="heading">Project Grades</h3>
      <h4 class="heading">Project Grade</h4>
      <dd>
         <xsl:value-of select="ProjectGrade"/>
      </dd>
      <h4 class="heading">Presentation Grade</h4>
      <dd>
         <xsl:value-of select="PresentationGrade"/>
      </dd>
      <h4 class="heading">Report Grade</h4>
      <dd>
         <xsl:value-of select="ReportGrade"/>
      </dd>

   </xsl:template>
   <!-- Affichage d'une erreure -->
   <xsl:template match="Error">
      <div class="alert alert-error">
         <a class="close" data-dismiss="alert">×</a>
         <strong>Error : </strong>
         <xsl:value-of select="."/>
      </div>
   </xsl:template>

   <!-- Affichage d'un message -->
   <xsl:template match="Message">
      <div class="alert alert-info" condition="has-message">
         <a class="close" data-dismiss="alert">×</a>
         <strong>Message : </strong>
         <xsl:value-of select="."/>
      </div>
   </xsl:template>

   <xsl:template match="Topics">

      <xsl:apply-templates select="Topic[position()!=last()]" mode="notlast"/>
      <xsl:apply-templates select="Topic[position()=last()]" mode="last"/>

   </xsl:template>

   <xsl:template match="Topic" mode="notlast">
      <xsl:variable name="t">
         <xsl:text>"</xsl:text>
      </xsl:variable>
      <xsl:variable name="newt">
         <xsl:text>“</xsl:text>
      </xsl:variable>
      <xsl:value-of select="translate(Title,$t,$newt)"/>
      <xsl:text> / </xsl:text>
   </xsl:template>

   <xsl:template match="Topic" mode="last">
      <xsl:variable name="t">
         <xsl:text>"</xsl:text>
      </xsl:variable>
      <xsl:variable name="newt">
         <xsl:text>“</xsl:text>
      </xsl:variable>
      <xsl:value-of select="translate(Title,$t,$newt)"/>
   </xsl:template>



</xsl:stylesheet>
