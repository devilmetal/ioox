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
                
                <script type="text/javascript" src="{$xslt-ressource-url}/js/base64.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/swfobject.js"></script>
                <script type="text/javascript" src="{$xslt-ressource-url}/js/downloadify.min.js"></script>
                <script src="{$xslt-ressource-url}/js/jspdf.js"></script>
            </site:header>
            <site:content>
                <!--<xsl:apply-templates select="/Root/child::node()"/>
                <a class="btn btn-primary download-pdf" href="#">
                    Download PDF
                </a>-->
                
                <iframe frameborder="0" width="500" height="400"></iframe>
                <script>
                    $(document).ready(function() {
                    
                    
                    var pdf = new jsPDF('p','in','letter')
                    , sizes = [12, 16, 20]
                    , fonts = [['Times','Roman'],['Helvetica',''], ['Times','Italic']]
                    , font, size, lines
                    , margin = 0.5 // inches on a 8.5 x 11 inch sheet.
                    , verticalOffset = margin
                    , loremipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus id eros turpis. Vivamus tempor urna vitae sapien mollis molestie. Vestibulum in lectus non enim bibendum laoreet at at libero. Etiam malesuada erat sed sem blandit in varius orci porttitor. Sed at sapien urna. Fusce augue ipsum, molestie et adipiscing at, varius quis enim. Morbi sed magna est, vel vestibulum urna. Sed tempor ipsum vel mi pretium at elementum urna tempor. Nulla faucibus consectetur felis, elementum venenatis mi mollis gravida. Aliquam mi ante, accumsan eu tempus vitae, viverra quis justo.\n\nProin feugiat augue in augue rhoncus eu cursus tellus laoreet. Pellentesque eu sapien at diam porttitor venenatis nec vitae velit. Donec ultrices volutpat lectus eget vehicula. Nam eu erat mi, in pulvinar eros. Mauris viverra porta orci, et vehicula lectus sagittis id. Nullam at magna vitae nunc fringilla posuere. Duis volutpat malesuada ornare. Nulla in eros metus. Vivamus a posuere libero.'
                    
                    // Margins:
                    pdf.setDrawColor(0, 255, 0)
                    .setLineWidth(1/72)
                    .line(margin, margin, margin, 11 - margin)
                    .line(8.5 - margin, margin, 8.5-margin, 11-margin)
                    
                    // the 3 blocks of text
                    for (var i in fonts){
                    if (fonts.hasOwnProperty(i)) {
                    font = fonts[i]
                    size = sizes[i]
                    
                    lines = pdf.setFont(font[0], font[1])
                    .setFontSize(size)
                    .splitTextToSize(loremipsum, 7.5)
                    // Don't want to preset font, size to calculate the lines?
                    // .splitTextToSize(text, maxsize, options)
                    // allows you to pass an object with any of the following:
                    // {
                    // 	'fontSize': 12
                    // 	, 'fontStyle': 'Italic'
                    // 	, 'fontName': 'Times'
                    // }
                    // Without these, .splitTextToSize will use current / default
                    // font Family, Style, Size.
                    console.log(lines);
                    pdf.text(0.5, verticalOffset + size / 72, lines)
                    
                    verticalOffset += (lines.length + 0.5) * size / 72
                    }
                    }
                    
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
            <xsl:for-each select="./child::node()">
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
            <xsl:for-each select="./child::node()">
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
