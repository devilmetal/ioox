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
                                    class="ssw_mColor sepH_a" style="display:none"> color:
                                    #<span/>;</span>
                                <span class="ssw_bColor" style="display:none">background-color:
                                    #<span/>
                                </span>}</li>
                            <li class="small ssw_lColor sepH_a" style="display:none">a { color:
                                #<span/> }</li>
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

                <script>
                    $(document).ready(function() {
                    //* show all elements  remove preloader
                    setTimeout('$("html").removeClass("js")',0);
                    //* click the style fixed
                    $(ssw_layout_fixed).click();
                    
                    });
                </script>
                <script src="{$xslt-ressource-url}/js/jsapi.js"/>
                <xsl:apply-templates select="//Course" mode="javascript"/>
            </site:javascript>
        </site:view>
    </xsl:template>

    <xsl:template match="Course" mode="javascript">
        <script type="text/javascript">
            google.load("visualization", "1", {packages:["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
            var data = google.visualization.arrayToDataTable([
            ['Type', 'Grade']
            <xsl:apply-templates select="ExamGrade" mode="javascript"/>
            <xsl:apply-templates select="ProjectGrades" mode="javascript"/>
            <xsl:apply-templates select="ExercicesGrades" mode="javascript"/>
            ]);
            
            var options = {
            title: 'Course Grades',
            hAxis: {title: 'Type', titleTextStyle: {color: 'red'}},
            vAxis: {maxValue: 6, minValue: 0}
            };
            
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div<xsl:value-of select="CourseId"/>'));
            chart.draw(data, options);
            }
        </script>
    </xsl:template>
    
    <xsl:template match="ExamGrade" mode="javascript">
        ,['Exam' ,<xsl:value-of select="Grade"/>]
    </xsl:template>
    
    <xsl:template match="ProjectGrades" mode="javascript">
        <xsl:if test="Grades/ProjectMean">
            ,['Project' ,<xsl:value-of select="Grades/ProjectMean"/>]
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="ExercicesGrades" mode="javascript">
        ,['Exercices' ,<xsl:value-of select="ExerciceMean"/>]
    </xsl:template>

    <xsl:template match="Periods" mode="explorer">
        <xsl:apply-templates select="Period[1]" mode="tab"/>
        <xsl:apply-templates select="Period[2]" mode="tab"/>
        <xsl:apply-templates select="Period[3]" mode="tab"/>
        <xsl:apply-templates select="Period[4]" mode="dropdown"/>
    </xsl:template>

    <xsl:template match="Period" mode="tab">
        <xsl:variable name="class">
            <xsl:if test=".=//Period[position()=1]">active</xsl:if>
        </xsl:variable>
        <li class="{$class}">
            <xsl:element name="a">
                <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                <xsl:attribute name="data-toggle">tab</xsl:attribute>
                <xsl:value-of select="./Name"/>
            </xsl:element>
        </li>
    </xsl:template>


    <xsl:template match="Period" mode="full">
        <xsl:variable name="class">
            <xsl:if test=".=//Period[position()=1]">active</xsl:if>
        </xsl:variable>
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

                    <div class="accordion-heading">
                        <!-- data-parent="#accordion1" deleted -->
                        <a href="#{$acc_uni}" data-toggle="collapse" class="accordion-toggle">
                            <xsl:value-of select="CourseTitle"/>
                        </a>
                    </div>
                    <div class="accordion-body collapse" id="{$acc_uni}">
                        <div class="accordion-inner">
                            <div class="row-fluid">
                                <h4>Cours <xsl:value-of select="CourseTitle"/></h4>

                                <xsl:variable name="courseid">
                                    <xsl:value-of select="CourseId"/>
                                </xsl:variable>

                                <!-- Détails -->
                                <div id="chart_div{$courseid}"/>

                                <!-- NO MORE USED
                                <xsl:apply-templates select="ExamGrade" mode="show"/>
                                <xsl:apply-templates select="ProjectGrades" mode="show"/>
                                <xsl:apply-templates select="ExercicesGrades" mode="show"/>
                                -->
                            </div>

                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>


    <xsl:template match="ExamGrade" mode="show">
        <h3 class="heading">Exam Grade</h3>
        <dt>
            <xsl:value-of select="Grade"/>
        </dt>
    </xsl:template>

    <xsl:template match="ProjectGrades" mode="show">
        <h3 class="heading">Project Mean</h3>
        <dt>
            <xsl:value-of select="Grades/ProjectMean"/>
        </dt>
        <h3 class="heading">Details</h3>
        <h4 class="heading">Project</h4>
        <xsl:value-of select="Grades/ProjectGrade"/>
        <h4 class="heading">Report</h4>
        <xsl:value-of select="Grades/ReportGrade"/>
        <h4 class="heading">Presentation</h4>
        <xsl:value-of select="Grades/PresentationGrade"/>
    </xsl:template>

    <xsl:template match="ExercicesGrades" mode="show">
        <h3 class="heading">Exercices Mean</h3>
        <dt>
            <xsl:value-of select="ExerciceMean"/>
        </dt>
        <h3 class="heading">Details</h3>
        <xsl:for-each select="Exercices/Exercice">
            <h4 class="heading">Exercice - <xsl:value-of select="ExerciceTopics/Topics"/></h4>
            <xsl:value-of select="ExerciceGrade"/>
        </xsl:for-each>
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
        <xsl:value-of select="translate(.,$t,$newt)"/>
        <xsl:text> / </xsl:text>
    </xsl:template>
    <xsl:template match="Topic" mode="last">
        <xsl:variable name="t">
            <xsl:text>"</xsl:text>
        </xsl:variable>
        <xsl:variable name="newt">
            <xsl:text>“</xsl:text>
        </xsl:variable>
        <xsl:value-of select="translate(.,$t,$newt)"/>
    </xsl:template>





    <xsl:template match="Infos">

        <div id="contentwrapper">

            <h2 class="heading"> Grades </h2>
            <div class="row-fluid">

                <div class="span12">


                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <!-- Generate the tab menu ofr the current and other tabs -->

                            <xsl:apply-templates select="//Period" mode="tab"/>

                        </ul>
                        <div class="tab-content">
                            <xsl:apply-templates select="//Period" mode="full"/>

                        </div>
                    </div>
                </div>
            </div>
        </div>
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
</xsl:stylesheet>
