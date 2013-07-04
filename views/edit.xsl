<?xml version="1.0" encoding="UTF-8"?>
<!-- Oppidum Framework
  
    Author: Stéphane Sire <s.sire@free.fr>
    
    Returns a <site:view> for loading the AXEL editor.
    Template and Resource URI must be given with absolute path (no URL rewriting).
    
    OCtober 2011
 -->

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:site="http://oppidoc.com/oppidum/site"
  xmlns="http://www.w3.org/1999/xhtml">
  
  <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:param name="xslt.skin"></xsl:param>
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
      <site:navbar/>
      <xsl:if test="$xslt.skin != ''">
        <xsl:attribute name="skin"><xsl:value-of select="$xslt.skin"/></xsl:attribute>
      </xsl:if>
      <site:modif>
        <button data-command="save" data-target="template-container">Save</button>
        <button data-command="preview" data-edit-label="Full editing">Preview</button>
      </site:modif>
      <site:content>
        <xsl:apply-templates select="*"/>
      </site:content>
    <site:change/>
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
  
  <xsl:template match="Edit[not(error)]">
    <div id="template-container" data-template="{Template}">
      <xsl:if test="Resource">
        <xsl:attribute name="data-src"><xsl:value-of select="Resource"/></xsl:attribute>
      </xsl:if>
      <p>Loading...</p>
    </div>
  </xsl:template>
  
  <xsl:template match="Edit[error]">
    <div>
      <p>Could not load the editor</p>
    </div>
  </xsl:template>
  
</xsl:stylesheet>