<?xml version="1.0" encoding="UTF-8"?>
<!--
        @project:   KLAXON
        @date:      16.07.2013
        @version:   1.0
        @desc:      Explorer page give the opportunitiy to search
                    a courses in the database and visit it.
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
        />static/ioox</xsl:variable>

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

                    <!--<div class="gh_button-group">
                        <a href="#" id="showCss" class="btn btn-primary btn-mini">Show CSS</a>
                        <a href="#" id="resetDefault" class="btn btn-mini">Reset</a>
                    </div>-->
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
            <!-- </site:header>-->

            <site:navbar/>

            <site:content>
                <!-- main content -->
                <xsl:variable name="query">
                    <xsl:value-of select="//Search/Query"/>
                </xsl:variable>
                <div id="contentwrapper">


                    <div class="row-fluid">

                        <!-- Search input -->
                        <div class="input-append">
                            <form action="explorer">
                                <input type="text" class="span3 offset8" name="search"
                                    placeholder="search terms" value="{$query}"/>
                                <button type="submit" class="btn">Search</button>
                            </form>
                        </div>

                        <!-- If in the pipeline there are data of a previuws search print the result -->
                        <xsl:if test="not(//Search/Query='')">
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3 class="heading">Result search for: <xsl:value-of
                                            select="$query"/></h3>

                                    <!-- If there are no course in search result say not found -->
                                    <xsl:if test="count(//Search/Period/Courses/Course) = 0">
                                        <p>Not found</p>
                                    </xsl:if>

                                    <!-- If there are period in the search result print it -->
                                    <xsl:apply-templates select="//Search/Period" mode="full"/>

                                </div>
                            </div>
                        </xsl:if>
                    </div>

                    <h3 class="heading"> Explorer </h3>
                    <div class="row-fluid">

                        <div class="span12">

                            <!--    The viev like tabs is done via CSS and HTML
                                to implement this function special id and a href to this id is done
                        
                                Structure:  ul menu with a to a href
                                            div with the correspondig id -->
                            <div class="tabbable">

                                <!-- Generate the menu based on the available period and add some static tabs -->
                                <ul class="nav nav-tabs">
                                    <!-- Generate the tab menu ofr the current and other tabs -->
                                    <xsl:apply-templates select="//CurrentPeriod"/>
                                    <xsl:apply-templates select="//PastPeriod"/>
                                    <li>
                                        <a href="#legend" data-toggle="tab">Legend</a>
                                    </li>

                                </ul>

                                <!-- Generate the tab conent -->
                                <div class="tab-content">
                                    <xsl:apply-templates select="//CurrentPeriod/Period[1]"
                                        mode="full">
                                        <xsl:with-param name="class">active</xsl:with-param>
                                    </xsl:apply-templates>
                                    <xsl:apply-templates select="//PastPeriod/Period" mode="full"/>
                                    <div class="tab-pane" id="legend">
                                        <dl class="dl-horizontal">
                                            <dt>Color indicator</dt>
                                            <dd><span class="square_sub">.</span>you are subscribed
                                                on the cours</dd>
                                            <dd><span class="square_unsub">.</span>you was subscibed
                                                on the cours</dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </site:content>
            <site:javascript>
                <script src="{$xslt-ressource-url}/js/jquery.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery-migrate.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery.debouncedresize.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery.actual.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery_cookie.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/bootstrap.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/bootstrap.plugins.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery.qtip.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery.jBreadCrumb.1.1.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/ios-orientationchange-fix.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/antiscroll.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery-mousewheel.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/jquery.colorbox.min.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/selectNav.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/gebo_common.js" type="text/javascript">//</script>
                <script src="{$xslt-ressource-url}/js/gebo_btns.js" type="text/javascript">//</script>
                <script>
                    $(document).ready(function() {
                    setTimeout('$("html").removeClass("js")',1000);
                    $(ssw_layout_fixed).click();
                    });
                </script>
            </site:javascript>
        </site:view>
    </xsl:template>

    <!-- Identify the current period and active it for the visualisation -->
    <xsl:template match="CurrentPeriod">
        <xsl:apply-templates select="Period[1]" mode="tab">
            <xsl:with-param name="class">active</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>

    <!-- Print the successive period and generate a dropdown menu fo the period 4,5,6,... -->
    <xsl:template match="PastPeriod">
        <xsl:apply-templates select="Period[1]" mode="tab"/>
        <xsl:apply-templates select="Period[2]" mode="tab"/>
        <xsl:apply-templates select="Period[3]" mode="dropdown"/>
    </xsl:template>

    <!-- template that generate a the li element of the menu -->
    <xsl:template match="Period" mode="tab">
        <xsl:param name="class"/>
        <li class="{$class}">
            <xsl:element name="a">
                <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                <xsl:attribute name="data-toggle">tab</xsl:attribute>
                <xsl:value-of select="./Name"/>
            </xsl:element>
        </li>
    </xsl:template>

    <!-- Template that generate the dropdown menu (archive period) -->
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

    <!-- Template that print the period in the full forms -->
    <xsl:template match="Period" mode="full">
        <xsl:param name="class"/>
        <xsl:variable name="id_tab">
            <xsl:value-of select="./End"/>
        </xsl:variable>
        <div class="tab-pane {$class}" id="{$id_tab}">
            <xsl:apply-templates select="Courses"/>
        </div>

    </xsl:template>

    <!-- For each course print the content -->
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
                        <xsl:value-of select="//Root/Person/Engagments/Engagment[CoursRef=$CN]/Role"
                        />
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
                                <div class="span5">
                                    <dl class="dl-horizontal dl-modif">
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
                                        <dt>Teacher</dt>
                                        <dd>
                                            <xsl:apply-templates select="CourseId" mode="teacher"/>
                                        </dd>
                                        <xsl:variable name="linkcourse"><xsl:value-of
                                                select="$xslt.base-url"/>me/courses/<xsl:value-of
                                                select="CourseId"/></xsl:variable>
                                        <dd>
                                            <button class="btn btn-inverse"
                                                onclick="javascript:window.location = '{$linkcourse}';"
                                                >Go to cours</button>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="span7">
                                    <dl>
                                        <dt>Description</dt>
                                        <dd>
                                            <xsl:apply-templates select="Description"/>
                                        </dd>
                                    </dl>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>




    <!-- reused code from other page - not commented -->
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
            <xsl:for-each select="./child::node()[name()!='ListHeader']">
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


    <xsl:template match="CourseId" mode="teacher">
        <xsl:variable name="cid">
            <xsl:value-of select="."/>
        </xsl:variable>
        <xsl:apply-templates
            select="//Root/Teacher/Person/Engagments/Engagment[CoursRef=$cid][Role!='Student']"
            mode="teacher"/>
        <xsl:if
            test="count(//Root/Teacher/Person/Engagments/Engagment[CoursRef=$cid][Role!='Student'])=0"
            > no teacher now </xsl:if>
    </xsl:template>

    <xsl:template match="Engagment" mode="teacher">
        <xsl:value-of select="./ancestor::Person/Lastname"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./ancestor::Person/Firstname"/>
        <br/>
    </xsl:template>

</xsl:stylesheet>
