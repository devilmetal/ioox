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
                
                <!-- Calcul de la moyenne pour un cours -->
                <xsl:variable name="Course_Average">
                    <xsl:value-of
                        select="number(sum(/Root/Grades/Grade[CourseRef=$CourseId]/ExamGrade) div count(/Root/Grades/Grade[CourseRef=$CourseId]))"
                    />
                </xsl:variable>
                <xsl:variable name="My_Grade"><xsl:value-of select="/Root/Grades/Grade[CourseRef=$CourseId and StudentRef=$PersonId]/ExamGrade"></xsl:value-of></xsl:variable>

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
                    <xsl:choose>
                        <xsl:when test="count(/Root/Grades/Grade[CourseRef=$CourseId])=0">
                            <!-- No course Grade at all !-->
                            <div id="svg">
                                <svg width="1000px" height="500px" version="1.1"
                                    xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">
                                    
                                    <!-- axes -->
                                    <xsl:call-template name="build.axes"/>
                                    <!-- Construit les ticks de l'axe des opinions -->
                                    <xsl:call-template name="build.ticks"/>
                                    <!-- Construit dynamiquement les labels suivant le nombre de village -->
                                    <xsl:call-template name="build.labels"/>
                                    
                                    <g xmlns="http://www.w3.org/2000/svg">
                                        
                                        <xsl:element name="text">
                                            <xsl:attribute name="x">180</xsl:attribute>
                                            <xsl:attribute name="y">100</xsl:attribute>
                                            <xsl:attribute name="font-family">Verdana</xsl:attribute>
                                            <xsl:attribute name="font-size">18</xsl:attribute>
                                            <xsl:attribute name="transform">rotate(45 0 0)</xsl:attribute>
                                            <xsl:attribute name="fill">red</xsl:attribute>
                                            No grades for this course
                                        </xsl:element>
                                    </g>
                                </svg>
                            </div>
                        </xsl:when>
                        <xsl:when test="not(/Root/Grades/Grade[CourseRef=$CourseId and StudentRef=$PersonId]/ExamGrade)">
                            <!-- Your grade is not availlable for the moment -->
                            <xsl:variable name="Course_Average">
                                <xsl:value-of
                                    select="number(sum(/Root/Grades/Grade[CourseRef=$CourseId]/ExamGrade) div count(/Root/Grades/Grade[CourseRef=$CourseId]))"
                                /></xsl:variable>
                            
                            <div id="svg">
                                <svg width="1000px" height="500px" version="1.1"
                                    xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">
                                    
                                    <!-- axes -->
                                    <xsl:call-template name="build.axes"/>
                                    <!-- Construit les ticks de l'axe des opinions -->
                                    <xsl:call-template name="build.ticks"/>
                                    <!-- Construit dynamiquement les labels suivant le nombre de village -->
                                    <xsl:call-template name="build.labels"/>
                                    
                                    
                                    <!-- Transformation de la moyenne en hauteur graphique formule : -60x+300 = hauteur (ne pas oublier le -300 à la fin!)-->
                                    <xsl:variable name="heigth2"><xsl:value-of select="300 - (-60 * $Course_Average + 300)"/></xsl:variable>
                                    <!-- Calcule de la dérive en fonction du compteur (30 de marge et 80 de rectangle = 110 d'espace) -->
                                    <xsl:variable name="width2"><xsl:value-of select="110 * 2"/></xsl:variable>
                                    <defs>
                                        <linearGradient id="MonDegrade">
                                            <stop offset="5%" stop-color="#81C914" />
                                            <stop offset="95%" stop-color="#E8F5D5" />
                                        </linearGradient>
                                    </defs>
                                    <g xmlns="http://www.w3.org/2000/svg">
                                        
                                        <xsl:element name="rect">
                                            <xsl:attribute name="x"><xsl:value-of select="30 + $width2 - 80"/></xsl:attribute>
                                            <xsl:attribute name="y"><xsl:value-of select="390 - $heigth2"/></xsl:attribute>
                                            <xsl:attribute name="width">80</xsl:attribute>
                                            <xsl:attribute name="height"><xsl:value-of select="$heigth2"/></xsl:attribute>
                                            
                                            <xsl:attribute name="fill">url(#MonDegrade)</xsl:attribute>
                                            <xsl:attribute name="stroke-width">1px</xsl:attribute>
                                            <xsl:attribute name="stroke">#000000</xsl:attribute>
                                        </xsl:element>
                                        <xsl:element name="text">
                                            <xsl:attribute name="x">250</xsl:attribute>
                                            <xsl:attribute name="y">-90</xsl:attribute>
                                            <xsl:attribute name="font-family">Verdana</xsl:attribute>
                                            <xsl:attribute name="font-size">16</xsl:attribute>
                                            <xsl:attribute name="transform">rotate(90 0 0)</xsl:attribute>
                                            <xsl:attribute name="fill">red</xsl:attribute>
                                            Not Available
                                        </xsl:element>
                                    </g>
                                </svg>
                            </div>
                            
                        </xsl:when>
                        <xsl:otherwise>
                            <!-- Normal case -->
                            
                            <!-- Calcul de la moyenne pour un cours -->
                            <xsl:variable name="Course_Average">
                                <xsl:value-of
                                    select="number(sum(/Root/Grades/Grade[CourseRef=$CourseId]/ExamGrade) div count(/Root/Grades/Grade[CourseRef=$CourseId]))"
                                />
                            </xsl:variable>
                            <xsl:variable name="My_Grade"><xsl:value-of select="/Root/Grades/Grade[CourseRef=$CourseId and StudentRef=$PersonId]/ExamGrade"></xsl:value-of></xsl:variable>
                            <div id="svg">
                                <svg width="1000px" height="500px" version="1.1"
                                    xmlns="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xsl:version="1.0">
                                    
                                    <!-- axes -->
                                    <xsl:call-template name="build.axes"/>
                                    <!-- Construit les ticks de l'axe des opinions -->
                                    <xsl:call-template name="build.ticks"/>
                                    <!-- Construit dynamiquement les labels suivant le nombre de village -->
                                    <xsl:call-template name="build.labels"/>
                                    
                                    
                                    <!-- Transformation de la moyenne en hauteur graphique formule : -60x+300 = hauteur (ne pas oublier le -300 à la fin!)-->
                                    <xsl:variable name="heigth"><xsl:value-of select="300 - (-60 * $My_Grade + 300)"/></xsl:variable>
                                    <xsl:variable name="heigth2"><xsl:value-of select="300 - (-60 * $Course_Average + 300)"/></xsl:variable>
                                    <!-- Calcule de la dérive en fonction du compteur (30 de marge et 80 de rectangle = 110 d'espace) -->
                                    <xsl:variable name="width"><xsl:value-of select="110 * 1"/></xsl:variable>
                                    <xsl:variable name="width2"><xsl:value-of select="110 * 2"/></xsl:variable>
                                    <defs>
                                        <linearGradient id="MonDegrade">
                                            <stop offset="5%" stop-color="#81C914" />
                                            <stop offset="95%" stop-color="#E8F5D5" />
                                        </linearGradient>
                                    </defs>
                                    <g xmlns="http://www.w3.org/2000/svg">
                                        <xsl:element name="rect">
                                            <xsl:attribute name="x"><xsl:value-of select="30 + $width - 80"/></xsl:attribute>
                                            <xsl:attribute name="y"><xsl:value-of select="390 - $heigth"/></xsl:attribute>
                                            <xsl:attribute name="width">80</xsl:attribute>
                                            <xsl:attribute name="height"><xsl:value-of select="$heigth"/></xsl:attribute>
                                            
                                            <xsl:attribute name="fill">url(#MonDegrade)</xsl:attribute>
                                            <xsl:attribute name="stroke-width">1px</xsl:attribute>
                                            <xsl:attribute name="stroke">#000000</xsl:attribute>
                                        </xsl:element>
                                        
                                        <xsl:element name="rect">
                                            <xsl:attribute name="x"><xsl:value-of select="30 + $width2 - 80"/></xsl:attribute>
                                            <xsl:attribute name="y"><xsl:value-of select="390 - $heigth2"/></xsl:attribute>
                                            <xsl:attribute name="width">80</xsl:attribute>
                                            <xsl:attribute name="height"><xsl:value-of select="$heigth2"/></xsl:attribute>
                                            
                                            <xsl:attribute name="fill">url(#MonDegrade)</xsl:attribute>
                                            <xsl:attribute name="stroke-width">1px</xsl:attribute>
                                            <xsl:attribute name="stroke">#000000</xsl:attribute>
                                        </xsl:element>
                                    </g>
                                </svg>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>


            </site:content>
        </site:view>
    </xsl:template>

    <xsl:template match="Course" mode="menubar">
        <li>
            <form action="grades" method="POST">
                <p style="text-align: right">
                    <input type="hidden" name="coursid" value="{CourseId}"/>
                    <input type="submit" value="{Acronym}" class="buttoncourse"/>
                </p>
            </form>
        </li>
    </xsl:template>

    <!-- Axes -->
    <xsl:template name="build.axes">
        <xsl:variable name="widthPixels"><xsl:value-of select="2 * (80 + 30) + 50"/></xsl:variable>
        <g xmlns="http://www.w3.org/2000/svg">
            <line x1="30" y1="30" x2="30" y2="390"
                style="stroke:rgb(0,0,0);stroke-width:2;" />
            <xsl:element name="line">
                <xsl:attribute name="x1">30</xsl:attribute>
                <xsl:attribute name="y1">390</xsl:attribute>
                <xsl:attribute name="x2"><xsl:value-of select="$widthPixels"/></xsl:attribute>
                <xsl:attribute name="y2">390</xsl:attribute>
                <xsl:attribute name="style">stroke:rgb(0,0,0);stroke-width:2;</xsl:attribute>
            </xsl:element> 
        </g>
    </xsl:template>
    
    <!-- Ticks 0 à 6 -->
    <xsl:template name="build.ticks">
        <g xmlns="http://www.w3.org/2000/svg">
            <line x1="25" y1="390" x2="35" y2="390"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="390" 
                font-family="Verdana" font-size="12" >
                0
            </text>
            <line x1="25" y1="330" x2="35" y2="330"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="330" 
                font-family="Verdana" font-size="12" >
                1
            </text>
            <line x1="25" y1="270" x2="35" y2="270"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="270" 
                font-family="Verdana" font-size="12" >
                2
            </text>
            <line x1="25" y1="210" x2="35" y2="210"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="210" 
                font-family="Verdana" font-size="12" >
                3
            </text>
            <line x1="25" y1="150" x2="35" y2="150"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="150" 
                font-family="Verdana" font-size="12" >
                4
            </text>
            <line x1="25" y1="90" x2="35" y2="90"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="90" 
                font-family="Verdana" font-size="12" >
                5
            </text>
            <line x1="25" y1="30" x2="35" y2="30"
                style="stroke:rgb(0,0,0);stroke-width:1;" />
            <text x="15" y="30" 
                font-family="Verdana" font-size="12" >
                6
            </text>
        </g>
    </xsl:template>
    <!-- Labels -->
    <xsl:template name="build.labels">
        <xsl:variable name="widthPixels"><xsl:value-of select="2 * (80 + 30) + 50"/></xsl:variable>
        <g xmlns="http://www.w3.org/2000/svg">
            <text x="30" y="10" 
                font-family="Verdana" font-size="12" >
                [Grade Value]
            </text>
            <xsl:element name="text">
                <xsl:attribute name="x">340</xsl:attribute>
                <xsl:attribute name="y">230</xsl:attribute>
                <xsl:attribute name="font-family">Verdana</xsl:attribute>
                <xsl:attribute name="font-size">13</xsl:attribute>
                <xsl:attribute name="transform">rotate(45 0 0)</xsl:attribute>
                [My Grade]
            </xsl:element>
            
            <xsl:element name="text">
                <xsl:attribute name="x">430</xsl:attribute>
                <xsl:attribute name="y">140</xsl:attribute>
                <xsl:attribute name="font-family">Verdana</xsl:attribute>
                <xsl:attribute name="font-size">13</xsl:attribute>
                <xsl:attribute name="transform">rotate(45 0 0)</xsl:attribute>
                [Course Average]
            </xsl:element>
        </g>
    </xsl:template>
    
    
    
    <!--Random color pick-->
    <!--<xsl:variable name="random"><xsl:call-template name="random"/></xsl:variable>
                            <xsl:variable name="rgb1"><xsl:value-of select="$random"/></xsl:variable>
                            <xsl:variable name="rgb2"><xsl:value-of select="(($random+175)*$random) mod 255"/></xsl:variable>
                            <xsl:variable name="rgb3"><xsl:value-of select="round(($random+85) div $random*1000) mod 255"/></xsl:variable>
                            <xsl:variable name="rgb4"><xsl:value-of select="(($random+34)*45*$random) mod 255"/></xsl:variable>
                            <xsl:variable name="rgb5"><xsl:value-of select="$random"/></xsl:variable>
                            <xsl:variable name="rgb6"><xsl:value-of select="round(($random+45385) div $random*146954) mod 255"/></xsl:variable>-->
    <!--<xsl:template name="random">
        <xsl:variable name="random">
            <xsl:value-of select="(round(number(seconds-from-dateTime(current-dateTime()))*1000)+number(minutes-from-dateTime(current-dateTime()))+number(day-from-date(current-date()))+number(year-from-date(current-date()))+number(month-from-date(current-date()))) mod 255"/>
        </xsl:variable>
        <xsl:value-of select="$random"></xsl:value-of>        
    </xsl:template>-->
</xsl:stylesheet>
