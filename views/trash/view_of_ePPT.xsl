<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>

    <!--    Retrive variable for Current usr ID -->
    <xsl:variable name="PersonId">1</xsl:variable>
    
    <!--    Retrive current course Id from XML/XPL (the GET/POST parameter is analysed in the XPL file) 
            and save id in a variable called CourseID -->
    <xsl:variable name="CourseId">
        <xsl:value-of select="/Root/CourseId"/>
    </xsl:variable>
    
    <!--    The root template of this XSLT -->
    <xsl:template match="/">
        
        <!-- oppidum zone view -->
        <site:view>
            
            <!-- oppidum timesheets zone -->
            <site:timesheets></site:timesheets> 

            <!--    oppidum menu static generation -->
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

            <!--    oppidum zone content -->
            <site:content>

                <!--    Generate the left menu
                        simply a list of button -->
                
                <div id="menubar">
                    <h3 id="menutitle">Courses ePPT</h3>
                    <!-- open the list -->
                    <ul>
                        <!--    Add the item <li></li> generate via a template 
                                on the XML data in the path /Root/COurses//Course.
                                mode menubar
                        -->
                        <xsl:apply-templates select="/Root/Courses//Course" mode="menubar">
                            <xsl:sort select="ID"/>
                        </xsl:apply-templates>
                    </ul>
                    
                </div>
                
                <!-- In a new div we call the template Course (whitout a mode) for the selected Course -->
                <div id="courseview">
                    <xsl:apply-templates select="/Root/Courses/Course[CourseId=$CourseId]"
                        mode="view"/>
                </div>
                
            </site:content>
            
        </site:view>
    </xsl:template>


    <!--    Declaration of the template Course mode menubar
            Produce a list of div with a button as element of the <li>  -->
    <xsl:template match="Course" mode="menubar">
        <li>
            <form action="ePPT" method="POST">
                <p style="text-align: right">
                    <input type="hidden" name="coursid" value="{CourseId}"/>
                    <input type="submit" value="{Acronym}" class="buttoncourse"/>
                </p>
            </form>
        </li>
    </xsl:template>

    <!--    Declaration of the template course mode view
            return a div container that contain a sequence of div slide
            every slide print the content of the course.
            The animation is done by the timesheet.js loaded in the header
    -->
    <xsl:template match="Course" mode="view">
            
        <!-- Retrive the value of TeachRef -->
        <xsl:variable name="TeachRe">
            <xsl:value-of select="TeacherRef"/>
        </xsl:variable>

        <!-- Open the div container, the list of attribute determinate the slideshow parameters -->
        <div id="slideshow" data-timecontainer="seq" data-timeaction="intrinsic">

        <!-- First slide "hardcoded" present the general information of the course -->
            <div id="slide1" class="crossfade" data-timecontainer="par" data-dur="5s">
                <!--[if lt IE 7]><p><br></p><![endif]-->
                <h3>
                    <xsl:value-of select="Title"/>
                </h3>
                <p>
                    <b>Professor : </b>
                    <!-- Retrive the name of the teacher from the curse via the TeachRe of the teacher -->
                    <xsl:apply-templates select="//Person[PersonId = $TeachRe]" mode="name"/>
                </p>
                <p>
                    <b>Description : </b>
                    <!-- call the template Description on the Description -->
                    <xsl:apply-templates select="Description"/>
                </p>
            </div>
            
            <!-- Call the template Session for generate the other slide -->
            <xsl:for-each select="./Sessions/Session">
                <xsl:apply-templates select="." mode="view"/>
            </xsl:for-each>
        </div>

    </xsl:template>

    <!-- Declare the Session template that will produce our slide2- to slideN -->
    <xsl:template match="Session" mode="view">
        
        <!-- generate a element div with the parameter of the slideshow -->
        <xsl:element name="div">
            <xsl:attribute name="id">slide<xsl:value-of select="No+1"/></xsl:attribute>
            <xsl:attribute name="class">crossfade</xsl:attribute>
            <xsl:attribute name="data-timecontainer">par</xsl:attribute>
            <xsl:attribute name="data-dur">5s</xsl:attribute>
            
            <!-- Print the data of the session -->
            <p class="mini caps"> This course is going to take place the <xsl:value-of select="Day"
                /> from <xsl:value-of select="StartTime"/> to <xsl:value-of select="EndTime"/><xsl:text> the </xsl:text>
                <xsl:value-of select="Date"/>. </p>
                <h4 class="topic">Topic : 
                <xsl:apply-templates select="Topic"/>
                </h4>
            
            <!--    The Redources can cointain different child node
                    for this reason we call directly the template on the node name-->
            <xsl:if test="Resources/child::node()">
                <h4 class="topic">Ressources : </h4>
                    <ul class="ressources">
                        <xsl:for-each select="Resources/child::node()">
                            <li>
                                <xsl:apply-templates select="."/>
                            </li>
                        </xsl:for-each>
                    </ul>
            </xsl:if>
        </xsl:element>


    </xsl:template>

    <!-- Template de base pour l'affichage d'une structure composée de Parag -->
    <xsl:template match="Description">
        <xsl:apply-templates select=".//Parag"/>
    </xsl:template>

    <xsl:template match="Parag">
        <xsl:value-of select="."/>
    </xsl:template>

    <!-- Template Personne that chois between the Mr/Mme -->
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

    <!-- Template That print the Description -->
    <xsl:template match="Description">
        
        <xsl:for-each select="./child::node()">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
        
    </xsl:template>

    <!-- Template that open the paragraph -->
    <xsl:template match="Parag">
        <p>
            <xsl:for-each select="node()">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </p>
    </xsl:template>

    <!-- Template that print fragment that can compose a Paragraph -->
    <xsl:template match="Fragment">
        <xsl:value-of select="."/>
    </xsl:template>

    <!--    Template that print the link that can be child of resources 
    <xsl:template match="Link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./LinkRef"/>
            </xsl:attribute>
            <xsl:value-of select="./LinkText"/>
        </xsl:element>
    </xsl:template>-->

    <!--    Template that print the list that can be child of resources -->
    <xsl:template match="List">
        <xsl:if test="count(./ListHeader)!=0">
            <span class="ListHeader">
                <xsl:value-of select="./ListHeader"/>
            </span>
        </xsl:if>
        <ol>
            <xsl:for-each select="./ListItem">
                <li>
                    <xsl:value-of select="."/>
                </li>
            </xsl:for-each>
        </ol>
    </xsl:template>

    <!--    Template that generate a external link, can be a hild of resources -->
    <xsl:template match="ExternalDoc">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="Access/Location"/>
            </xsl:attribute>
            <xsl:value-of select="Title"/>
        </xsl:element>
    </xsl:template>

    <!--    Template tha generate a link -->
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

    <!--    Tempalte that print the content of a Topic -->
    <xsl:template match="Topic">
        <xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
