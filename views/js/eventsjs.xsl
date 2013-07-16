<?xml version="1.0" encoding="UTF-8"?>
<!--
        @project:  KLAXON
        @date:     16.07.2013
        @version:  1.0
        @desc:     XSLT de la page eventsjs elle génère le JSON pour remplire le calendrier.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    
    <xsl:variable name="UserId"><xsl:value-of select="//SessionId/Id"/></xsl:variable>
    <xsl:template match="/">
        [
        <!-- Si la personne est connectée, on affiche quelque chose, sinon rien -->
        <xsl:choose>
            <xsl:when test="$UserId!='-1'">
                <!-- Affichage des jours de cours -->
                <xsl:apply-templates select="//SessionEnc"></xsl:apply-templates>
                <!-- Ajout d'un element de la todolist -->
                <xsl:apply-templates select="//Task"/>
                <!-- Ajout des vacances -->
                <xsl:apply-templates select="//Holiday"/>
            </xsl:when>
            <xsl:otherwise>
                {Sorry, no rights},
            </xsl:otherwise>
        </xsl:choose>
        <!-- Dernier element du tableau Json, permet d'eviter de longs traitement inutiles quand à la position des elements dans le tableau -->
         {}]
    </xsl:template>   
    
    
    
    <!-- MISE EN PAGE DES EVENTS D'UN JOUR AFFICHAGE DANS LE CALENDRIER-->
    <xsl:template match="SessionEnc">
        <xsl:variable name="CourseId"><xsl:value-of select="CourseId"/></xsl:variable>
        
            {
            "title" : "<xsl:apply-templates select="Session/Topics"/>",
            "start" : "<xsl:value-of select="Session/Date"/><xsl:text> </xsl:text><xsl:value-of select="format-time(Session/StartTime,'[H01]:[m01]:[s01]')"/>",
            "end"   : "<xsl:value-of select="Session/Date"/><xsl:text> </xsl:text><xsl:value-of select="format-time(Session/EndTime,'[H01]:[m01]:[s01]')"/>",
            "allDay": false,
            "url"   : "<xsl:value-of select="$xslt.base-url"/>me/courses/<xsl:value-of select="$CourseId"/>#tab_l<xsl:value-of select="Session/SessionNumber"/>"
            },  
        </xsl:template>
    
    
    <xsl:template match="ToDoList">
        <xsl:apply-templates select=".//Task"/>
    </xsl:template>
    
    <xsl:template match="Task">
        {
        "title" : "<xsl:value-of select="Title"/>",
        <xsl:choose>
            <xsl:when test="Deadline/Time">
                "start" : "<xsl:value-of select="Deadline/Date"/><xsl:text> </xsl:text><xsl:value-of select="Deadline/Time"/>",
                "end" : "<xsl:value-of select="Deadline/Date"/><xsl:text> </xsl:text><xsl:value-of select="Deadline/Time"/>",
                "allDay": false,
            </xsl:when>
            <xsl:otherwise>
                "start" : "<xsl:value-of select="Deadline/Date"/>",
                "allDay": true,
            </xsl:otherwise>
        </xsl:choose>
        "url"   : "<xsl:value-of select="$xslt.base-url"/>me/todo",
        "color" : "#cea97e",
        "textColor" : "#5e4223"
        }, 
    </xsl:template>
    
    <xsl:template match="Holiday">
        {
        "title" : "<xsl:value-of select="Explanation"/>",
        "start" : "<xsl:value-of select="Start"/>",
        <!-- Si il y a une fin ie les vacances sont plus longues que 1 jour on la note -->
        <xsl:if test="End">"end" : "<xsl:value-of select="End"/>",</xsl:if>
        "allDay" : true,
        "color" : "#aedb97",
        "textColor" : "#3d641b"
        },
    </xsl:template>
    
    <!-- Affiche les titres des topics -->
    <xsl:template match="Topics">
        <xsl:apply-templates select="Topic[position()!=last()]" mode="notlast"/>
        <xsl:apply-templates select="Topic[position()=last()]" mode="last"/>
    </xsl:template>
    <xsl:template match="Topic" mode="notlast">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(Title,$t,$newt)"/><xsl:text> / </xsl:text>
    </xsl:template>
    <xsl:template match="Topic" mode="last">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(Title,$t,$newt)"/>
    </xsl:template>
</xsl:stylesheet>
