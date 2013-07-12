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
            <site:navbar />
                
            
            
                
                
            <site:content>
                <xsl:choose>
                    <xsl:when test="//Session/Id = '-1'">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this page. </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <h3 class="heading">Todos</h3>
                           <xsl:apply-templates select="//ToDoList"/>
                            <button title="Modifier la page" onclick="javascript:window.location.href+='/modifier'"
                                >Modifier</button>
                        
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
    
    <xsl:template match="ToDoList">
        <xsl:apply-templates select="//Activity"/>
    </xsl:template>
    
    <xsl:template match="Activity">
        <h3 class="heading"><xsl:value-of select="Title"/></h3>
        <xsl:apply-templates select="Tasks//Task"/>
    </xsl:template>
    
    <xsl:template match="Task">
        <xsl:variable name="prio"><xsl:value-of select="child::Priority"/></xsl:variable>
        <blockquote class="prio{$prio}">
            <h3 class="priohead{$prio}">
                <xsl:value-of select="Title"/>
                <span class="oursmall priohead{$prio}">
                (Prio: <xsl:value-of select="$prio"/>
                    <xsl:if test="count(Deadline) &gt; 0">
                        - deadline <xsl:value-of select="Deadline/Date"/>
                        <xsl:apply-templates select="Deadline/Time"/>
                    </xsl:if>)
                </span>
            </h3>
            <xsl:apply-templates select="Description"/>
        </blockquote>
        
        
    </xsl:template>
    
    <xsl:template match="Time">
        <xsl:text> </xsl:text><xsl:value-of select="format-time(.,'[H1]:[m1]')"/>
    </xsl:template>

	
    <!-- Affichage d'un content type -->

    <xsl:template match="ExternalDoc">
	<xsl:apply-templates select=".//Access"/><br/>
    </xsl:template>
	 
    <xsl:template match="Access">
    	 <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="Location"/></xsl:attribute>
            <xsl:value-of select="ancestor::ExternalDoc/Title"/>
        </xsl:element>
    </xsl:template>

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
        <xsl:if test="count(ListHeader) &gt; 0">
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
        <xsl:if test="count(SubListHeader) &gt; 0">
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
    
</xsl:stylesheet>
