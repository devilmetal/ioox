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
                   
                    <h3 class="heading">
                        Explorer
                    </h3>
                    <div class="row-fluid">

                        <div class="span6">
                            asiojasdjaosidj
                        </div>
                        <div class="span6">
                            asiojasdjaosidj
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


    <xsl:template match="Course" mode="view">
        <h3>
            <xsl:value-of select="Title"/>
        </h3>
        <ul id="description">
            <xsl:variable name="Teacher">
                <xsl:value-of select="TeacherRef"/>
            </xsl:variable>
            <li>
                <strong>Professor : </strong>
                <xsl:apply-templates select="/Root/Persons/Person[PersonId = $Teacher]" mode="name"
                />
            </li>
            <li>
                <strong>Description : </strong>
                <xsl:apply-templates select="Description"/>
            </li>
        </ul>
        <!--
        <ul>
            <xsl:for-each select="./Sessions/Session">
                <xsl:apply-templates select="." mode="view"/>
            </xsl:for-each>
        </ul>-->
    </xsl:template>

    <xsl:template match="Session" mode="view">
        <li>
            <div class="session">
                <h5>
                    <xsl:value-of select="Title"/>
                </h5>
                <div> This course is going to take place the <xsl:value-of select="Day"/> from
                        <xsl:value-of select="StartTime"/> to <xsl:value-of select="EndTime"/><xsl:text> the </xsl:text>
                    <xsl:value-of select="Date"/>. </div>
                <div class="topic">
                    <h5>Topic : </h5>
                    <xsl:apply-templates select="Topic"/>
                </div>
                <xsl:if test="Resources/child::node()">
                    <div class="ressources">
                        <h5>Ressources : </h5>
                        <ul>
                            <xsl:for-each select="Resources/child::node()">
                                <li>
                                    <xsl:apply-templates select="."/>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>
                </xsl:if>
            </div>
        </li>
    </xsl:template>

    <xsl:template match="Topic">
        <xsl:value-of select="."/>
    </xsl:template>


    <!-- Template de base pour l'affichage d'une structure composée de Parag -->
    <xsl:template match="Description">
        <xsl:apply-templates select=".//Parag"/>
    </xsl:template>

    <xsl:template match="Parag">
        <xsl:value-of select="."/>
    </xsl:template>


    <xsl:template match="Person" mode="name">
        <xsl:choose>
            <xsl:when test="Role='student' and Sexe='M'">Mr.</xsl:when>
            <xsl:when test="Role='student' and Sexe='F'">Mme.</xsl:when>
            <xsl:when test="Role='professor'">Prof.</xsl:when>
        </xsl:choose>
        <xsl:text> </xsl:text>
        <xsl:value-of select="Lastname"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="Firstname"/>
    </xsl:template>

    <xsl:template match="Description">
        <xsl:for-each select="./child::node()">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="Parag">
        <p>
            <xsl:for-each select="node()">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </p>
    </xsl:template>

    <xsl:template match="Fragment">
        <xsl:value-of select="."/>
        <br/>
        <!-- THIS IS TRUE??? -->
    </xsl:template>

    <xsl:template match="Link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./LinkRef"/>
            </xsl:attribute>
            <xsl:value-of select="./LinkText"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="List">
        <xsl:if test="count(./ListHeader)!=0">
            <span class="ListHeader">
                <xsl:value-of select="./ListHeader"/>
            </span>
        </xsl:if>
        <ol>
            <xsl:for-each select="./ListItem">
                <li>
                    <xsl:value-of select="."/>
                </li>
            </xsl:for-each>
        </ol>
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
