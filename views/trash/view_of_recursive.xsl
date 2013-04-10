<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    <xsl:variable name="PersonId">1</xsl:variable>
    <xsl:variable name="CourseId"><xsl:value-of select="/Root/CourseId"></xsl:value-of></xsl:variable>
    <xsl:template match="/">
        <site:view>

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

            <site:content>
                
                <div id="menubar">
                    <h3 id="menutitle">Idea of this page</h3>
                    <p>The idea of this page is to produce a Latex code that can be compiled after a copy-paste in a TeX compiler.</p>
                    <p>Your goal will be to produce the <b>recursive algorithm</b> that tryp in the course database and produce this collection of all course..</p>
                    <p>Unfortunately, the rector is a perfectionist and want the layout to be done such a way :</p>
                    <ol>
                        <li>The important part is that you need to <b>enumerate the titles</b> (N°1 Cours X, N°2 Cours Y,...) remember that gaps can be found between the IDs</li>
                        <li>You need to colorate the titles in the code (not in the compiled Latex). The pattern must be : red-blue-yellow-pink-red</li>
                    </ol>
                    <p>Good luck ;)</p>
                </div>
                <div id="courseview">
                    
                    <h2>LateX of all course</h2>
                    
                    <div id="latex" style="display:none;">
                        <code>
                            \documentclass[a4paper,10pt]{article}<br/>
                            <br/>
                            \usepackage[utf8]{inputenc}<br/>
                            <br/>
                            \title{List Of Courses}<br/>
                            \author{<xsl:value-of select="//Person[PersonId=$PersonId]/Lastname"/><xsl:text> </xsl:text><xsl:value-of select="//Person[PersonId=$PersonId]/Firstname"/>}<br/>
                            \date{\today}<br/>
                            <br/>
                            \pdfinfo{%<br/>
                            /Title    (List Of Courses)<br/>
                            /Author   (<xsl:value-of select="//Person[PersonId=$PersonId]/Lastname"/><xsl:text> </xsl:text><xsl:value-of select="//Person[PersonId=$PersonId]/Firstname"/>)<br/>
                            /Creator  (<xsl:value-of select="//Person[PersonId=$PersonId]/Lastname"/><xsl:text> </xsl:text><xsl:value-of select="//Person[PersonId=$PersonId]/Firstname"/>)<br/>
                            /Subject  (List of all courses and associated professors)<br/>
                            /Keywords (list, course, courses, xmoodle, professor, latex)<br/>
                            }<br/>
                        \begin{document} <br/>
                        \maketitle <br/>
                        <xsl:apply-templates select="/Root/Courses/Course[1]" mode="latex">
                            <xsl:with-param name="current">1</xsl:with-param>
                            <xsl:with-param name="last"><xsl:value-of select="count(/Root/Courses/Course)"></xsl:value-of></xsl:with-param>
                        </xsl:apply-templates>
                            \end{document} <br/>
                        </code>
                    </div>
                    <button id="show" onclick="document.getElementById('latex').style.display = 'block';document.getElementById('hide').style.display = 'block';document.getElementById('show').style.display = 'none';"
                        >Show</button>
                    <button id="hide" style="display:none;" onclick="document.getElementById('latex').style.display = 'none';document.getElementById('show').style.display = 'block';document.getElementById('hide').style.display = 'none';"
                        >Hide</button>
                </div>
            </site:content>
        </site:view>
    </xsl:template>
    <xsl:template match="Course" mode="latex">
        <xsl:param name="current"/>
        <xsl:param name="last"/>
        <!-- TODO ! -->
        <!-- But : Afficher les cours avec dans le titre "Cours N°X : Acronym" -->
        <!-- Cet affichage oblige d'utiliser un template récursif pour compter le numéros, si les ID != numéro (en cas de sauts dans les IDs par exemples)-->
        <!-- De plus, on doit utiliser la fonction count() pour avoir la condition d'arret du template -->
        
        
        <!-- Switch pour la couleur du titre : les couleurs doivent respecter le pattern : red-blue-yellow-pink.  -->
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="($current mod 4) = 0">pink</xsl:when>
                <xsl:when test="($current mod 4) = 1">red</xsl:when>
                <xsl:when test="($current mod 4) = 2">blue</xsl:when>
                <xsl:when test="($current mod 4) = 3">yellow</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:text>
            
        </xsl:text>
        <!-- Do some stuff : affichage -->
        \begin{section}{
        <xsl:element name="span">
            <xsl:attribute name="style">color:<xsl:value-of select="$color"/>;</xsl:attribute>
            <xsl:text>$N\,^{\circ}{\rm</xsl:text><xsl:value-of select="$current"/><xsl:text> }$ </xsl:text><xsl:value-of select="./Acronym"/>
        </xsl:element>
            } <br/>
        ID : <xsl:value-of select="CourseId"/>\\<br/>
        Title : <xsl:value-of select="Title"/>\\<br/>
        Professor : <xsl:value-of select="//Person[PersonId=current()/TeacherRef]/Lastname"/><xsl:text> </xsl:text><xsl:value-of select="//Person[PersonId=current()/TeachRef]/Firstname"/>\\<br/>
        Description : \\<br/>
        <xsl:apply-templates select="./Description"/>    
        
        \end{section} <br/>
        
        
        <br/>
        <!-- Condition d'arret et relance récursive -->
        <xsl:choose>
            <xsl:when test="$current &lt; $last">
                <xsl:apply-templates select="/Root/Courses/Course[$current+1]" mode="latex">
                    <xsl:with-param name="current"><xsl:value-of select="$current+1"></xsl:value-of></xsl:with-param>
                    <xsl:with-param name="last"><xsl:value-of select="$last"></xsl:value-of></xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise><!-- Condition d'arret --></xsl:otherwise>
        </xsl:choose>
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
        </p> \\ <br/>
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
        \begin{enumerate} <br/>
            <xsl:for-each select="./ListItem">
                <xsl:text>\item </xsl:text> <xsl:value-of select="."/> <br/>
            </xsl:for-each>
        \end{enumerate} <br/>
    </xsl:template>
</xsl:stylesheet>
