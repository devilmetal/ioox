<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
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
                    <h3 id="menutitle">ToDos</h3>
                </div>
            <div id="courseview">
                <h3 id="todotitle">TO DO LIST</h3>
                
                
                <xsl:apply-templates select="//ToDoList"/>
                
                
                <xsl:if test="contains($xslt.rights, 'modifier')">
                    <button title="Modifier la page" onclick="javascript:window.location.href+='/modifier'"
                        >Modifier</button>
                </xsl:if>
            </div>
        </site:content>
        </site:view>
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
                <xsl:value-of select="Title"/> - <xsl:value-of select="./Deadline/Date"/><xsl:text> @ </xsl:text><xsl:value-of select="./Deadline/Time"/>
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
   
</xsl:stylesheet>
