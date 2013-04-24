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
   <xsl:template match="/">


      <xsl:variable name="PersonId">
         <xsl:value-of select="//UserBuildID"/>
      </xsl:variable>

      <!-- XTIGER DEFINITION -->
      <site:view>
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
            <link rel="shortcut icon" href="/exist/projets/ioox/static/ioox/img/gCons/connections.png"/>
         </site:header>

         <!-- MENU DEFINITION -->
         <site:menu> </site:menu>
         <!-- SITE CONTENT -->
         <site:navbar>
            
            <div class="main_content">
               <div class="navbar">
                  <div class="navbar-inner">
                     <div class="container-fluid">
                        <a class="brand2" href="#"> Me</a>
                        <ul class="nav" id="mobile-nav-2">
                           <li>
                              <a href="#"><img src="img/gCons-mini-white/home.png" alt=""/>
                                 MyHome </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/bookmark.png"
                                 alt=""/> Courses </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/addressbook.png"
                                 alt=""/> MyNote </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/pie-chart.png"
                                 alt=""/> Grades </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/calendar.png"
                                 alt=""/> Todos </a>
                           </li>
                           <li> </li>
                        </ul>
                     </div>
                  </div>
                  <div class="navbar-inner">
                     <div class="container-fluid">
                        <a class="brand2" href="#"> Teacher</a>
                        <ul class="nav">
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/configuration.png"
                                 alt=""/> My Teaching </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/multi-agents.png"
                                 alt=""/> My Class </a>
                           </li>
                           <li class="divider-vertical hidden-phone hidden-tablet"/>
                           <li>
                              <a href="#"><img
                                 src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/bar-chart.png"
                                 alt=""/> Manage Grades </a>
                           </li>
                           <li> </li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
         </site:navbar>
         <site:content>
                  <xsl:choose>
                     <xsl:when test="$PersonId = -1">
                        <!-- NOT LOGGED IN  -->
                        <div> You have to login to access this amazing page ! </div>
                     </xsl:when>
                     <xsl:otherwise>
                           <div>You are logged !</div>
                     </xsl:otherwise>
                  </xsl:choose>
         </site:content>
         <site:javascript>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery-migrate.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.debouncedresize.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.actual.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery_cookie.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/bootstrap.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/bootstrap.plugins.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.qtip.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.jBreadCrumb.1.1.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/ios-orientationchange-fix.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/antiscroll.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery-mousewheel.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/jquery.colorbox.min.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/selectNav.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/gebo_common.js" type="text/javascript">//</script>
            <script src="/exist/projets/ioox/static/ioox/js/gebo_btns.js" type="text/javascript">//</script>
            <script>
               $(document).ready(function() {
               setTimeout('$("html").removeClass("js")',1000);
               });
            </script>
         </site:javascript>
      </site:view>

   </xsl:template>

   <!-- TEMPLATE POUR LE MOIS (TITRE DU CALENDRIER) -->
   <xsl:template name="title">
      <xsl:param name="MonthNo"/>
      <xsl:choose>
         <xsl:when test="$MonthNo = 01">January</xsl:when>
         <xsl:when test="$MonthNo = 02">February</xsl:when>
         <xsl:when test="$MonthNo = 03">March</xsl:when>
         <xsl:when test="$MonthNo = 04">April</xsl:when>
         <xsl:when test="$MonthNo = 05">May</xsl:when>
         <xsl:when test="$MonthNo = 06">June</xsl:when>
         <xsl:when test="$MonthNo = 07">July</xsl:when>
         <xsl:when test="$MonthNo = 08">August</xsl:when>
         <xsl:when test="$MonthNo = 09">September</xsl:when>
         <xsl:when test="$MonthNo = 10">October</xsl:when>
         <xsl:when test="$MonthNo = 11">November</xsl:when>
         <xsl:when test="$MonthNo = 12">December</xsl:when>
      </xsl:choose>
   </xsl:template>

   <!-- TEMPLATE POUR CHAQUE JOUR DU MOIS -->
   <xsl:template match="Day">
      <xsl:param name="YearNo"/>
      <xsl:param name="MonthNo"/>
      <xsl:variable name="DayNo">
         <xsl:value-of select="./No"/>
      </xsl:variable>
      <xsl:variable name="FullDay">
         <xsl:value-of select="$YearNo"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$MonthNo"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$DayNo"/>
      </xsl:variable>
      <!-- Case 1 : no session for this day -->
      <xsl:if test="empty(/Root/Moodle/Courses/Course//Sessions//Session[Date=$FullDay])">
         <xsl:element name="li">
            <xsl:attribute name="class">
               <xsl:apply-templates select="./No" mode="empty">
                  <xsl:with-param name="YearNo">
                     <xsl:value-of select="$YearNo"/>
                  </xsl:with-param>
               </xsl:apply-templates>
            </xsl:attribute>
            <xsl:element name="div">
               <xsl:value-of select="./No"/>
            </xsl:element>
         </xsl:element>
      </xsl:if>

      <!-- Case 2 : it exist a session for this day -->
      <xsl:if test="not(empty(/Root/Moodle/Courses/Course//Sessions//Session[Date=$FullDay]))">
         <xsl:element name="li">
            <xsl:attribute name="class">
               <xsl:apply-templates select="./No">
                  <xsl:with-param name="YearNo">
                     <xsl:value-of select="$YearNo"/>
                  </xsl:with-param>
               </xsl:apply-templates>
            </xsl:attribute>
            <div class="today">
               <xsl:value-of select="./No"/>
               <ul class="calDayShort">
                  <xsl:apply-templates
                     select="/Root/Moodle/Courses/Course//Sessions//Session[Date=$FullDay]"
                     mode="short">
                     <xsl:sort select="StartTime"/>
                  </xsl:apply-templates>
               </ul>
               <div class="more">More &gt;&gt;</div>
            </div>
            <div class="calDayData">
               <h4>
                  <xsl:variable name="date">
                     <xsl:value-of select="$YearNo"/>
                     <xsl:text>-</xsl:text>
                     <xsl:value-of select="$MonthNo"/>
                     <xsl:text>-</xsl:text>
                     <xsl:value-of select="$DayNo"/>
                     <xsl:text>+01:00</xsl:text>
                  </xsl:variable>
                  <xsl:apply-templates select="//Month[No = $MonthNo]" mode="mo2">
                     <xsl:with-param name="date">
                        <xsl:value-of select="$date"/>
                     </xsl:with-param>
                  </xsl:apply-templates>
               </h4>
               <div class="calDayDetail">
                  <xsl:apply-templates
                     select="/Root/Moodle/Courses/Course//Sessions//Session[Date=$FullDay]"
                     mode="data">
                     <xsl:sort select="StartTime"/>
                  </xsl:apply-templates>
               </div>
            </div>
         </xsl:element>
      </xsl:if>
   </xsl:template>

   <!-- MISE EN PAGE DES EVENTS D'UN JOUR AFFICHAGE DANS LE CALENDRIER-->
   <xsl:template match="Session" mode="short">
      <li>
         <bold>
            <xsl:value-of select="./StartTime"/>
            <xsl:text> - </xsl:text>
         </bold>
         <xsl:value-of select="./Topic"/>
      </li>
   </xsl:template>

   <!-- MISE EN PAGE DES EVENTS D'UN JOUR AFFICHAGE DES DETAILS-->
   <xsl:template match="Session" mode="data">
      <xsl:element name="div">
         <xsl:attribute name="class"><xsl:value-of select="@type"/> born</xsl:attribute>

         <strong>
            <xsl:value-of select="self::node()/parent::node()/parent::node()/Title"/>
         </strong>
         <xsl:text> - </xsl:text>
         <xsl:value-of select="./StartTime"/>
         <xsl:text> to </xsl:text>
         <xsl:value-of select="./EndTime"/>
         <xsl:text> : </xsl:text>
         <strong>
            <xsl:apply-templates select="./Topic"/>
         </strong>
      </xsl:element>
   </xsl:template>

   <!-- MISE EN PAGE DU JOUR DANS l'ATTRIBUT DE LA LISTE -->
   <xsl:template match="No">
      <xsl:param name="YearNo"/>
      <xsl:variable name="NoY">
         <xsl:value-of select="ancestor::Calendar/Year[No=$YearNo]/No"/>
      </xsl:variable>
      <xsl:variable name="NoM">
         <xsl:value-of select="ancestor::Month/No"/>
      </xsl:variable>
      <xsl:variable name="NoD">01</xsl:variable>
      <xsl:variable name="date">
         <xsl:value-of select="$NoY"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoM"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoD"/>
         <xsl:text>+01:00</xsl:text>
      </xsl:variable>
      <xsl:variable name="date2">
         <xsl:value-of select="$NoY"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoM"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="."/>
         <xsl:text>+01:00</xsl:text>
      </xsl:variable>
      <xsl:variable name="NoValue">
         <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$NoValue = 01"> data <xsl:value-of
               select="lower-case(format-date($date,'[FNn]','en',(),()))"/></xsl:when>
         <xsl:when test="$NoValue != 01"> data</xsl:when>
      </xsl:choose>
      <xsl:if test="current-date()=$date2"> today</xsl:if>
   </xsl:template>

   <!-- Traitement pour l'affichage d'un jour vide -->
   <xsl:template match="No" mode="empty">
      <xsl:param name="YearNo"/>
      <xsl:variable name="NoY">
         <xsl:value-of select="ancestor::Calendar/Year[No=$YearNo]/No"/>
      </xsl:variable>
      <xsl:variable name="NoM">
         <xsl:value-of select="ancestor::Month/No"/>
      </xsl:variable>
      <xsl:variable name="NoD">01</xsl:variable>
      <xsl:variable name="date">
         <xsl:value-of select="$NoY"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoM"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoD"/>
         <xsl:text>+01:00</xsl:text>
      </xsl:variable>
      <xsl:variable name="date2">
         <xsl:value-of select="$NoY"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="$NoM"/>
         <xsl:text>-</xsl:text>
         <xsl:value-of select="."/>
         <xsl:text>+01:00</xsl:text>
      </xsl:variable>
      <xsl:variable name="NoValue">
         <xsl:value-of select="."/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$NoValue = 01">
            <xsl:value-of select="lower-case(format-date($date,'[FNn]','en',(),()))"/>
         </xsl:when>
         <xsl:when test="$NoValue != 01"/>
      </xsl:choose>
      <xsl:if test="current-date()=$date2"> today</xsl:if>
   </xsl:template>

   <xsl:template match="Month" mode="mo2">
      <xsl:param name="date"/>
      <!--formato giorno '[FNn]'-->
      <!-- <xsl:value-of select="current-date()"/>-->
      <xsl:value-of select="format-date($date,'[FNn], [D1o] [MNn,*-3], [Y]','en',(),())"/>
   </xsl:template>

   <!-- Formatage pour le upcoming events -->
   <xsl:template match="Day" mode="event">
      <xsl:param name="YearNo"/>
      <li>
         <div><xsl:value-of select="No"/>.<xsl:value-of select="parent::Month/No"/>.<xsl:value-of
               select="ancestor::Calendar/Year[No=$YearNo]/No"/></div>
         <ul class="list">
            <xsl:apply-templates select=".//Event" mode="list">
               <xsl:sort select="Time"/>
               <!-- USE XSLT SORT PARAMETER TO SORT BY TIME -->
            </xsl:apply-templates>
         </ul>
      </li>
   </xsl:template>

   <!-- TEMPLATE ToDoList -->
   <xsl:template match="ToDoList">
      <xsl:apply-templates select="./Activity"/>
   </xsl:template>

   <xsl:template match="Activity">
      <h3>
         <xsl:value-of select="./Title"/>
      </h3>
      <xsl:apply-templates select="./Tasks"/>
   </xsl:template>

   <xsl:template match="Tasks">
      <ul>
         <xsl:apply-templates select=".//Task"/>
      </ul>
   </xsl:template>

   <xsl:template match="Task">
      <li class="task">
         <xsl:element name="span">
            <xsl:attribute name="class"> task_description <xsl:text> </xsl:text> p<xsl:value-of
                  select="Priority"/>
            </xsl:attribute>
            <xsl:value-of select="Title"/> - <xsl:value-of select="./Deadline/Date"
               /><xsl:text> @ </xsl:text><xsl:value-of select="./Deadline/Time"/>
         </xsl:element>

         <div class="task_description">
            <xsl:for-each select="Description/child::node()">
               <xsl:apply-templates select="."/>
            </xsl:for-each>
         </div>
      </li>
   </xsl:template>



   <!-- PARTIE AFFICHAGE D'UN ELEMENT DE TYPE DESCRIPTION (PARAG+LIST) -->
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
      <ul>
         <xsl:for-each select="./ListItem">
            <li>
               <xsl:value-of select="."/>
            </li>
         </xsl:for-each>
      </ul>
   </xsl:template>
   <!-- FIN -->

   <!-- Template pour l'upcoming event -->
   <xsl:template name="upcomingevent">
      <xsl:param name="year"/>
      <xsl:param name="month"/>
      <xsl:param name="day"/>
      <ul>
         <xsl:call-template name="eventItem">
            <xsl:with-param name="current">
               <xsl:value-of select="$day"/>
            </xsl:with-param>
            <xsl:with-param name="last">
               <xsl:value-of select="//Month[No=$month]/Day[last()]/No"/>
            </xsl:with-param>
            <xsl:with-param name="peusdoDate">
               <xsl:value-of select="$year"/>
               <xsl:text>-</xsl:text>
               <xsl:value-of select="$month"/>
               <xsl:text>-</xsl:text>
            </xsl:with-param>

         </xsl:call-template>
      </ul>
   </xsl:template>

   <xsl:template name="eventItem">
      <xsl:param name="current"/>
      <xsl:param name="last"/>
      <xsl:param name="peusdoDate"/>
      <!-- Affichage des events -->
      <xsl:variable name="date">
         <xsl:value-of select="$peusdoDate"/>
         <xsl:if
            test="$current=0 or $current=1 or $current=2 or $current=3 or $current=4 or $current=5 or $current=6 or $current=7 or $current=8 or $current=9"
            >0</xsl:if>
         <xsl:value-of select="$current"/>
      </xsl:variable>
      <!--Partie sur les cours à venir -->
      <xsl:apply-templates select="//Session[Date=$date]" mode="upevent"/>
      <!-- Partie sur les todo -->
      <xsl:apply-templates select="//Task[Deadline/Date=$date]" mode="upevent"/>
      <xsl:choose>
         <xsl:when test="number($current)&lt;number($last)">
            <xsl:call-template name="eventItem">
               <xsl:with-param name="current">
                  <xsl:value-of select="$current+1"/>
               </xsl:with-param>
               <xsl:with-param name="last">
                  <xsl:value-of select="$last"/>
               </xsl:with-param>
               <xsl:with-param name="peusdoDate">
                  <xsl:value-of select="$peusdoDate"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise><!-- Condition d'arret --></xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="Session" mode="upevent">
      <li>
         <xsl:text>[</xsl:text>
         <xsl:value-of select="parent::node()/parent::node()/Acronym"/>
         <xsl:text>]</xsl:text>
         <xsl:value-of select="Topic"/>
         <xsl:text> : </xsl:text>
         <!-- Traitement différent si la date est celle d'aujourd'hui. -->
         <xsl:choose>
            <xsl:when test="Date=current-date()">
               <b>
                  <xsl:text>today at </xsl:text>
                  <xsl:value-of select="StartTime"/>
               </b>
            </xsl:when>
            <xsl:otherwise>
               <b>
                  <xsl:value-of select="Date"/>
               </b>
            </xsl:otherwise>
         </xsl:choose>

      </li>
   </xsl:template>

   <xsl:template match="Task" mode="upevent">
      <li>
         <xsl:value-of select="Title"/>
         <xsl:text> : </xsl:text>
         <!-- Traitement différent si la date est celle d'aujourd'hui. -->
         <xsl:choose>
            <xsl:when test="Deadline/Date=current-date()">
               <b>
                  <xsl:text>today at </xsl:text>
                  <xsl:value-of select="Deadline/Time"/>
               </b>

            </xsl:when>
            <xsl:otherwise>
               <b>
                  <xsl:value-of select="Deadline/Date"/>
               </b>
            </xsl:otherwise>
         </xsl:choose>
      </li>
   </xsl:template>
</xsl:stylesheet>
