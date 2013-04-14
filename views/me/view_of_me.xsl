<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    <xsl:template match="/">
        <site:view>
            <site:menu>
                <!-- Menu is done here ! -->
            </site:menu>
            <site:content>
                <xsl:choose>
                    <xsl:when test="//Session/Connected = ''">
                        <p>
                            You need to be connected !
                        </p>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="PersonIdVar" select="//Session/Connected"/>
                        <p>Good Job !</p>
                        <p>You are connected as : <xsl:value-of select="//Persons/Person[PersonId=$PersonIdVar]/Firstname"/> <xsl:value-of select="//Persons/Person[PersonId=$PersonIdVar]/Lastname"/></p>
                        <p>Your are listed as   : <xsl:value-of select="//Persons/Person[PersonId=$PersonIdVar]/Role"/></p>
                    </xsl:otherwise>
                </xsl:choose>
            </site:content>
        </site:view>
    </xsl:template>
</xsl:stylesheet>
