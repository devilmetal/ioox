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
            <site:navbar>


                <div class="navbar">
                    <xsl:if test="//Session/Role != '-1'">
                        <div class="navbar-inner">
                            <div class="container-fluid">
                                <!--<a class="brand2" href="#"> Me</a>-->
                                <ul class="nav" id="mobile-nav-2">
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/home.png"
                                                alt=""/> MyHome </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/bookmark.png"
                                                alt=""/> Courses </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/addressbook.png"
                                                alt=""/> MyNote </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/pie-chart.png"
                                                alt=""/> Grades </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/calendar.png"
                                                alt=""/> Todos </a>
                                    </li>
                                    <li> </li>
                                </ul>
                            </div>
                        </div>
                    </xsl:if>
                    <xsl:if test="//Session/Role != 'Student' and //Session/Role != '-1' ">
                        <div class="navbar-inner">
                            <div class="container-fluid">
                                <a class="brand2" href="#"> Teacher</a>
                                <ul class="nav">
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/configuration.png"
                                                alt=""/> My Teaching </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/multi-agents.png"
                                                alt=""/> My Class </a>
                                    </li>
                                    <li class="divider-vertical hidden-phone hidden-tablet"/>
                                    <li>
                                        <a href="#"><img
                                                src="{$xslt-ressource-url}/img/gCons-mini-white/bar-chart.png"
                                                alt=""/> Manage Grades </a>
                                    </li>
                                    <li> </li>
                                </ul>
                            </div>
                        </div>
                    </xsl:if>
                </div>

            </site:navbar>
            <site:content>


                <xsl:choose>
                    <xsl:when test="//Session/Id = '-1'">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page. </div>
                    </xsl:when>
                    <xsl:otherwise>
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
                <script type="text/javascript" src="https://www.google.com/jsapi"></script>
                <xsl:apply-templates select="/Root/Grades"></xsl:apply-templates>
            </site:javascript>
        </site:view>



    </xsl:template>
    <xsl:template match="Course" mode="restyle">
        <div class="span12">

            <!-- test -->
            <div class="span12">
                <h3 class="heading">
                    <xsl:value-of select="Title"/>
                </h3>
                <div class="tabbable">
                    <ul class="nav nav-tabs">
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
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab_br1">
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
                        <div class="tab-pane" id="tab_br3">
                            <dl class="dl-horizontal">
                                <dt>Cours name</dt>
                                <dd>
                                    <xsl:value-of select="Title"/>
                                </dd>
                                <dt>Acronym</dt>
                                <dd>
                                    <xsl:value-of select="Acronym"/>
                                </dd>
                                <dt>Cours number</dt>
                                <dd>
                                    <xsl:value-of select="CourseNo"/>
                                </dd>
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
                                <dd>Inscripted</dd>
                                <dt>Operation</dt>
                                <dd>unsubscribe</dd>
                                <dd>download all documentation</dd>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end -->
        </div>

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
                <xsl:apply-templates select="Topic"/>
            </h3>
            <dl class="dl-horizontal">
                <dt>Date-Time</dt>
                <dd>the <xsl:value-of select="format-date(./Date, '[D1].[M1].[Y01]')"/>, start
                        <xsl:value-of select="format-time(./StartTime,'[H1]:[m01]')"/> - end
                        <xsl:value-of select="format-time(./EndTime,'[H1]:[m01]')"/></dd>
                <dt>Room</dt>
                <dd>
                    <xsl:if test="not(*[./Room=''])">no room</xsl:if>
                    <xsl:value-of select="./Room"/>
                </dd>
                <xsl:apply-templates select="./Resources"/>
            </dl>
            <h4 class="heading">Description</h4>
            <xsl:apply-templates select="Description"/>

            <h4 class="heading">Exercise</h4>
            <xsl:apply-templates select="Exercise"/>

        </div>
    </xsl:template>



    <xsl:template match="Resources">
        <xsl:if test="count(Ressource/child::node()) &gt; 0">
            <dt>Resources</dt>
            <xsl:for-each select="child::Ressource">
                <dd>
                    <xsl:apply-templates select="."/>
                </dd>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>



    <xsl:template match="Session">
        <li>
            <div class="session">
                <h5>
                    <xsl:apply-templates select="Topic"/>
                </h5>
                <h5>Description</h5>
                <xsl:apply-templates select="Description"/>
                <div> This session is going to take place from <xsl:value-of select="StartTime"/> to
                        <xsl:value-of select="EndTime"/><xsl:text> the </xsl:text>
                    <xsl:value-of select="Date"/>. </div>

                <xsl:if test="Resources//Ressource/child::node()">


                    <xsl:for-each select="Resources/Ressource/child::node()">
                        <dd>
                            <xsl:apply-templates select="."/>
                        </dd>
                    </xsl:for-each>

                </xsl:if>
                <xsl:if test="Exercise">
                    <h5>Link to the exercices (Data and upload of solutions)</h5>
                    <xsl:apply-templates select="Exercise"/>
                </xsl:if>
            </div>
        </li>
        <hr/>
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
                            <xsl:apply-templates select="Description"/>
                        </div>
                    </div>
                </div>
            </div>
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

    <xsl:template match="Exercise">
        <xsl:variable name="id1">
            <xsl:value-of select="ancestor::Course/CourseId"/>
        </xsl:variable>
        <xsl:variable name="id2">
            <xsl:value-of select="ancestor::Session/SessionNumber"/>
        </xsl:variable>
        <p>
            <a href="{$xslt.base-url}me/courses/{$id1}/{$id2}">Link to the course</a>
        </p>
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


</xsl:stylesheet>
