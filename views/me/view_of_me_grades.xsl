<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    <xsl:template match="/">
        <site:view>
            <!--<site:header> @gil: why was header???-->
            <site:menu>
                <div id="menu">
                    <ul>
                        <li>
                            <b>Xmoodle</b>
                        </li>
                        <li>
                            <a href="home">Home</a>
                        </li>
                        <li>
                            <a href="courses">Courses</a>
                        </li>
                        <li>
                            <a href="todos">Todos</a>
                        </li>
                        <li>
                            <a href="grades">Grades</a>
                        </li>
                        <li>
                            <a href="ePPT">ePPT</a>
                        </li>
                        <li>
                            <a href="recursive">Recursive</a>
                        </li>
                    </ul>
                    
                </div>
            </site:menu>
            <!-- </site:header>-->
            <site:content>
                <!-- VARIABLES DE CREATION DE LA PAGE -->
                <xsl:variable name="CurrentCourse">
                    <xsl:value-of select="/Root/CoursID"/>
                </xsl:variable>
                <!-- FIN DES VARIABLES -->
                <div id="menubar">
                    <h3 id="menutitle">Courses</h3>
                    <ul>

                        <xsl:apply-templates select="/Root/Courses//Course" mode="menubar">
                            <xsl:sort select="ID"/>
                        </xsl:apply-templates>
                    </ul>
                </div>
                <div id="courseview">
                    <xsl:apply-templates select="/Root/Courses/Course[CourseId=$CurrentCourse]"
                        mode="view"/>
                </div>
                
            </site:content>
        </site:view>
    </xsl:template>

    <xsl:template match="Course" mode="menubar">
        <li>
            <form action="courses" method="POST">
                <p style="text-align: right">
                    <input type="hidden" name="coursid" value="{CourseId}"/>
                    <input type="submit" value="{Acronym}" class="buttoncourse"/>
                </p>
            </form>
        </li>
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
        <ul>
            <xsl:for-each select="./Sessions/Session">
                <xsl:apply-templates select="." mode="view"/>
            </xsl:for-each>
        </ul>
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
