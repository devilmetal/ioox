<?xml version="1.0" encoding="UTF-8"?>
<!-- Home View
        @author:   LC&GL
        @sdate:    27.02.2013
        @version:  2.0 (01.07.2013)
        @desc:     Me> cours page
                    -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/xhtml" omit-xml-declaration="yes" indent="no"/>
    <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"
    />static/ioox</xsl:variable>
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
        <xsl:variable name="xslt-ressource-url"><xsl:value-of select="$xslt.base-url"/>static/ioox</xsl:variable>
        
        <site:view>
            <site:header>
                
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jquery/jquery-1.7.1.min.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jquery/jquery-ui-1.8.17.custom.min.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jspdf.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/libs/FileSaver.js/FileSaver.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/libs/BlobBuilder.js/BlobBuilder.js"></script>
                
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jspdf.plugin.addimage.js"></script>
                
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jspdf.plugin.standard_fonts_metrics.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jspdf.plugin.split_text_to_size.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/jspdf.plugin.from_html.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/basic.js"></script>
            </site:header>
            <site:content>
                <!--<xsl:apply-templates select="/Root/child::node()"/>
                <a class="btn btn-primary download-pdf" href="#">
                    Download PDF
                </a>-->
                
                <div id="content" style="display:none;">
                    <xsl:apply-templates select="/Root/child::node()"/>
                </div>
                <iframe frameborder="0" width="100%" height="100%"></iframe>
                <script>
                    $(document).ready(function() {
                    
                    
                    var pdf = new jsPDF();
                    
                    // We'll make our own renderer to skip this editor
                    var specialElementHandlers = {
                    '#editor': function(element, renderer){
                    return true;
                    }
                    };
                    
                    // All units are in the set measurement for the document
                    // This can be changed to "pt" (points), "mm" (Default), "cm", "in"
                    pdf.fromHTML($('#content').get(0), 15, 15, {
                    'width': 300, 
                    'elementHandlers': specialElementHandlers
                    });
                    pdf.setFont('Helvetica','')
                    
                    var string = pdf.output('datauristring');
                    
                    $('iframe').attr('src', string);
                    
                    });
                </script>
                
            </site:content>
        </site:view>
    </xsl:template>
    
    <xsl:template match="Data">
        <h2>Notes for the course <xsl:value-of select="CourseNo"/> - <xsl:value-of select="Title"/></h2>
        <xsl:apply-templates select="Notes//Note"/>
    </xsl:template>
    <xsl:template match="Note">
        <h3><xsl:apply-templates select="Topics"/></h3>
        <xsl:apply-templates select="Content"/>
    </xsl:template>
    
    
    <xsl:template match="Topics">
        
        <xsl:apply-templates select="Topic[position()!=last()]" mode="notlast"/>
        <xsl:apply-templates select="Topic[position()=last()]" mode="last"/>
        
    </xsl:template>
    
    <xsl:template match="Topic" mode="notlast">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(.,$t,$newt)"/><xsl:text> / </xsl:text>
    </xsl:template>
    <xsl:template match="Topic" mode="last">
        <xsl:variable name="t"><xsl:text>"</xsl:text></xsl:variable>
        <xsl:variable name="newt"><xsl:text>“</xsl:text></xsl:variable>
        <xsl:value-of select="translate(.,$t,$newt)"/>
    </xsl:template>
    <!-- Affichage d'une erreure -->
    <xsl:template match="Error">
        <div class="alert alert-error">
            <a class="close" data-dismiss="alert">×</a>
            <strong>Error : </strong> <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <!-- Affichage d'un message -->
    <xsl:template match="Message">
        <div class="alert alert-info" condition="has-message">
            <a class="close" data-dismiss="alert">×</a>
            <strong>Message : </strong> <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    
    <!-- Affichage d'un content type -->
    <xsl:template match="Content">
        <xsl:for-each select="./child::node()">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Parag">
        <p>
            <xsl:for-each select="./child::node()">
                <xsl:apply-templates select="."/>
            </xsl:for-each>
        </p>
    </xsl:template>
    
    <xsl:template match="List">
        <xsl:if test="count(./ListHeader)!=0">
            <span class="ListHeader">
                <xsl:value-of select="./ListHeader"/>
            </span>
        </xsl:if>
        <ul class="list_b">
            <xsl:for-each select="./child::node()[name()!='ListHeader']">
                <li>
                    <xsl:apply-templates select="."/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="SubList">
        <xsl:if test="count(./SubListHeader)!=0">
            <span class="ListHeader">
                <xsl:value-of select="./SubListHeader"/>
            </span>
        </xsl:if>
        <ul class="list_c">
            <xsl:for-each select="./child::node()[name()!='SubListHeader']">
                <li>
                    <xsl:apply-templates select="."/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <xsl:template match="Fragment">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="Link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="./LinkRef"/>
            </xsl:attribute>
            <xsl:value-of select="./LinkText"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ExternalDoc">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="Access/Location"/>
            </xsl:attribute>
            <xsl:value-of select="Title"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>
