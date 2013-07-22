<?xml version="1.0" encoding="UTF-8"?>
<!-- 
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      This page, visible and editable only by tutor and teacher
                     give the possibility to the show and edit
                     the evaluation information of the cours
                     The evaluation is base on points ponderation
                     on multiple level.
                     For more info read in the documentation the section implementation
                    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
   xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
   extension-element-prefixes="date" version="2.0">
   <xsl:output method="xml" media-type="text/xhtml" omit-xml-declaration="yes" indent="no"/>
   
   <xsl:param name="xslt.rights"/>
   <xsl:param name="xslt.base-url">/</xsl:param>
   <xsl:template match="/">
      <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"/>static/ioox</xsl:variable>
      <site:view>
         <site:change>
            <div class="style_switcher">
               <div class="sepH_c">
                  <p>Backgrounds:</p>
                  <div class="clearfix">
                     <span class="style_item jQptrn style_active ptrn_def" title=""></span>
                     <span class="ssw_ptrn_a style_item jQptrn" title="ptrn_a"></span>
                     <span class="ssw_ptrn_b style_item jQptrn" title="ptrn_b"></span>
                     <span class="ssw_ptrn_c style_item jQptrn" title="ptrn_c"></span>
                     <span class="ssw_ptrn_d style_item jQptrn" title="ptrn_d"></span>
                     <span class="ssw_ptrn_e style_item jQptrn" title="ptrn_e"></span>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Layout:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_layout" id="ssw_layout_fluid" value=""  /> Fluid</label>
                     <label class="radio inline"><input type="radio" name="ssw_layout" id="ssw_layout_fixed" value="gebo-fixed" /> Fixed</label>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Sidebar position:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_sidebar" id="ssw_sidebar_left" value=""  /> Left</label>
                     <label class="radio inline"><input type="radio" name="ssw_sidebar" id="ssw_sidebar_right" value="sidebar_right" /> Right</label>
                  </div>
               </div>
               <div class="sepH_c">
                  <p>Show top menu on:</p>
                  <div class="clearfix">
                     <label class="radio inline"><input type="radio" name="ssw_menu" id="ssw_menu_click" value=""  /> Click</label>
                     <label class="radio inline"><input type="radio" name="ssw_menu" id="ssw_menu_hover" value="menu_hover" /> Hover</label>
                  </div>
               </div>
               
               <!--<div class="gh_button-group">
                  <a href="#" id="showCss" class="btn btn-primary btn-mini">Show CSS</a>
                  <a href="#" id="resetDefault" class="btn btn-mini">Reset</a>
               </div>-->
               <div class="hide">
                  <ul id="ssw_styles">
                     <li class="small ssw_mbColor sepH_a" style="display:none">body {<span class="ssw_mColor sepH_a" style="display:none"> color: #<span></span>;</span> <span class="ssw_bColor" style="display:none">background-color: #<span></span> </span>}</li>
                     <li class="small ssw_lColor sepH_a" style="display:none">a { color: #<span></span> }</li>
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
            <link rel="stylesheet" href="{$xslt-ressource-url}/lib/fullcalendar/fullcalendar_gebo.css" />	
         </site:header>

         <!-- MENU DEFINITION -->
         <site:menu> </site:menu>
         <!-- SITE CONTENT -->
         <site:navbar/>
            
            
         
         <site:content>
            <xsl:variable name="rolle"><xsl:value-of select="//CurrentRole/Teacher + //CurrentRole/Tutor"/></xsl:variable>
            <xsl:variable name="courseid"><xsl:value-of select="//sysinfo/CourseId"/></xsl:variable>
                  <xsl:choose>
                     <xsl:when test="(//Session/Id = '-1') or ($rolle ='0')">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page or have to be allowed! </div>
                     </xsl:when>
                     <xsl:otherwise>
                        
                           <!-- Menu for teacher hardcoded -->
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
                           
                           <h3 class="heading">Evaluations information for the student</h3>
                        <div class="row-fluid">
                           <div class="span5">
                              <div class="alert alert-block alert-warning fade in">
                                 <!-- Small description/how to -->
                                 <h4 class="alert-heading">Instruction</h4>
                                 <p>In this session you can show and edit the Evaluation structure.
                                    The structure is based on:
                                 <ul>
                                    <li>Exam</li>
                                    <li>Project - divised
                                       <ul>
                                          <li>Rapport</li>
                                          <li>Project code</li>
                                          <li>Presentation</li>
                                       </ul>
                                    </li>
                                    <li>Exercises</li>
                                 </ul>
                                    <xsl:variable name="url"><xsl:value-of select="$xslt.base-url"/><xsl:text>me/courses/</xsl:text><xsl:value-of select="$courseid"/><xsl:text>/quizz</xsl:text><xsl:text>/modifier</xsl:text></xsl:variable>
                                    <a href="{$url}" class="btn btn-inverse faq_right">Edit Quizz</a>
                                 </p>
                                 <!-- link for the edition -->
                                 <a href="{$xslt.base-url}me/courses/{$courseid}/teaching/info/modifier" class="btn btn-inverse"><i class="splashy-document_a4_edit"></i> Edit</a>
                              </div>
                           </div>
                           <div class="span7">
                              <!-- call template for cascade print -->
                              <xsl:apply-templates select="//Evaluation"/>
                           </div>
                        </div>
                        
                        
                        
                        
                        
                     </xsl:otherwise>
                  </xsl:choose>
         </site:content>
         <site:javascript>
            <script src="{$xslt-ressource-url}/js/jquery.min.js"></script>
            <script src="{$xslt-ressource-url}/js/jquery-migrate.min.js"></script>
            <!-- smart resize event -->
            <script src="{$xslt-ressource-url}/js/jquery.debouncedresize.min.js"></script>
            <!-- hidden elements width/height -->
            <script src="{$xslt-ressource-url}/js/jquery.actual.min.js"></script>
            <!-- js cookie plugin -->
            <script src="{$xslt-ressource-url}/js/jquery_cookie.min.js"></script>
            <!-- main bootstrap js -->
            <script src="{$xslt-ressource-url}/bootstrap/js/bootstrap.min.js"></script>
            <!-- bootstrap plugins -->
            <script src="{$xslt-ressource-url}/js/bootstrap.plugins.min.js"></script>
            <!-- tooltips -->
            <script src="{$xslt-ressource-url}/lib/qtip2/jquery.qtip.min.js"></script>
            <!-- jBreadcrumbs -->
            <script src="{$xslt-ressource-url}/lib/jBreadcrumbs/js/jquery.jBreadCrumb.1.1.min.js"></script>
            <!-- sticky messages -->
            <script src="{$xslt-ressource-url}/lib/sticky/sticky.min.js"></script>
            <!-- fix for ios orientation change -->
            <script src="{$xslt-ressource-url}/js/ios-orientationchange-fix.js"></script>
            <!-- scrollbar -->
            <script src="{$xslt-ressource-url}/lib/antiscroll/antiscroll.js"></script>
            <script src="{$xslt-ressource-url}/lib/antiscroll/jquery-mousewheel.js"></script>
            <!-- lightbox -->
            <script src="{$xslt-ressource-url}/lib/colorbox/jquery.colorbox.min.js"></script>
            <!-- mobile nav -->
            <script src="{$xslt-ressource-url}/js/selectNav.js"></script>
            <!-- common functions -->
            <script src="{$xslt-ressource-url}/js/gebo_common.js"></script>
            
            <!-- jQuery UI -->
            <script src="{$xslt-ressource-url}/lib/jquery-ui/jquery-ui-1.10.0.custom.min.js"></script>
            <!-- touch events for jQuery UI -->
            <script src="{$xslt-ressource-url}/js/forms/jquery.ui.touch-punch.min.js"></script>
            
            <script src="{$xslt-ressource-url}/lib/fullcalendar/fullcalendar.js"></script>
            <!--<script src="lib/fullcalendar/gcal.js"></script>-->
            <!-- calendar functions -->
            
            <script src="{$xslt-ressource-url}/js/gebo_btns.js"></script>
            <script src="{$xslt.base-url}caljs"/>
         </site:javascript>
      </site:view>

   </xsl:template>
   
   <!-- For each node in evaluation print the  -->
   <xsl:template match="Evaluation">
      <xsl:apply-templates select="node()"/>
   </xsl:template>
   <!-- at the same time produce the "global viariable" with the data for the ponderation point  -->
   <xsl:template match="Evaluation">
      <xsl:variable name="NbrOfEvalUnit">
         <xsl:value-of select="count(child::node()/Weight)"/>
      </xsl:variable>
      <xsl:variable name="Total">
         <xsl:value-of select="sum(child::node()/Weight)"/>
      </xsl:variable>
      <xsl:apply-templates select="child::node()">
         <xsl:with-param name="Total">
            <xsl:value-of select="$Total"/>
         </xsl:with-param>
      </xsl:apply-templates>
      
   </xsl:template>
   
   <!-- Print exam section -->
   <xsl:template match="Exam">
      <xsl:param name="Total"/>
      
      <dt>Examen</dt>
      <dd>Total weight : <xsl:value-of select="round(Weight*100 div $Total)"/> &#37; of the
         grade</dd>
      <dd>Date of the exam : <xsl:variable name="dt"><xsl:value-of select="Date"/></xsl:variable>
         <xsl:variable name="t1"><xsl:value-of select="StartTime"/></xsl:variable>
         <xsl:variable name="t2"><xsl:value-of select="EndTime"/></xsl:variable>
         <xsl:value-of select="format-date($dt, '[D01].[M01].[Y0001]')"/> from <xsl:value-of
            select="format-time($t1,'[H01]:[m01]')"/> to <xsl:value-of
               select="format-time($t2,'[H01]:[m01]')"/>
      </dd>
      
   </xsl:template>
   
   <!-- Print Pj section and hist sub point -->
   <xsl:template match="Project">
      <xsl:param name="Total"/>
      <dt>Project</dt>
      <dd>Project name : <xsl:value-of select="Title"/></dd>
      <dd>Total weight : <xsl:value-of select="round(Weight*100 div $Total)"/> &#37; of the
         grade</dd>
      <dd>
         <div id="accordion1" class="accordion">
            <div class="accordion-group">
               <div class="accordion-heading">
                  <a href="#collapseOne1" data-parent="#accordion1" data-toggle="collapse"
                     class="accordion-toggle collapsed"> Project description </a>
               </div>
               <div class="accordion-body collapse" id="collapseOne1" style="height: 0px; ">
                  <div class="accordion-inner">
                     <dl class="dl-horizontal dl-modif">
                     <xsl:apply-templates select="Report"/>
                     <xsl:apply-templates select="Presentation"/>
                     <xsl:apply-templates select="Project" mode="small"/>
                     <xsl:apply-templates select="Description"/>
                     </dl>
                  </div>
               </div>
            </div>
         </div>
      </dd>
   </xsl:template>
   
   <!-- Print Report section -->
   <xsl:template match="Report">
      <dt class="minititle">Report</dt>
         <xsl:apply-templates select="child::node()" mode="small"/>
   </xsl:template>
   
   <!-- Usesfull template for print in cascade mode the content - not commented -->
   <xsl:template match="Presentation">
      <dt class="minititle">Presentation</dt>
      <xsl:apply-templates select="child::node()" mode="small"/>
   </xsl:template>
   
   <xsl:template match="Project" mode="small">
      <dt class="minititle">Projet</dt>
      <xsl:apply-templates select="child::node()" mode="small"/>
   </xsl:template>
   
   <xsl:template match="Weight" mode="small">
      <xsl:variable name="tsum"><xsl:value-of select="sum(ancestor-or-self::Project/node()/Weight)"/></xsl:variable>
      <dd><xsl:value-of select="round( . * 100 div $tsum)"/> % weight in the Project Evaluation.</dd>
   </xsl:template>
   
   <xsl:template match="Description" mode="small">
      <dt>Desc</dt>
      <dd><xsl:for-each select="./child::node()">
         <xsl:apply-templates select="."/>
      </xsl:for-each>
      </dd>
   </xsl:template>

   
   <xsl:template match="Exercices">
      <xsl:param name="Total"/>
      <dt>Exercices</dt>
      <dd>Total weight : <xsl:value-of select="round(Weight*100 div $Total)"/> &#37; of the
         grade</dd>
      <dd>
         <div id="accordion1" class="accordion">
            <div class="accordion-group">
               <div class="accordion-heading">
                  <a href="#collapseOne2" data-parent="#accordion1" data-toggle="collapse"
                     class="accordion-toggle collapsed"> Exercices description </a>
               </div>
               <div class="accordion-body collapse" id="collapseOne2" style="height: 0px; ">
                  <div class="accordion-inner">
                     <xsl:apply-templates select="Description"/>
                  </div>
               </div>
            </div>
         </div>
      </dd>
      
   </xsl:template>
   
   <!-- Affichage d'un content type -->
   <xsl:template match="Description">
      <xsl:for-each select="./child::node()">
         <xsl:apply-templates select="."/>
      </xsl:for-each>
   </xsl:template>
   
   <xsl:template match="Parag">
      <p>
         <xsl:for-each select="./child::node()">
            <xsl:apply-templates select="."/>
         </xsl:for-each>
      </p>
   </xsl:template>
   
   <xsl:template match="List">
      <xsl:if test="count(./ListHeader)!=0">
         <span class="ListHeader">
            <xsl:value-of select="./ListHeader[name()!='ListHeader']"/>
         </span>
      </xsl:if>
      <ul class="list_b">
         <xsl:for-each select="./child::node()">
            <li>
               <xsl:apply-templates select="."/>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>
   
   <xsl:template match="SubList">
      <xsl:if test="count(./SubListHeader)!=0">
         <span class="ListHeader">
            <xsl:value-of select="./SubListHeader"/>
         </span>
      </xsl:if>
      <ul class="list_c">
         <xsl:for-each select="./child::node()[name()!='SubListHeader']">
            <li>
               <xsl:apply-templates select="."/>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>
   
   <xsl:template match="Fragment">
      <xsl:value-of select="."/>
   </xsl:template>
   
   <xsl:template match="Link">
      <xsl:element name="a">
         <xsl:attribute name="href">
            <xsl:value-of select="./LinkRef"/>
         </xsl:attribute>
         <xsl:value-of select="./LinkText"/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="ExternalDoc">
      <xsl:element name="a">
         <xsl:attribute name="href">
            <xsl:value-of select="Access/Location"/>
         </xsl:attribute>
         <xsl:value-of select="Title"/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="Exercise" mode="link">
      <xsl:variable name="id1">
         <xsl:value-of select="ancestor::Course/CourseId"/>
      </xsl:variable>
      <xsl:variable name="id2">
         <xsl:value-of select="ancestor::Session/SessionNumber"/>
      </xsl:variable>
      
      <a href="{$xslt.base-url}me/courses/{$id1}/{$id2}" class="btn btn-inverse">Exercise</a>
      
   </xsl:template>
   
   
   <xsl:template match="Link">
      <xsl:element name="a">
         <xsl:attribute name="href">
            <xsl:value-of select="LinkRef"/>
         </xsl:attribute>
         <xsl:attribute name="alt">
            <xsl:value-of select="Comment"/>
         </xsl:attribute>
         <xsl:value-of select="LinkText"/>
      </xsl:element>
   </xsl:template>
   
   
   
   
   
   <xsl:template match="ExamGrade" mode="javascript">
      <!-- Calculer la moyenne des notes des examens des autres -->
      <xsl:variable name="meanO"><xsl:value-of select="sum(//EverybodyGrades//Engagment/Grade/ExamGrade) div count(//EverybodyGrades//Engagment/Grade/ExamGrade)"></xsl:value-of></xsl:variable>
      ,['Exam' ,<xsl:value-of select="."/>,<xsl:value-of select="$meanO"/>]
   </xsl:template>
   <xsl:template match="ExercicesGrades" mode="javascript">
      <!-- Moyenne des notes des exercices de tous les autres -->
      <xsl:variable name="meanO"><xsl:value-of select="sum(//EverybodyGrades//Engagment/Grade/ExercicesGrades/Exercice/ExerciceGrade) div count(//EverybodyGrades//Engagment/Grade/ExercicesGrades/Exercice/ExerciceGrade)"></xsl:value-of></xsl:variable>
      
      <!-- Moyenne des notes des exercices-->
      <xsl:variable name="mean"><xsl:value-of select="sum(.//Exercice/ExerciceGrade) div count(.//Exercice/ExerciceGrade)"/></xsl:variable>
      ,['Exercises' ,<xsl:value-of select="$mean"/>,<xsl:value-of select="$meanO"/>]
   </xsl:template>
   <xsl:template match="ProjectGrades" mode="javascript">
      <!-- Moyenne des notes des project steps de tous les autres -->
      <xsl:variable name="meanO"><xsl:value-of select="sum(//EverybodyGrades//Engagment/Grade/ProjectGrades/Step/StepGrade) div count(//EverybodyGrades//Engagment/Grade/ProjectGrades/Step/StepGrade)"></xsl:value-of></xsl:variable>
      
      
      <!-- Moyenne des notes des steps -->
      <xsl:variable name="mean"><xsl:value-of select="sum(.//Step/StepGrade) div count(.//Step/StepGrade)"/></xsl:variable>
      ,['Project' ,<xsl:value-of select="$mean"/>,<xsl:value-of select="$meanO"/>]
   </xsl:template>
  
</xsl:stylesheet>
