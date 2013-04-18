<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    <xsl:template match="/">
        <site:view>
            <!-- </site:header>-->
            <site:content>
                    <!-- main content -->
                    <div id="contentwrapper">
                        <div class="main_content">
                            <div class="navbar">
                                <div class="navbar-inner">
                                    <div class="container-fluid">
                                        <a class="brand2" href="#">
                                            Me</a>
                                        <ul class="nav" id="mobile-nav-2">
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/home.png" alt="" /> MyHome </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/bookmark.png" alt="" /> Courses </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/addressbook.png" alt="" /> MyNote </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/pie-chart.png" alt="" /> Grades </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/calendar.png" alt="" /> Todos </a>
                                            </li>
                                            <li>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="navbar-inner">
                                    <div class="container-fluid">
                                        <a class="brand2" href="#">
                                            Teacher</a>
                                        <ul class="nav">
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/configuration.png" alt="" /> My Teaching </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/multi-agents.png" alt="" /> My Class </a>
                                            </li>
                                            <li class="divider-vertical hidden-phone hidden-tablet"></li>
                                            <li >
                                                <a  href="#"><img src="/exist/projets/ioox/static/ioox/img/gCons-mini-white/bar-chart.png" alt="" /> Manage Grades </a>
                                            </li>
                                            <li>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <h3 class="heading">Alerts</h3>
                                    <div class="alert">
                                        <a class="close" data-dismiss="alert">×</a>
                                        <strong>Lorem ipsum!</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae tristique erat.
                                    </div>
                                    <div class="alert alert-error">
                                        <a class="close" data-dismiss="alert">×</a>
                                        <strong>Lorem ipsum!</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae tristique erat.
                                    </div>
                                    <div class="alert alert-success">
                                        <a class="close" data-dismiss="alert">×</a>
                                        <strong>Lorem ipsum!</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae tristique erat.
                                    </div>
                                    <div class="alert alert-info">
                                        <a class="close" data-dismiss="alert">×</a>
                                        <strong>Lorem ipsum!</strong> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae tristique erat.
                                    </div>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span6">
                                    <div class="alert alert-block alert-error fade in">
                                        <a href="#" data-dismiss="alert" class="close">×</a>
                                        <h4 class="alert-heading">Lorem ipsum!</h4>
                                        <ul>
                                            <li>Lorem ipsum dolor sit amet.</li>
                                            <li>Lorem ipsum dolor sit amet.</li>
                                            <li>Lorem ipsum dolor sit amet.</li>
                                        </ul>
                                        <p><a href="#" class="btn btn-inverse"><i class="splashy-check"></i> Take this action</a> or <a href="#" class="btn"><i class="splashy-error_small"></i> Cancel</a></p>
                                    </div>
                                </div>
                                <div class="span6">
                                    <div class="alert alert-block alert-warning fade in">
                                        <h4 class="alert-heading">Lorem ipsum!</h4>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris vitae tristique erat.</p>
                                        <p><a href="#" class="btn btn-inverse">Take this action</a> or <a href="#" class="btn">Cancel</a></p>
                                    </div>
                                </div>
                            </div>
                            
                            
                        </div>
                    </div>
                     
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
                        <xsl:value-of select="StartTime"/> to <xsl:value-of select="EndTime"/><xsl:text> the </xsl:text> <xsl:value-of select="Date"></xsl:value-of>. </div>
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
            <li><xsl:value-of select="."/></li>
        </xsl:for-each>
        </ol>
    </xsl:template>
    
    <xsl:template match="ExternalDoc">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="Access/Location"/></xsl:attribute>
            <xsl:value-of select="Title"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="Link">
        <xsl:element name="a">
            <xsl:attribute name="href"><xsl:value-of select="LinkRef"/></xsl:attribute>
            <xsl:attribute name="alt"><xsl:value-of select="Comment"/></xsl:attribute>
            <xsl:value-of select="LinkText"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
