<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times" xmlns:xt="http://ns.inria.org/xtiger"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:site="http://oppidoc.com/oppidum/site"
    extension-element-prefixes="date" version="2.0">
    <xsl:output method="xml" media-type="text/html" omit-xml-declaration="yes" indent="no"/>
    
    <xsl:param name="xslt.rights"/>
    <xsl:param name="xslt.base-url">/</xsl:param>
    <xsl:template match="/">
    	$(document).ready(function() {
    	//* show all elements  remove preloader
    	setTimeout('$("html").removeClass("js")',0);
    	//* click the style fixed
    	$(ssw_layout_fixed).click();
    	
    	});
    	
    	
    	
    	
    	
    	$(document).ready(function() {
    	gebo_calendar.regular();
    	//* resize elements on window resize
    	var lastWindowHeight = $(window).height();
    	var lastWindowWidth = $(window).width();
    	$(window).on("debouncedresize",function() {
    	if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){
    	lastWindowHeight = $(window).height();
    	lastWindowWidth = $(window).width();
    	//* rebuild calendar
    	$('#calendar').fullCalendar('render');
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
    	events: '<xsl:value-of select="$xslt.base-url"/>eventsjs',
    	eventColor: '#bcdeee'
    	})
    	}
    	};
    </xsl:template>
    
</xsl:stylesheet>
