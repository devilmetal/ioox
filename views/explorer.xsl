<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
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
            <!-- </site:header>-->
            <site:content>
                <!-- main content -->
                <div id="contentwrapper">

                    <div class="navbar">
                        <div class="navbar-inner">
                            <div class="container-fluid">
                                <a class="brand2" href="#"> Me</a>
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
                        <!-- Teacher menu bloqued -->
                        <div class="navbar-inner" style="display:none;">
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
                    </div>

                    <h3 class="heading"> Explorer </h3>
                    <div class="row-fluid">

                        <div class="span12">

                            <div class="tabbable">
                                <ul class="nav nav-tabs">
                                    <!-- Generate the tab menu ofr the current and other tabs -->
                                    <xsl:apply-templates select="//CurrentPeriod"/>
                                    <xsl:apply-templates select="//PastPeriod"/>
                                </ul>
                                <div class="tab-content">
                                    <xsl:apply-templates select="//CurrentPeriod/Period[1]" mode="full">
                                        <xsl:with-param name="class">active</xsl:with-param>
                                    </xsl:apply-templates>
                                    <xsl:apply-templates select="//PastPeriod/Period" mode="full"/>
                                    
                                    <div class="tab-pane" id="tab_dr2">
                                        <p>
                                            <strong>Section 2</strong><br/>Lorem ipsum dolor sit
                                            amet, consectetur adipiscing elit. </p>
                                    </div>
                                    <div class="tab-pane" id="tab_dr3">
                                        <p>
                                            <strong>Section 3</strong><br/>Lorem ipsum dolor sit
                                            amet, consectetur adipiscing elit. </p>
                                    </div>
                                    <div class="tab-pane" id="tab_dr4">
                                        <p>
                                            <strong>Section 4</strong><br/>Lorem ipsum dolor sit
                                            amet, consectetur adipiscing elit. </p>
                                    </div>
                                    <div class="tab-pane" id="tab_dr5">
                                        <p>
                                            <strong>Section 5</strong><br/>Lorem ipsum dolor sit
                                            amet, consectetur adipiscing elit. </p>
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

    <xsl:template match="CurrentPeriod">
        <xsl:apply-templates select="Period[1]" mode="tab" >
            <xsl:with-param  name="class" >active</xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="PastPeriod">
        <xsl:apply-templates select="Period[1]" mode="tab"/>
        <xsl:apply-templates select="Period[2]" mode="tab"/>
        <xsl:apply-templates select="Period[3]" mode="dropdown"/>
    </xsl:template>
    
    <xsl:template match="Period" mode="tab">
        <xsl:param name="class" />
        <li class="{$class}">
            <xsl:element name="a">
                <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                <xsl:attribute name="data-toggle">tab</xsl:attribute>
                <xsl:value-of select="./Name"/>
            </xsl:element>
        </li>
    </xsl:template>
    
    <xsl:template match="Period" mode="dropdown">
        <li class="dropdown">
            <a href="#" data-toggle="dropdown" class="dropdown-toggle">Archive <b class="caret"></b></a>
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
                            <xsl:attribute name="href">#<xsl:value-of select="./End"/></xsl:attribute>
                            <xsl:attribute name="data-toggle">tab</xsl:attribute>
                            <xsl:value-of select="./Name"/>
                        </xsl:element>
                    </li>
                </xsl:for-each>
                
            </ul>
        </li>
    </xsl:template>
    
    <xsl:template match="Period" mode="full">
        <xsl:param name="class"/>
        <xsl:variable name="id_tab"><xsl:value-of select="./End"/></xsl:variable>
        <div class="tab-pane {$class}" id="{$id_tab}">
            <xsl:apply-templates select="Courses"/>
        </div>
        
    </xsl:template>
    
    <xsl:template match="Courses">
        <div id="accordion1" class="accordion">
            <xsl:for-each select="Course">
                <xsl:variable name="acc_uni"><xsl:value-of select="ancestor::Period/End"/>-<xsl:value-of select="CourseId"/></xsl:variable>
                <div class="accordion-group">
                    <xsl:variable name="CN"><xsl:value-of select="./CourseId"/></xsl:variable>
                    <xsl:variable name="class"><xsl:value-of select="//Engagment[CoursRef=$CN]/Role"></xsl:value-of></xsl:variable>
                    
                    <div class="accordion-heading">
                        <a href="#{$acc_uni}" data-parent="#accordion1" data-toggle="collapse" class="accordion-toggle  {$class}">
                            <xsl:value-of select="CourseNo"/> - <xsl:value-of select="Title"/>
                        </a>
                    </div>
                    <div class="accordion-body collapse" id="{$acc_uni}">
                        <div class="accordion-inner">
                            <div class="row-fluid">
                            <div class="span5">
                                <p>debug: CN=<xsl:value-of select="$CN"/><br/>
                                class=<xsl:value-of select="$class"/></p>
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
                                    <dd><button class="btn btn-inverse">Go to cours</button></dd>
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
    
    
    
    
    <!-- code copie -->
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
