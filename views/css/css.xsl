<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
        h1
        {
            color: red;
        }
    </xsl:template>    
</xsl:stylesheet>
