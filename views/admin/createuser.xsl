<?xml version="1.0" encoding="UTF-8"?>
<!--
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XSLT pour la page de création d'utilisateurs pour l'admin.
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
            </site:header>

            <!-- MENU DEFINITION -->
            <site:menu> </site:menu>
            <!-- SITE CONTENT -->
            <site:navbar/>





            <site:content>
                <xsl:choose>
                    <xsl:when test="/Root/Role != 'dba'">
                        <!-- NOT LOGGED IN  -->
                        <div> You are not admin. </div>
                    </xsl:when>
                    <xsl:otherwise>

                        <!-- Affichage
                            cas 1) child = Form => affichage du formulaire (et selon les erreurs associées)
                            cas 2) child = Done => affichage de l'après création, donc mot de pass + username
                        -->
                        <div class="row-fluid">
                            <xsl:apply-templates select="/Root/Core/child::node()"/>
                        </div>

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
            </site:javascript>
        </site:view>
    </xsl:template>

    <xsl:template match="Form">
        <div class="span12">
            <h3 class="heading">Create an user</h3>
            <div class="row-fluid">
                <div class="span8">
                    <form class="form-horizontal" method="post" action="#">
                        <fieldset>
                            <xsl:apply-templates select="Error"/>
                            <div class="control-group formSep">
                                <label for="username" class="control-label">Username</label>
                                <div class="controls">
                                    <!-- old or new value for username -->
                                    <xsl:variable name="username">
                                        <xsl:value-of select="Username/Text"/>
                                    </xsl:variable>
                                    <input type="text" id="username" name="username"
                                        class="input-xlarge" value="{$username}"/>

                                    <!-- si une erreur existe on l'affiche -->
                                    <xsl:apply-templates select="Username/Error"/>
                                </div>
                            </div>

                            <div class="control-group formSep">
                                <label for="fname" class="control-label">First Name</label>
                                <div class="controls">
                                    <!-- old or new value for fname -->
                                    <xsl:variable name="fname">
                                        <xsl:value-of select="Firstname/Text"/>
                                    </xsl:variable>
                                    <input type="text" id="fname" name="fname" class="input-xlarge"
                                        value="{$fname}"/>

                                    <!-- si une erreur existe on l'affiche -->
                                    <xsl:apply-templates select="Firstname/Error"/>
                                </div>
                            </div>

                            <div class="control-group formSep">
                                <label for="lname" class="control-label">Last Name</label>
                                <div class="controls">
                                    <!-- old or new value for lname -->
                                    <xsl:variable name="lname">
                                        <xsl:value-of select="Lastname/Text"/>
                                    </xsl:variable>
                                    <input type="text" id="lname" name="lname" class="input-xlarge"
                                        value="{$lname}"/>

                                    <!-- si une erreur existe on l'affiche -->
                                    <xsl:apply-templates select="Lastname/Error"/>
                                </div>
                            </div>

                            <div class="control-group formSep">
                                <label for="uniqueID" class="control-label">Unique ID</label>
                                <div class="controls">
                                    <!-- old or new value for uniqueID -->
                                    <xsl:variable name="uniqueID">
                                        <xsl:value-of select="UniqueID/Text"/>
                                    </xsl:variable>
                                    <input type="text" id="uniqueID" name="uniqueID"
                                        class="input-xlarge" value="{$uniqueID}"/>

                                    <!-- si une erreur existe on l'affiche -->
                                    <xsl:apply-templates select="UniqueID/Error"/>
                                </div>
                            </div>


                            <div class="control-group">
                                <div class="controls">
                                    <button class="btn btn-gebo" type="submit">Save changes</button>
                                    <button class="btn">Cancel</button>
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="Done">
        <div class="span3"/>
        <div class="span6">
            <h3 class="heading">New user data</h3>
            <dl class="dl-horizontal">
                <dt>Username</dt>
                <dd>
                    <xsl:value-of select="Username"/>
                </dd>
                <dt>Password</dt>
                <dd>
                    <xsl:value-of select="Password"/>
                </dd>
            </dl>
        </div>
        <div class="span3"/>
    </xsl:template>

    <xsl:template match="Error">
        <div class="alert alert-error">
            <a class="close" data-dismiss="alert">×</a>
            <strong>Error : </strong>
            <xsl:value-of select="."/>
        </div>
    </xsl:template>



</xsl:stylesheet>
