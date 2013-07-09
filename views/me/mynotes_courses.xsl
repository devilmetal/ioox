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
    <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"/>static/ioox</xsl:variable>
    <xsl:template match="/">
       
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
                        
                            <!-- ENTER CONTENT HERE ! -->
                            <!-- Print path nav -->
                            <xsl:apply-templates select="//Root/Infos"/>
                            <!--<ul>
                                <xsl:apply-templates select="//Root/Session"/>
                            </ul>-->
                            <h3 class="heading">Sessions's note of cours: <xsl:value-of select="//Infos/Title"/></h3>
                            <xsl:apply-templates select="//AllSession"/>
                            
                        
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
        <xsl:variable name="courseid"><xsl:value-of select="/Root/Infos/CourseRef"/></xsl:variable>
        <xsl:variable name="sessionnumber"><xsl:value-of select="SessionNumber"/></xsl:variable>
        <li><a href="{$xslt.base-url}me/mynotes/{$courseid}/{$sessionnumber}">Link to the "notes" for : <xsl:apply-templates select="Topics"/></a></li>
    </xsl:template>
    
    <xsl:template match="Infos">
        <div id="jCrumbs" class="breadCrumb module">
            <ul>
                <li>
                    <a href="{$xslt.base-url}me/mynotes"><img src="{$xslt-ressource-url}/img/gCons-mini/addressbook.png" alt=""/>MyNotes</a>
                </li>
                <li>
                    <xsl:variable name="CourseRef"><xsl:value-of select="CourseRef"/></xsl:variable>
                    <xsl:value-of select="Title"/>
                </li>
                
            </ul>
        </div>
    </xsl:template>
    <xsl:template match="AllSession">
        <div class="row-fluid">
            <xsl:apply-templates select="Session" mode="app"/>
        </div>
    </xsl:template>
    <xsl:template match="Session" mode="app">
        <xsl:variable name="courseid"><xsl:value-of select="/Root/Infos/CourseRef"/></xsl:variable>
        <xsl:variable name="sessionnumber"><xsl:value-of select="SessionNumber"/></xsl:variable>
        <div class="span6">
            
                
                <xsl:choose>
                    <xsl:when test="//Root/Session[SessionNumber=$sessionnumber]/SessionNumber &gt; 0">
                        <div class="ourbox obc0">
                        <h4><xsl:apply-templates select="Topics"/></h4>
                        <span>Date <xsl:value-of select="format-date(Date, '[D1].[M1].[Y01]')"/></span>
                        <span>Time <xsl:value-of select="format-time(StartTime,'[H1]:[m01]')"/>-<xsl:value-of select="format-time(EndTime,'[H1]:[m01]')"/></span><br/>
                        <a href="{$xslt.base-url}me/mynotes/{$courseid}/{$sessionnumber}" class="btn btn-inverse btn-mini"><i class="splashy-view_list"></i> Show Note</a>
                        <p/>
                        <form action="#" method="POST" onsubmit="return confirm('Are you sure you want to delete this note ?')">
                            <input type="hidden" name="delete" value="{$courseid}-_-{$sessionnumber}"/>
                            <button class="btn btn-inverse btn-mini" type="submit">
                                <i class="splashy-document_letter_remove"/> Delete Note</button>
                        </form>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="ourbox obc2">
                        <h4><xsl:value-of select="Topic"/></h4>
                            <span>Date <xsl:value-of select="format-date(Date, '[D1].[M1].[Y01]')"/></span>
                            <span>Time <xsl:value-of select="format-time(StartTime,'[H1]:[m01]')"/>-<xsl:value-of select="format-time(EndTime,'[H1]:[m01]')"/></span><br/>
                        <a href="{$xslt.base-url}me/mynotes/{$courseid}/{$sessionnumber}/modifier" class="btn btn-inverse btn-mini"><i class="splashy-add"></i> Create Note</a>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            
        </div>
    </xsl:template>
    
    <xsl:template match="Topics">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:for-each select="Topic">
            <xsl:value-of select="translate(Topic,$t,$newt)"/><xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
