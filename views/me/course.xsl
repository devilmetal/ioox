<?xml version="1.0" encoding="UTF-8"?>
<!-- Home View
        @author:   LC&GL
        @sdate:    27.02.2013
        @version:  2.0 (01.07.2013)
        @desc:     Me> cours page
                    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/xhtml" omit-xml-declaration="yes" indent="no"/>
    <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
    />static/ioox</xsl:variable>
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
        
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


                <xsl:choose>
                    <xsl:when test="//Session/Id = '-1'">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page. </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <h3 class="heading">Course detail</h3>
                        <xsl:apply-templates select="/Root/Error"></xsl:apply-templates>
                        <xsl:apply-templates select="/Root/Course" mode="restyle"/>
                    </xsl:otherwise>
                </xsl:choose>
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
                <xsl:apply-templates select="/Root/Means" mode="javascript"></xsl:apply-templates>
            </site:javascript>
        </site:view>



    </xsl:template>
    <xsl:template match="Course" mode="restyle">
        

            <!-- test -->
            
                <h3 class="heading">
                    <xsl:value-of select="//Root/Period/Courses/Course[CourseId=//Root/Course/CourseId]/Title"/>
                </h3>
                <div class="tabbable">
                    <ul class="nav nav-tabs">
                        
                        <!-- Traitement d'affichage -->
                        <xsl:choose>
                            <xsl:when test="Sessions and Evaluation">
                                <li class="active">
                                    <a href="#tab_br1" data-toggle="tab">Courses</a>
                                </li>
                                <li class="">
                                    <a href="#tab_br2" data-toggle="tab">Evaluation</a>
                                </li>
                                <li class="">
                                    <a href="#tab_br3" data-toggle="tab">Dettailes</a>
                                </li>
                                <li class="">
                                    <a href="#tab_br4" data-toggle="tab">Manage</a>
                                </li>
                            </xsl:when>
                            <xsl:otherwise>
                                <li class="active">
                                    <a href="#tab_br3" data-toggle="tab">Dettailes</a>
                                </li>
                                <li class="">
                                    <a href="#tab_br4" data-toggle="tab">Manage</a>
                                </li>
                            </xsl:otherwise>
                            
                        </xsl:choose>
                        
                    </ul>
                    <div class="tab-content">
                        <!-- Traitement d'affichage -->
                        <xsl:variable name="compltcourse"><xsl:if test="Sessions and Evaluation">active</xsl:if></xsl:variable>
                        <xsl:variable name="noInscCourse"><xsl:if test="not(Sessions and Evaluation)">active</xsl:if></xsl:variable>
                        <div class="tab-pane {$compltcourse}" id="tab_br1">
                            <!-- testo session -->
                            <div class="tabbable tabs-left">
                                <ul class="nav nav-tabs">

                                    <xsl:apply-templates select="Sessions/Session" mode="explorer"/>

                                </ul>
                                <div class="tab-content">
                                    <xsl:apply-templates select="Sessions/Session" mode="print"/>
                                </div>
                            </div>

                            <!-- end test session -->
                        </div>
                        <div class="tab-pane" id="tab_br2">
                            <dl class="dl-horizontal">
                                <xsl:apply-templates select="Evaluation"/>
                            </dl>
                            <h3 class="heading">Grades</h3>
                            <div id="chart_div"/>
                        </div>
                        <div class="tab-pane {$noInscCourse}" id="tab_br3">

    
                            <dl class="dl-horizontal">
                                <dt>Cours name</dt>
                                <dd>
                                    <xsl:value-of select="//Root/Period/Courses/Course[CourseId=//Root/Course/CourseId]/Title"/>
                                </dd>
                                <dt>Acronym</dt>
                                <dd>
                                    <xsl:value-of select="Acronym"/>
                                </dd>
                                <dt>Cours number</dt>
                                <dd>
                                    <xsl:value-of select="CourseNo"/>
                                </dd>
                                <dt>Period</dt>
                                <dd><xsl:value-of select="/Root/Period/Name"/></dd>
                                <dt>Professor</dt>
                                <dd>
                                    <ul class="list_a">
                                        <xsl:apply-templates select="/Root/Teachers" mode="teacher"
                                        />
                                    </ul>
                                </dd>
                                <dt>Description</dt>
                                <dd>
                                    <xsl:apply-templates select="Description"/>
                                </dd>
                            </dl>


                            
                        </div>
                        <div class="tab-pane" id="tab_br4">
                            <dl class="dl-horizontal">
                                <dt>Status</dt>
                                <dd>
                                    <!-- On va tester si la personne est inscrite ou pas et faire l'affichage selon -->
                                    <xsl:choose>
                                        <xsl:when test="Sessions and Evaluation">
                                            <dd>Subscribed</dd>
                                            <dt>Operation</dt>
                                            <dd>
                                                <form action="#" method="POST" onsubmit="return confirm('Are you sure you want to unsubscrib this course ?')">
                                                    <input type="hidden" name ="type" value="unsubscrib"/>
                                                    <input class="btn btn-inverse" type="submit"  value="Unsubscrib"/>
                                                 </form>
                                            </dd>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <dd>Not subscribed</dd>
                                            <dt>Operation</dt>
                                            <dd>
                                                <form action="#" method="POST" onsubmit="return confirm('Are you sure you want to subscrib this course ?')">
                                                    <input type="hidden" name ="type" value="subscrib"/>
                                                    <input class="btn btn-inverse" type="submit"  value="Subscrib"/>
                                                </form>
                                            </dd>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </dd>
                                <dd>download all documentation</dd>
                            </dl>
                        </div>
                    </div>
                </div>
            
            <!-- end -->
        

    </xsl:template>

    <!-- Generate the menu of the session-->
    <xsl:template match="Session" mode="explorer">
        <xsl:variable name="nr">
            <xsl:value-of select="./SessionNumber"/>
        </xsl:variable>
        <xsl:variable name="date">
            <xsl:value-of select="./Date"/>
        </xsl:variable>
        <xsl:variable name="precdate">
            <xsl:value-of select="preceding-sibling::Session/Date"/>
        </xsl:variable>

        <!--  &lt; instead of < and &gt; instead of >, b -->
        <xsl:variable name="current">
            <!--<xsl:choose>
                <xsl:when test="count(preceding-sibling::Session) = 0">
                    <xsl:if test="current-date() &lt; ./Session/Date">active</xsl:if>
                </xsl:when>
                <xsl:when
                    test="count(preceding-sibling::Session) &gt; 0 and count(preceding-sibling::Session) &lt; count(Session)">
                    <xsl:if test=" $precdate &lt; current-date() and current-date() &lt; $date"
                        >active</xsl:if>
                </xsl:when>
                <xsl:when test="count(following-sibling::Session)=0">
                    <xsl:if test="current-date() &gt; $date">active</xsl:if>
                </xsl:when>
            </xsl:choose>-->
        </xsl:variable>
        <li class="{$current}">
            <a href="#tab_l{$nr}" data-toggle="tab">Session <xsl:value-of
                    select="count(preceding-sibling::Session)"/></a>
        </li>
    </xsl:template>

    <xsl:template match="Session" mode="print">
        <xsl:variable name="nr">
            <xsl:value-of select="./SessionNumber"/>
        </xsl:variable>
        <xsl:variable name="date">
            <xsl:value-of select="./Date"/>
        </xsl:variable>
        <xsl:variable name="precdate">
            <xsl:value-of select="preceding-sibling::Session/Date"/>
        </xsl:variable>
        <xsl:variable name="current">
            <xsl:choose>
                <xsl:when test="count(preceding-sibling::Session) = 0">
                    <xsl:if test="current-date() &lt; ./Session/Date">active</xsl:if>
                </xsl:when>
                <xsl:when
                    test="count(preceding-sibling::Session) &gt; 0 and count(preceding-sibling::Session) &lt; count(Session)">
                    <xsl:if test=" $precdate &lt; current-date() and current-date() &lt; $date"
                        >active</xsl:if>
                </xsl:when>
                <xsl:when test="count(following-sibling::Session)=0">
                    <xsl:if test="current-date() &gt; $date">active</xsl:if>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        
        <div class="tab-pane {$current}" id="tab_l{$nr}">
            <h3 class="heading">
                <xsl:apply-templates select="Topics"/>
            </h3>
            <div class="row-fluid">
                <div class="span9">
                    <dl class="dl-horizontal dl-modif">
                <dt>Date-Time</dt>
                <dd>the <xsl:value-of select="format-date(./Date, '[D1].[M1].[Y01]')"/>, start
                        <xsl:value-of select="format-time(./StartTime,'[H1]:[m01]')"/> - end
                        <xsl:value-of select="format-time(./EndTime,'[H1]:[m01]')"/></dd>
                <dt>Room</dt>
                <dd>
                    <xsl:if test="not(*[./Room=''])">no room</xsl:if>
                    <xsl:value-of select="./Room"/>
                </dd>
            </dl>
            </div>
            <div class="span3">
                <xsl:variable name="Notelocation"><xsl:value-of select="$xslt.base-url"/>me/mynotes/<xsl:value-of select="./ancestor::Course/CourseId"/>/<xsl:value-of select="SessionNumber"/></xsl:variable>
                <a href="{$Notelocation}" class="btn btn-inverse m0010">Note</a><br/>
                <xsl:apply-templates select="Exercise" mode="link"/>
            </div>
            
            </div>
            <xsl:apply-templates select="Topics"/>
            
            <h4 class="heading">Description</h4>
            <xsl:apply-templates select="Description"/>
        
        </div>
    </xsl:template>

    <xsl:template match="Topics">
        <h4 class="heading">Topics</h4>
        <dl class="dl-horizontal dl-modif">
            <xsl:apply-templates select="Topic"/>
        </dl>
    </xsl:template>

    <xsl:template match="Topic">
        <dt><xsl:value-of select="."/></dt>
        <dd>
        <xsl:apply-templates select="./Resources"/>
        </dd>
    </xsl:template>
    
    <xsl:template match="Resources">
        <xsl:if test="count(Ressource/child::node()) &gt; 0">
            <ul class="list_a">
            <xsl:for-each select="child::Ressource">
                    <xsl:apply-templates select="."/>
            </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>

    <xsl:template match="Teachers" mode="teacher">
        <xsl:for-each select="Person">
            <li>
                <xsl:apply-templates select="." mode="teacher"/>
            </li>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="Person" mode="teacher">
        <xsl:value-of select="Lastname"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="Firstname"/>
    </xsl:template>
    <xsl:template match="Topic">
        <xsl:value-of select="."/>
    </xsl:template>

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
    
    <xsl:template match="Report">
        <dt class="minititle">Report</dt>
        <xsl:apply-templates select="child::node()" mode="small"/>
    </xsl:template>
    
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
                <xsl:value-of select="./ListHeader"/>
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
            <xsl:for-each select="./child::node()">
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


    <!-- code pour la génération du graphique simplifié des notes le tout est géré par Google Charts-->
    <xsl:template match="Means" mode="javascript">
        <!-- Si Grades est vide, donc on est pas connecté, donc on affichge pas ça. -->
       
            <script src="{$xslt-ressource-url}/js/jsapi.js"/>
        <script type="text/javascript">
            google.load("visualization", "1", {packages:["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
            var data = google.visualization.arrayToDataTable([
            ['Type', 'Grade', 'Global Mean']
            <xsl:apply-templates select="./child::node()" mode="javascript"/>
            ]);
            
            var options = {
            title: 'Course Grades',
            hAxis: {title: 'Type', titleTextStyle: {color: 'red'}},
            vAxis: {maxValue: 6, minValue: 0}
            };
            
            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            chart.draw(data, options);
            }
        </script>
    </xsl:template>
    
    <xsl:template match="ExamMean" mode="javascript">
        ,['Exam' ,<xsl:value-of select="Me"/>,<xsl:value-of select="Others"/>]
    </xsl:template>
<<<<<<< HEAD
    <xsl:template match="ExercicesMean" mode="javascript">
        ,['Exercises' ,<xsl:value-of select="Me"/>,<xsl:value-of select="Others"/>]
    </xsl:template>
    <xsl:template match="ProjectMean" mode="javascript">
        <xsl:apply-templates select="./child::node()" mode="javascript"/>
=======
    <xsl:template match="ProjectGrades" mode="javascript">
        <!-- Moyenne des notes des project steps de tous les autres -->
        <xsl:variable name="meanO"><xsl:value-of select="sum(//EverybodyGrades//Engagment/Grade/ProjectGrades/child::node()) div count(//EverybodyGrades//Engagment/Grade/ProjectGrades/child::node())"></xsl:value-of></xsl:variable>
        
        
        <!-- Moyenne des notes -->
        <xsl:variable name="mean"><xsl:value-of select="number(replace(ReportGrade,'',0)) + number(PresentationGrade) + number(ProjectGrade)) div 3"/></xsl:variable>
        ,['Project' ,<xsl:value-of select="$mean"/>,<xsl:value-of select="$meanO"/>]
>>>>>>> 59c7137b0cda31f98b157fd7a5c46c571b61ed39
    </xsl:template>
    
    <xsl:template match="Project" mode="javascript">
        ,['Project' ,<xsl:value-of select="Me"/>,<xsl:value-of select="Others"/>]
    </xsl:template>
    <xsl:template match="Report" mode="javascript">
        ,['Report' ,<xsl:value-of select="Me"/>,<xsl:value-of select="Others"/>]
    </xsl:template>
    <xsl:template match="Presentation" mode="javascript">
        ,['Presentation' ,<xsl:value-of select="Me"/>,<xsl:value-of select="Others"/>]
    </xsl:template>
    
    <!-- Affichage d'une erreure -->
    <xsl:template match="Error">
        <div class="alert alert-error">
            <a class="close" data-dismiss="alert">×</a>
            <strong>Error : </strong> <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <!-- Affichage d'un message -->
    <xsl:template match="Message">
        <div class="alert alert-info" condition="has-message">
            <a class="close" data-dismiss="alert">×</a>
            <strong>Message : </strong> <xsl:value-of select="."/>
        </div>
    </xsl:template>
</xsl:stylesheet>
