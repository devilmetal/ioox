<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
        <xsl:variable name="Month">04</xsl:variable>
        <xsl:variable name="Year">2013</xsl:variable>
        /* [ ---- Gebo Admin Panel - calendar ---- ] */
        
        $(document).ready(function() {
        gebo_calendar.regular();
        gebo_calendar.google();
        //* resize elements on window resize
        var lastWindowHeight = $(window).height();
        var lastWindowWidth = $(window).width();
        $(window).on("debouncedresize",function() {
        if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){
        lastWindowHeight = $(window).height();
        lastWindowWidth = $(window).width();
        //* rebuild calendar
        $('#calendar').fullCalendar('render');
        $('#calendar_google').fullCalendar('render');
        }
        });
        });
        
        //* calendar
        gebo_calendar = {
        regular: function() {
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var calendar = $('#calendar').fullCalendar({
        header: {
        left: 'prev next',
        center: 'title,today',
        right: 'month,agendaWeek,agendaDay'
        },
        buttonText: {
        prev: '<i class="icon-chevron-left cal_prev" />',
        next: '<i class="icon-chevron-right cal_next" />'
        },
        aspectRatio: 2,
        selectable: false,
        selectHelper: true,
        select: function(start, end, allDay) {
        var title = prompt('Event Title:');
        if (title) {
        calendar.fullCalendar('renderEvent',
        {
        title: title,
        start: start,
        end: end,
        allDay: allDay
        },
        true // make the event "stick"
        );
        }
        calendar.fullCalendar('unselect');
        },
        editable: true,
        theme: false,
        events: [<xsl:apply-templates select="/Root/Year[No=$Year]/Month[No=$Month]//Day">
            <xsl:with-param name="YearNo"><xsl:value-of select="$Year"/></xsl:with-param>
            <xsl:with-param name="MonthNo"><xsl:value-of select="$Month"/></xsl:with-param>
        </xsl:apply-templates>
        ],
        eventColor: '#bcdeee'
        })
        },
        google: function() {
        var calendar = $('#calendar_google').fullCalendar({
        header: {
        left: 'prev next',
        center: 'title,today',
        right: 'month,agendaWeek,agendaDay'
        },
        buttonText: {
        prev: '<i class="icon-chevron-left cal_prev" />',
        next: '<i class="icon-chevron-right cal_next" />'
        },
        aspectRatio: 3,
        theme: false,
        events: {
        url:'http://www.google.com/calendar/feeds/usa__en%40holiday.calendar.google.com/public/basic',
        title: 'Italian Holidays',
        color: '#bcdeee'
        },
        eventClick: function(event) {
        // opens events in a popup window
        window.open(event.url, 'gcalevent', 'width=700,height=600');
        return false;
        }
        
        })
        }
        };
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
        <xsl:if test="not(empty(//Session[Date=$FullDay]))">
                        <xsl:apply-templates
                            select="//Session[Date=$FullDay]">
                            <xsl:sort select="StartTime"/>
                            <xsl:with-param name="FullDate"><xsl:value-of select="$FullDate"/></xsl:with-param>
                        </xsl:apply-templates>
        </xsl:if>
    </xsl:template>
    
    <!-- MISE EN PAGE DES EVENTS D'UN JOUR AFFICHAGE DANS LE CALENDRIER-->
    <xsl:template match="Session"><xsl:param name="FullDate"></xsl:param>
        {
        title: '<xsl:value-of select="./Topic"/>',
        start: '<xsl:value-of select="$FullDate"/><xsl:text> </xsl:text><xsl:value-of select="StartTime"/>',
        end: '<xsl:value-of select="$FullDate"/><xsl:text> </xsl:text><xsl:value-of select="EndTime"/>',
        allDay: false,
        url: '<xsl:value-of select="$xslt.base-url"/>me/courses/<xsl:value-of select="ancestor::Course/CourseId"/>#<xsl:value-of select="SessionId"/>'
        },</xsl:template>
    
    
</xsl:stylesheet>
