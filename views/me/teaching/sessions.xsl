<?xml version="1.0" encoding="UTF-8"?>
<!-- Home View
        @author:   LC&GL
        @date:     27.02.2013
        @version:  1.0
        @desc:     home page
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
               
               <div class="gh_button-group">
                  <a href="#" id="showCss" class="btn btn-primary btn-mini">Show CSS</a>
                  <a href="#" id="resetDefault" class="btn btn-mini">Reset</a>
               </div>
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
                           
                           <h3 class="heading">Sessions</h3>
                        <p>This is the overview of all session with the possibility to entry in edit mode</p>
                  <div class="row-fluid">
                     <xsl:apply-templates select="//Sessions"/>  
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
   
   <xsl:template match="Sessions">
      <div class="row-fluid">
         <xsl:apply-templates select="Session" mode="app"/>
      </div>
   </xsl:template>

   
   
   
   <!--  COPIATO DA PRIMA -->
   <xsl:template match="Session" mode="app">
      <xsl:variable name="courseid"><xsl:value-of select="//sysinfo/CourseId"/></xsl:variable>
      <xsl:variable name="sessionnumber"><xsl:value-of select="SessionNumber"/></xsl:variable>

      
         <xsl:choose>
            <xsl:when test="./Topics/Topic[1]/Title !=''">
               <div class="span6 bb">
               <div class="ourbox obc0">
                  <h4><xsl:apply-templates select="child::Topics"/></h4>
                  <span><i class="splashy-calendar_week"></i> [<xsl:if test="Date!=''"> d:<xsl:value-of select="format-date(Date, '[D1].[M1].[Y01]')"/></xsl:if>
                     <xsl:if test="StartTime!=''"> | s: <xsl:value-of select="format-time(StartTime,'[H1]:[m01]')"/></xsl:if><xsl:if test="EndTime!=''"> - e: <xsl:value-of select="format-time(EndTime,'[H1]:[m01]')"/></xsl:if>]</span><br/>
                  <a href="{$xslt.base-url}me/courses/{$courseid}/teaching/{$sessionnumber}" class="btn btn-inverse btn-mini"><i class="splashy-arrow_medium_upper_right"></i> go to sesison</a>
                  <p/>
                  <span class="superbackground"><xsl:value-of select="SessionNumber"/></span>
               </div>
                  
               </div>
            </xsl:when>
            <xsl:otherwise>
               <div class="span6 bb">
               <div class="ourbox obc2">
                  <h4><xsl:value-of select="Topics"/></h4>
                  <span><i class="splashy-calendar_week"></i> [<xsl:if test="Date!=''"> d:<xsl:value-of select="format-date(Date, '[D1].[M1].[Y01]')"/></xsl:if>
                     <xsl:if test="StartTime!=''"> | s: <xsl:value-of select="format-time(StartTime,'[H1]:[m01]')"/></xsl:if><xsl:if test="EndTime!=''"> - e: <xsl:value-of select="format-time(EndTime,'[H1]:[m01]')"/></xsl:if>]</span><br/>
                  <a href="{$xslt.base-url}me/courses/{$courseid}/teaching/{$sessionnumber}" class="btn btn-inverse btn-mini"><i class="splashy-arrow_medium_upper_right"></i> go to sesison</a>
                  <p/>
                  <span class="superbackground"><xsl:value-of select="SessionNumber"/></span>
               </div>
                  
               </div>
            </xsl:otherwise>
         </xsl:choose> 
      
   </xsl:template>
   
   
   
   
   
   <xsl:template match="Topics">
      <xsl:if test="count(Topic)!=0">
         <xsl:apply-templates select="Topic[position()!=last()]" mode="notlast"/>
         <xsl:apply-templates select="Topic[position()=last()]" mode="last"/>
      </xsl:if>
      <xsl:if test="count(Topic)=0">
         No topic for now
      </xsl:if>
      
      
      
   </xsl:template>
   
   <xsl:template match="Topic" mode="notlast">
      <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
      <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
      <xsl:value-of select="translate(Title,$t,$newt)"/><xsl:text> / </xsl:text>
   </xsl:template>
   <xsl:template match="Topic" mode="last">
      <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
      <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
      <xsl:value-of select="translate(Title,$t,$newt)"/>
   </xsl:template>

  
</xsl:stylesheet>
