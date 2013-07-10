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
            <site:navbar>
                
                <div class="main_content">
                    <div class="navbar">
                        <xsl:if test="//Session/Role != '-1'">
                            <div class="navbar-inner">
                                <div class="container-fluid">
                                    <!--<a class="brand2" href="#"> Me</a>-->
                                    <ul class="nav" id="mobile-nav-2">
                                        <li>
                                            <a href="#"><img src="{$xslt-ressource-url}/img/gCons-mini-white/home.png" alt=""/>
                                                MyHome </a>
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
                </div>
            </site:navbar>
            <site:content>
                <xsl:choose>
                    <xsl:when test="//Session/Id = '-1'">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page. </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="span12">
                            <!-- On va appliquer le template suivant le retour du XQuery soit : Null => pas loggé/pas incrit
                                                                                         soit : Courses => on affiche -->
                            <xsl:apply-templates select="/Root/Session"></xsl:apply-templates>
                        
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
    
    
    <xsl:template match="Session">
        <div id="msg_view" class="tab-pane">
            <div class="doc_view">
                <div class="doc_view_header">
                    <dl class="dl-horizontal">
                        <dt>Session Topics</dt>
                        <dd><xsl:apply-templates select="Topics"/></dd>
                        <dt>Exercise description</dt>
                    </dl>
                </div>
                <div class="doc_view_content">
                    <dt>Description</dt>
                    <xsl:apply-templates select="Exercise/Description"/>
                    <dt>Data</dt>
                    <xsl:apply-templates select="Exercise/Data"/>
                    
                </div>
                <div class="doc_view_footer clearfix">
                    <form enctype="multipart/form-data" method="POST" action="#">
                        <fieldset>
                            <legend>Upload Document:</legend>
                            <input type="file" name="file"/>
                            <input type="submit" value="Upload"/>
                        </fieldset>
                    </form>
                    
                    <xsl:apply-templates select="/Root/PreviousInfos[Date!='na']"/>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <!-- Affichage du lien vers l'ancien rendu d'exercice --> 
    <xsl:template match="PreviousInfos">
    <h4>Previous Uploaded document (<xsl:value-of select="format-dateTime(Date,'[Y0001]-[M01]-[D01] at [H01]:[m01]:[s01]')"/>):</h4>
        <xsl:value-of select="fo"></xsl:value-of>
	<xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="Link"/>
            </xsl:attribute>
            <xsl:value-of select="Name"/>
        </xsl:element>
    </xsl:template>

    <!-- Affichage des données de l'exercice -->
    <xsl:template match="Data"> 	
	<xsl:apply-templates select="child::node()"/>
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
        <ul>
            <xsl:for-each select="./child::node()">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="ListHeader">
        <span class="ListHeader">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    
    <xsl:template match="Fragment">
        <xsl:value-of select="."/>
        <!--<br/>
         THIS IS TRUE??? -->
    </xsl:template>
    
    <xsl:template match="Link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./LinkRef"/>
            </xsl:attribute>
            <xsl:value-of select="./LinkText"/>
        </xsl:element>
    </xsl:template>
    
    
    
    <xsl:template match="ListItem">
        <ol>
            <xsl:for-each select="./child::node()">
                <li><xsl:apply-templates select="."/></li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="SubList">
        <xsl:if test="count(./SubListHeader)!=0">
            <span class="SubListHeader">
                <xsl:value-of select="./SubListHeader"/>
            </span>
        </xsl:if>
        <ol>
            <xsl:for-each select="./SubListItem">
                <li><xsl:apply-templates select="./child::node()"/></li>
            </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="ExternalDoc">
        External document : <br/>
	<xsl:apply-templates select=".//Access"/><br/>
    </xsl:template>
	 
    <xsl:template match="Access">
    	 <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="Location"/></xsl:attribute>
            <xsl:value-of select="ancestor::ExternalDoc/Title"/>
        </xsl:element><br/>
    </xsl:template>
    
    <xsl:template match="Topics">
        
        <xsl:apply-templates select="Topic[position()!=last()]" mode="notlast"/>
        <xsl:apply-templates select="Topic[position()=last()]" mode="last"/>
        
    </xsl:template>
    
    <xsl:template match="Topic" mode="notlast">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(.,$t,$newt)"/><xsl:text> / </xsl:text>
    </xsl:template>
    <xsl:template match="Topic" mode="last">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(.,$t,$newt)"/>
    </xsl:template>
    
</xsl:stylesheet>
