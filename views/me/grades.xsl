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
                <xsl:choose>
                    <xsl:when test="//Session/Id = '-1'">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page. </div>
                    </xsl:when>
                    <xsl:otherwise>
                            <!-- On va appliquer le template suivant le retour du XQuery soit : Null => pas loggé/pas incrit
                                                                                         soit : Courses => on affiche -->
                            <xsl:apply-templates select="/Root/child::node()"></xsl:apply-templates>
                            
                            
                        <div id="contentwrapper">
                            
                            <h3 class="heading"> Grades </h3>
                            <div class="row-fluid">
                                
                                <div class="span12">
                                    <xsl:apply-templates select="//Infos"/>
                                    <div class="tabbable">
                                        <ul class="nav nav-tabs">
                                            <!-- Generate the tab menu ofr the current and other tabs -->
                                            
                                            <xsl:apply-templates select="//Period" mode="tab"/>
                                            
                                        </ul>
                                        <div class="tab-content">
                                            <xsl:apply-templates select="//Period" mode="full"/>
                                            
                                            <div class="tab-pane" id="legend">
                                                <dl class="dl-horizontal">
                                                    <dt>Color indicator</dt>
                                                    <dd><span class="square_sub">.</span>you are subscribed on the cours</dd>
                                                    <dd><span class="square_unsub">.</span>you was subscibed on the cours</dd>
                                                </dl>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
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
                
                <script>
                    $(document).ready(function() {
                    //* show all elements  remove preloader
                    setTimeout('$("html").removeClass("js")',0);
                    //* click the style fixed
                    $(ssw_layout_fixed).click();
                    
                    });
                </script>
            </site:javascript>
        </site:view>
    </xsl:template>
    
    
    <xsl:template match="Periods" mode="explorer">
        <xsl:apply-templates select="Period[1]" mode="tab"/>
        <xsl:apply-templates select="Period[2]" mode="tab"/>
        <xsl:apply-templates select="Period[3]" mode="tab"/>
        <xsl:apply-templates select="Period[4]" mode="dropdown"/>
    </xsl:template>
    
    <xsl:template match="Period" mode="tab">
        <xsl:variable name="class"><xsl:if test=".=//Period[position()=1]">active</xsl:if></xsl:variable>
        <li class="{$class}">
            <xsl:element name="a">
                <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                <xsl:attribute name="data-toggle">tab</xsl:attribute>
                <xsl:value-of select="./Name"/>
            </xsl:element>
        </li>
    </xsl:template>
    
    
    <xsl:template match="Period" mode="full">
        <xsl:variable name="class"><xsl:if test=".=//Period[position()=1]">active</xsl:if></xsl:variable>
        <xsl:variable name="id_tab">
            <xsl:value-of select="./End"/>
        </xsl:variable>
        <div class="tab-pane {$class}" id="{$id_tab}">
            <xsl:apply-templates select="Courses"/>
        </div>
    </xsl:template>
    
    <xsl:template match="Period" mode="dropdown">
        <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Archive <b class="caret"
            /></a>
            <ul class="dropdown-menu">
                <li>
                    <xsl:element name="a">
                        <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                        <xsl:attribute name="data-toggle">tab</xsl:attribute>
                        <xsl:value-of select="./Name"/>
                    </xsl:element>
                </li>
                <xsl:for-each select="following-sibling::Period">
                    <li>
                        <xsl:element name="a">
                            <xsl:attribute name="href">#<xsl:value-of select="./End"
                            /></xsl:attribute>
                            <xsl:attribute name="data-toggle">tab</xsl:attribute>
                            <xsl:value-of select="./Name"/>
                        </xsl:element>
                    </li>
                </xsl:for-each>
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="Courses">
        <div id="accordion1" class="accordion">
            <xsl:for-each select="Course">
                <xsl:variable name="acc_uni"><xsl:value-of select="ancestor::Period/End"
                />-<xsl:value-of select="CourseId"/></xsl:variable>
                <div class="accordion-group">
                    <xsl:variable name="CN">
                        <xsl:value-of select="./CourseId"/>
                    </xsl:variable>
                    <xsl:variable name="class">
                        <xsl:value-of select="//Root/Person/Engagments/Engagment[CoursRef=$CN]/Role"/>
                    </xsl:variable>
                    
                    <div class="accordion-heading">
                        <!-- data-parent="#accordion1" deleted -->
                        <a href="#{$acc_uni}" data-toggle="collapse"
                            class="accordion-toggle  {$class}">
                            <xsl:value-of select="CourseNo"/> - <xsl:value-of select="Title"/>
                        </a>
                    </div>
                    <div class="accordion-body collapse" id="{$acc_uni}">
                        <div class="accordion-inner">
                            <div class="row-fluid">
                                <h4>Cours <xsl:value-of select="CourseNo"/></h4>
                                <xsl:variable name="courseid"><xsl:value-of select="CourseId"/></xsl:variable>
                                <xsl:apply-templates select="//Grades//Engagment[CoursRef=$courseid]" mode="engagment"/>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    
    
    
    
    
    
    
    
    
    
    
    
    <xsl:template match="Null">
        <p>You have either to register in any course other to login in order to access your courses.</p>
    </xsl:template>
    
    <xsl:template match="Infos">
        <!-- Nombre total d'engagment -->
        <xsl:variable name="totalEngagment"><xsl:value-of select="count(./Grades//Engagment)"/></xsl:variable>
        <!-- On va faire chaque engagment l'un après l'autre. On note que chaque engagment contient une note. le tri à déjà été fait dans le model.-->
        
        <xsl:variable name="globalMean">
            <xsl:apply-templates select="./Grades/Engagment" mode="global"/>
        </xsl:variable>
        <!--<xsl:value-of select="sum($globalMean/child::node()/child::node())"></xsl:value-of>-->
        Putain de note global : ok ! : <xsl:value-of select="sum($globalMean/child::node()) div $totalEngagment"></xsl:value-of>
        
    </xsl:template>
    
    <xsl:template match="Period">
        <h3><xsl:value-of select="Name"/></h3>
        <h3>Tri par cours </h3>
        <xsl:apply-templates select=".//Course"/>
    </xsl:template>
    
    
    
    
    
    
    
    
    
    <xsl:template match="Engagment" mode="global">
        <!-- Somme de toutes les "sous-grades" -->
        <!-- Stock la note pondérée des sous notes -->
        <xsl:variable name="elementSumPonderation">
            <xsl:apply-templates select="Grade/child::node()"/>
        </xsl:variable>
        
        <!-- Moyenne de l'engagment -->
        <xsl:variable name="sumPonderation"><xsl:value-of select="sum($elementSumPonderation/child::node()/child::node())"></xsl:value-of></xsl:variable>
        
        <Mean><xsl:value-of select="number($sumPonderation)"></xsl:value-of></Mean>
        
       
    </xsl:template>
    
    <xsl:template match="Engagment" mode="engagment">
        <!-- Somme de toutes les "sous-grades" -->
        <!-- Stock la note pondérée des sous notes -->
        <xsl:variable name="elementSumPonderation">
            <xsl:apply-templates select="Grade/child::node()"/>
        </xsl:variable>
        
        <!-- Moyenne de l'engagment -->
        <xsl:variable name="sumPonderation"><xsl:value-of select="sum($elementSumPonderation/child::node()/child::node())"></xsl:value-of></xsl:variable>
        
        <p>Putain de moyen pour le cours : <xsl:value-of select="number($sumPonderation)"></xsl:value-of></p>
        <xsl:apply-templates select="Grade/child::node()" mode="unite"/>
        
        
    </xsl:template>
    
    <xsl:template match="ExercicesGrades">
        <!-- Moyenne des notes des exercices-->
        <xsl:variable name="mean"><xsl:value-of select="sum(.//Exercice/ExerciceGrade) div count(.//Exercice/ExerciceGrade)"/></xsl:variable>
        <!-- L'ID du cours associé -->
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <!-- Somme total des poids -->
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <!-- Pondération  -->
        <xsl:variable name="ponderation"><xsl:value-of select="number(/Root/Infos//Course[CourseId=$courseid]/Evaluation/Exercices/Weight) div $sumtotal"/></xsl:variable>
        
        <Mean><xsl:value-of select="$ponderation * $mean "></xsl:value-of></Mean>
        
    </xsl:template>
    
    <xsl:template match="ExamGrade">
        <xsl:variable name="mean"><xsl:value-of select="."/></xsl:variable>
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <xsl:variable name="ponderation"><xsl:value-of select="/Root/Infos//Course[CourseId=$courseid]/Evaluation/Exam/Weight div $sumtotal"/></xsl:variable>
        
        <Mean><xsl:value-of select="$ponderation * $mean "></xsl:value-of></Mean>
        
    </xsl:template>
    
    <xsl:template match="ProjectGrades">
        <xsl:variable name="mean"><xsl:value-of select="sum(.//Step/StepGrade) div count(.//Step/StepGrade)"/></xsl:variable>
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <xsl:variable name="ponderation"><xsl:value-of select="number(/Root/Infos//Course[CourseId=$courseid]/Evaluation/Project/Weight) div $sumtotal"/></xsl:variable>
        
        <Mean><xsl:value-of select="$ponderation * $mean "></xsl:value-of></Mean>
        
    </xsl:template>
    
    <xsl:template match="ExercicesGrades" mode="unite">
        <!-- Moyenne des notes des exercices-->
        <xsl:variable name="mean"><xsl:value-of select="sum(.//Exercice/ExerciceGrade) div count(.//Exercice/ExerciceGrade)"/></xsl:variable>
        <!-- L'ID du cours associé -->
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <!-- Somme total des poids -->
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <!-- Pondération  -->
        <xsl:variable name="ponderation"><xsl:value-of select="number(/Root/Infos//Course[CourseId=$courseid]/Evaluation/Exercices/Weight) div $sumtotal"/></xsl:variable>
        
        <p>Putain de moyenne pour les exercice : <xsl:value-of select="$mean "></xsl:value-of></p>
        
    </xsl:template>
    
    <xsl:template match="ExamGrade" mode="unite">
        <xsl:variable name="mean"><xsl:value-of select="."/></xsl:variable>
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <xsl:variable name="ponderation"><xsl:value-of select="/Root/Infos//Course[CourseId=$courseid]/Evaluation/Exam/Weight div $sumtotal"/></xsl:variable>
        
        <p>Putain de moyenne pour l'examen : <xsl:value-of select="$mean "></xsl:value-of></p>
        
    </xsl:template>
    
    <xsl:template match="ProjectGrades" mode="unite">
        <xsl:variable name="mean"><xsl:value-of select="sum(.//Step/StepGrade) div count(.//Step/StepGrade)"/></xsl:variable>
        <xsl:variable name="courseid"><xsl:value-of select="ancestor::Engagment/CoursRef"></xsl:value-of></xsl:variable>
        <xsl:variable name="sumtotal"><xsl:value-of select="sum(/Root/Infos//Course[CourseId=$courseid]/Evaluation/child::node()/Weight)"/></xsl:variable>
        <xsl:variable name="ponderation"><xsl:value-of select="number(/Root/Infos//Course[CourseId=$courseid]/Evaluation/Project/Weight) div $sumtotal"/></xsl:variable>
        
        <p>Putain de moyenne pour le projet : <xsl:value-of select="$mean "></xsl:value-of></p>
        
    </xsl:template>
</xsl:stylesheet>
