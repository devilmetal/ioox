<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:variable name="Year"><xsl:value-of select="//Date/Year"/></xsl:variable>
    <xsl:variable name="Month"><xsl:if test="string-length(//Date/Month)!=2">0</xsl:if><xsl:value-of select="//Date/Month"/></xsl:variable>
    <xsl:variable name="UserId"><xsl:value-of select="//Session/Id"/></xsl:variable>
    <xsl:template match="/">
        [
        <!-- Si la personne est connectée, on affiche quelque chose, sinon rien -->
        <xsl:choose>
            <xsl:when test="$UserId!='-1'">
                <!-- Affichage des jours de cours -->
                <xsl:apply-templates select="//Month[No=$Month]//Day">
                    <xsl:with-param name="YearNo"><xsl:value-of select="$Year"/></xsl:with-param>
                    <xsl:with-param name="MonthNo"><xsl:value-of select="$Month"/></xsl:with-param>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                {Sorry, no rights},
            </xsl:otherwise>
        </xsl:choose>
        
         {}]
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
        
        <xsl:variable name="FullDate">
            <xsl:value-of select="$YearNo"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="$MonthNo"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="$DayNo"/>
        </xsl:variable>
        <!-- Case : it exist a session for this day -->
        
        <!-- Ajout d'un session dans le calendrier -->
                        <xsl:apply-templates
                            select="//Session[Date=$FullDay]">
                            <xsl:sort select="StartTime"/>
                            <xsl:with-param name="FullDate"><xsl:value-of select="$FullDate"/></xsl:with-param>
                        </xsl:apply-templates>
        
        
        <!-- Ajout d'un element de la todolist -->
        <xsl:apply-templates select="//ToDoListPerson/ToDoList//Task[Deadline/Date=$FullDay]"/>
        
        <!-- Ajout des vacances -->
        <xsl:apply-templates select="/Root/Holidays//Holiday[Start=$FullDay]"/>
        
    </xsl:template>
    
    <!-- MISE EN PAGE DES EVENTS D'UN JOUR AFFICHAGE DANS LE CALENDRIER-->
    <xsl:template match="Session">
        <xsl:param name="FullDate"></xsl:param>
        <xsl:variable name="CourseId"><xsl:value-of select="ancestor::Course/CourseId"/></xsl:variable>
        
            {
            <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
            <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
            "title" : "<xsl:value-of select="translate(./Topic,$t,$newt)"/>",
            "start" : "<xsl:value-of select="$FullDate"/><xsl:text> </xsl:text><xsl:value-of select="format-time(StartTime,'[H01]:[m01]:[s01]')"/>",
        "end"   : "<xsl:value-of select="$FullDate"/><xsl:text> </xsl:text><xsl:value-of select="format-time(EndTime,'[H01]:[m01]:[s01]')"/>",
            "allDay": false,
            "url"   : "<xsl:value-of select="$xslt.base-url"/>me/courses/<xsl:value-of select="$CourseId"/>#<xsl:value-of select="SessionId"/>"
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
</xsl:stylesheet>
