<?xml version="1.0" encoding="UTF-8"?>
<!-- Oppidum framework

    Login form generation

    Author: Stéphane Sire <s.sire@free.fr>
    
    Turns a <Login> model to a <site:content> module containing a login dialog
    box. Does nothing if the model contains a <Redirected> element (e.g. as a
    consequence of a successful login when handling a POST - see login.xql).

    July 2011
 -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:site="http://oppidoc.com/oppidum/site"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="yes"/>
  
  <!-- integrated URL rewriting... -->
  <xsl:param name="xslt.base-url"></xsl:param>  
  
  <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
  />static/ioox</xsl:variable>
  <xsl:template match="/">
    <site:view>       
      <xsl:apply-templates select="*"/>
    </site:view>
  </xsl:template>                        
                                  
  <!-- Login dialog box -->
  <xsl:template match="Login[not(Redirected)]">
    
    
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
      
      <!-- Dans notre cas, on doit chager TOUT comme ceci (c'est pas la mieux) mais le skin n'est pas chargé... il doit avoir une erreur dans Oppidum -->
      <link rel="stylesheet" href="{$xslt-ressource-url}/bootstrap/css/bootstrap.min.css"/>
      <link rel="stylesheet" href="{$xslt-ressource-url}/bootstrap/css/bootstrap-responsive.min.css"/>
      <!-- gebo blue theme-->
      <link  href="{$xslt-ressource-url}/css/blue.css" id="link_theme"/>
      <!-- breadcrumbs-->
      <link rel="stylesheet" href="{$xslt-ressource-url}/lib/jBreadcrumbs/css/BreadCrumb.css"/>
      <!-- tooltips-->
      <link rel="stylesheet" href="{$xslt-ressource-url}/lib/qtip2/jquery.qtip.min.css"/>
      <!--  code prettify -->
      <link rel="stylesheet" href="{$xslt-ressource-url}/lib/sticky/sticky.css"/>
      <!--  notifications -->
      <link rel="stylesheet" href="{$xslt-ressource-url}/lib/google-code-prettify/prettify.css"/>
      <!--  splashy icons -->
      <link rel="stylesheet" href="{$xslt-ressource-url}/img/splashy/splashy.css"/>
      <!--  colorbox -->
      <link rrel="stylesheet" href="{$xslt-ressource-url}/lib/colorbox/colorbox.css"/>
      <!--  main styles -->
      <link rel="stylesheet" href="{$xslt-ressource-url}/css/style.css"/>
      <link href="http://fonts.googleapis.com/css?family=PT+Sans"/>
    </site:header>
    
    <!-- MENU DEFINITION -->
    <site:menu> </site:menu>
    <!-- SITE CONTENT -->
    <site:navbar/>            
    <site:content>   
      <div>
        <xsl:if test="//error">
        <div class="alert alert-error" condition="has-message">
          <a class="close" data-dismiss="alert">×</a>
          Login failed
        </div>
        </xsl:if>
        <h1>Authentification</h1>
        <form action="{$xslt.base-url}login?url={To}" method="POST" style="margin: 0 auto 0 2em; width: 20em">
          <p style="text-align: right">
            <label for="login-user">Nom d'utilisateur</label>
            <input id="login-user" type="text" name="user" value="{User}"/>
          </p>
          <p style="text-align: right">
            <label for="login-passwd">Mot de passe</label>
            <input id="login-passwd" type="password" name="password"/>
          </p>                                   
          <p style="text-align: right; margin-right: 30px">
            <input type="submit"/>
          </p>
        </form>
      </div>        
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
    
    
  </xsl:template>  
  
  <xsl:template match="Login[Redirected]">
    <p>Goto <a href="{Redirected}"><xsl:value-of select="Redirected"/></a></p>
  </xsl:template>
  
</xsl:stylesheet>