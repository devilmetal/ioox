<?xml version="1.0" encoding="UTF-8"?>
<!--
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XSLT pour l'affichage du Quizz, le code est en parti reprise de l'exemple fourni avec Oppidum.
                    Pour toutes question concernant le code, voire la documentation Oppidum.
 
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site" version="1.0">

  <!-- <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" doctype-system="about:legacy-compat" indent="yes"/>   -->
  <!-- sets output method to "html" otherwise Firefox makes an XML dom without document.body and jQuery.ready loops (!)  -->
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>

  <!-- Parameters (can be set on command line) -->
  <xsl:param name="xslt.base-url">resources/</xsl:param>

  <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
    />static/ioox</xsl:variable>
  <!--  Constants (set your own) -->
  <xsl:variable name="path.quizz.css"><xsl:value-of select="$xslt-ressource-url"
    />/css/quizz.css</xsl:variable>
  <xsl:variable name="path.quizz.js"><xsl:value-of select="$xslt-ressource-url"
    />/js/quizz.js</xsl:variable>

  <!--  i18n variables -->
  <xsl:variable name="i18n.true">
    <xsl:choose>
      <xsl:when test="/Quizz[@Lang = 'FR']">Vrai</xsl:when>
      <xsl:otherwise>True</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="i18n.false">
    <xsl:choose>
      <xsl:when test="/Quizz[@Lang = 'FR']">Faux</xsl:when>
      <xsl:otherwise>False</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="i18n.review">
    <xsl:choose>
      <xsl:when test="/Quizz[@Lang = 'FR']">Voir les erreurs</xsl:when>
      <xsl:otherwise>Review errors</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:param name="xslt.rights"/>

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
              <label class="radio inline"><input type="radio" name="ssw_menu" id="ssw_menu_click"
                  value=""/> Click</label>
              <label class="radio inline"><input type="radio" name="ssw_menu" id="ssw_menu_hover"
                  value="menu_hover"/> Hover</label>
            </div>
          </div>

          <div class="gh_button-group">
            <a href="#" id="showCss" class="btn btn-primary btn-mini">Show CSS</a>
            <a href="#" id="resetDefault" class="btn btn-mini">Reset</a>
          </div>
          <div class="hide">
            <ul id="ssw_styles">
              <li class="small ssw_mbColor sepH_a" style="display:none">body {<span
                  class="ssw_mColor sepH_a" style="display:none"> color: #<span/>;</span>
                <span class="ssw_bColor" style="display:none">background-color: #<span/>
                </span>}</li>
              <li class="small ssw_lColor sepH_a" style="display:none">a { color: #<span/> }</li>
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

        <link rel="stylesheet" href="{$path.quizz.css}" type="text/css" charset="utf-8"/>
        <script type="text/javascript" charset="utf-8" src="{$path.quizz.js}">//</script>
      </site:header>

      <!-- MENU DEFINITION -->
      <site:menu> </site:menu>
      <!-- SITE CONTENT -->
      <site:navbar> </site:navbar>
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
              <div style="width:500px;height:300px;overflow:hidden;position:relative">
                <div id="ui-prev">
                  <button onclick="javascript:$quizz.prevItem()">
                    <xsl:value-of select="$i18n.review"/>
                  </button>
                </div>
                <div id="ui-next">
                  <button onclick="javascript:$quizz.nextItem()">Play</button>
                </div>
                <xsl:apply-templates select="/child::node()"/>
              </div>

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

  <xsl:template match="Item">
    <div class="x-Item">
      <xsl:apply-templates select="Question"/>
      <xsl:apply-templates select="Choices|ChoicesTF"/>
    </div>
  </xsl:template>

  <xsl:template match="Question">
    <div class="x-Question">
      <p>
        <xsl:value-of select="."/>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="ChoicesTF[@Answer = 'true']">
    <ul class="x-Choices">
      <li class="x-Correct">
        <p class="x-Answer">
          <label>
            <input type="radio">
              <xsl:attribute name="name">
                <xsl:value-of
                  select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
              </xsl:attribute>
            </input>
            <xsl:value-of select="$i18n.true"/>
          </label>
        </p>
      </li>
      <li class="x-Incorrect">
        <p class="x-Answer">
          <label>
            <input type="radio">
              <xsl:attribute name="name">
                <xsl:value-of
                  select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
              </xsl:attribute>
            </input>
            <xsl:value-of select="$i18n.false"/>
          </label>
        </p>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="ChoicesTF[@Answer = 'false']">
    <ul class="x-Choices">
      <li class="x-Incorrect">
        <p class="x-Answer">
          <label>
            <input type="radio">
              <xsl:attribute name="name">
                <xsl:value-of
                  select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
              </xsl:attribute>
            </input>
            <xsl:value-of select="$i18n.true"/>
          </label>
        </p>
      </li>
      <li class="x-Correct">
        <p class="x-Answer">
          <label>
            <input type="radio">
              <xsl:attribute name="name">
                <xsl:value-of
                  select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
              </xsl:attribute>
            </input>
            <xsl:value-of select="$i18n.false"/>
          </label>
        </p>
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="Choices">
    <ul class="x-Choices">
      <xsl:apply-templates select="Choice"/>
    </ul>
  </xsl:template>

  <xsl:template match="Choice">
    <li>
      <xsl:apply-templates select="@State"/>
      <xsl:apply-templates select="Answer"/>
      <xsl:apply-templates select="Explain"/>
    </li>
  </xsl:template>

  <xsl:template match="@State[. = 'incorrect']">
    <xsl:attribute name="class">x-Incorrect</xsl:attribute>
  </xsl:template>

  <xsl:template match="@State[. = 'correct']">
    <xsl:attribute name="class">x-Correct</xsl:attribute>
  </xsl:template>

  <xsl:template match="Answer[count(ancestor::Choices/Choice[@State='correct'])>1]">
    <p class="x-Answer">
      <label>
        <input type="checkbox">
          <xsl:attribute name="name">
            <xsl:value-of select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
          </xsl:attribute>
        </input>
        <xsl:value-of select="."/>
      </label>
    </p>
  </xsl:template>

  <xsl:template match="Answer">
    <p class="x-Answer">
      <label>
        <input type="radio">
          <xsl:attribute name="name">
            <xsl:value-of select="concat('q', count(ancestor::Item/preceding-sibling::Item) + 1)"/>
          </xsl:attribute>
        </input>
        <xsl:value-of select="."/>
      </label>
    </p>
  </xsl:template>

  <xsl:template match="Explain">
    <p class="x-Explain">
      <xsl:value-of select="."/>
    </p>
  </xsl:template>

  <xsl:template name="prologue">
    <div class="x-Item cur">
      <h1>
        <xsl:value-of select="/Quizz/Title"/>
      </h1>
      <p class="x-Comment">
        <xsl:value-of select="/Quizz/Comment"/>
      </p>
      <xsl:choose>
        <xsl:when test="/Quizz[@Lang = 'FR']">
          <p>Cliquez sur “Play” pour commencer à répondre</p>
        </xsl:when>
        <xsl:otherwise>
          <p>Click “Play” to start answering</p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template name="epilogue">
    <div class="x-Item">
      <xsl:choose>
        <xsl:when test="/Quizz[@Lang = 'FR']">
          <p>Le test est terminé</p>
          <p class="v-results">Vous avez <span id="good">x</span> bonnes réponses sur un total de
              <span id="total">y</span> questions</p>
        </xsl:when>
        <xsl:otherwise>
          <p>The quizz is other</p>
          <p class="v-results">You have <span id="good">x</span> good answers on a total of <span
              id="total">y</span> questions</p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="Quizz">
    <xsl:call-template name="prologue"/>
    <xsl:apply-templates select="Item"/>
    <xsl:call-template name="epilogue"/>
  </xsl:template>
  <!-- Affichage d'une erreure -->
  <xsl:template match="Error">
    <div class="alert alert-error">
      <a class="close" data-dismiss="alert">×</a>
      <strong>Error : </strong>
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

  <!-- Affichage d'un message -->
  <xsl:template match="Message">
    <div class="alert alert-info" condition="has-message">
      <a class="close" data-dismiss="alert">×</a>
      <strong>Message : </strong>
      <xsl:value-of select="."/>
    </div>
  </xsl:template>

</xsl:stylesheet>
