// Wolf Trap namespace
var WTF = {};

WTF.vars = {
	// directions for calendar (classes)
	up : "up",
	down : "down",
	left : "left",
	right : "right",
	// other
	onData : "on",
	list : "list", // haven't used these yet
	grid : "grid",
	tabs : '<div class="tabs clearfix"><div id="tabCalendar" class="tab">Calendar View<\/div><div id="tabList" class="tab">Lists View<\/div><\/div>',
	ajaxCl : 'calAjax',
	ajaxGfx : '/_res/images/cal-ajax-loader.gif'
}

WTF.closeDay = function(e){
	$('#calBig.grid div.calDayData').hide().parent().removeClass(WTF.vars.onData);
	e.stopPropagation();
};

WTF.toggleTab = function(obj){
	if (obj.id == 'tabCalendar') {
		setCookie('tablist','false',1);
		$('#tabCalendar').addClass(WTF.vars.onData);
		$('#tabList').removeClass(WTF.vars.onData);
	} else {
		setCookie('tablist','true',1)
		$('#tabCalendar').removeClass(WTF.vars.onData);
		$('#tabList').addClass(WTF.vars.onData);
	};
	$(obj).blur();
};

WTF.setupGrid = function(){
	// IE6- rules
	if ($.browser.msie == true && $.browser.version < 7) {
		$('#calBig #calDays ul.calDayShort li:first-child').addClass('first-child');
		$('#calBig #calHeader ul li:first-child').addClass('first-child');
		$('#calBig.grid #calDays li.data').hover(
			function(){
				$(this).addClass('hover')
			},
			function(){
				$(this).removeClass('hover')
			}
		)
	}
	
	// show close links for big calendar
	if ( $('#calBig.grid div.calDayData span.close').size() < 1 ) {
		$('#calBig.grid div.calDayData').prepend('<span class="close">Close</span>');
	}
	$('#calBig.grid div.calDayData span.close').show().click(WTF.closeDay);

	// if grid is not set up
	var strs = "li." + WTF.vars.up + ", li." + WTF.vars.down + ", li." + WTF.vars.left + ", li." + WTF.vars.right;
	if ( $(strs, '#calBig.grid').size() < 1 ) {
		// get current Year and Month
		var yearMonth = $('#calBig #calHeader').get(0);
			yearMonth = yearMonth.className.split(" ");
		var month = yearMonth[0]-1; 
		var year = yearMonth[1];
		var start = new Date(year, month).getDay();

		$('#calBig #calDays li.data').each(function() {
			var thisDayNum = parseInt($(this).find('div:first-child').text());
			var thisDate = new Date(year, month, thisDayNum).getDay();
			// what day of week to place right or left
			(thisDate >= 4) ? $(this).addClass(WTF.vars.left) : $(this).addClass(WTF.vars.right);
			// ((start date + day) / 7)+1 = what week is it? up or down
			var work = parseInt(((start + thisDayNum)/7)+1);
			(work > 3) ? $(this).addClass(WTF.vars.up) : $(this).addClass(WTF.vars.down);
		});
	};
	
	// show day detail
	$('#calBig li.data').click(function(event) {
		WTF.closeDay(event);
		$(this).addClass(WTF.vars.onData).find('div.calDayData').show();
	});

	// TODO: this needs to key off the "body" element
	$('#calBig.grid').parent().click(WTF.closeDay);
}

WTF.setDay = function(txtNode){
	$('#instr').remove();
	$('#cal span.on').removeClass('on');
	$(txtNode).addClass('on');
	$('#highlight').text($(txtNode).text())
};

WTF.setLoader = function(){
	$('#hpCal div.p10').empty().html('<img class="' + WTF.vars.ajaxCl + '" src="' + WTF.vars.ajaxGfx + '" alt="loading..." />');
};

WTF.setErr = function(){
	window.setTimeout(function(){
		$('#hpCal div.p10').empty().html('<p>Error loading content. Please refresh and try again.</p>');
	}, 500);
};

WTF.loadSuc = function(jaxData){
	window.setTimeout(function(){
		$('body').append('<div id="calSet" style="display:none"></div>');
		var zzz = $('#calSet').html(jaxData).find('#calForm').html();
		$('#hpCal div.p10').hide().empty().html(zzz).fadeIn();
		$('#calSet').remove();
		WTF.buildCal();
	}, 500);	
};

WTF.buildCal = function(){
	// set dynamic
	$('#cal.small .calDayShort').addClass('dyn').each(function(){
		if ($(this).parent()[0].firstChild.nodeType == 3){
			$($(this).parent()[0].firstChild).wrap('<span></span>');
		};
	});
	
	var fadeSp = 'fast';
	
	// no stuff
	if ( $('#cal.small li.data').size() == 0 ) {
		WTF.setInstruction(0);
	// todays stuff
	} else if ( $('#cal.small li.today').find('.calDayShort').size() > 0 ){
		var x = $('#cal.small li.today .calDayShort').fadeIn(fadeSp).parent().find('span').eq(0);
		WTF.setDay( x );
	// next days stuff
	} else if ( $('#cal.small li.today').children().size() == 1 ) {
		var x = $('#cal.small li.today').nextAll('li.data').eq(0).find('.calDayShort').fadeIn(fadeSp).parent().find('span').eq(0);
		WTF.setDay( x );
		WTF.setInstruction(1);
	// first day (no 'today')
	} else if ( $('#cal.small li.today').find('.calDayShort').size() == 0 ) {
		var x = $('#cal.small li.data:eq(0) .calDayShort').fadeIn(fadeSp).parent().find('span').eq(0);
		WTF.setDay( x );
	};
	
	// add click events
	$('#cal.small li.data').addClass('click').click(function(){
		$('#cal.small li.data .calDayShort:visible').fadeOut(fadeSp);
		WTF.setDay( $(this).find('div.today').find('span').eq(0) );
		$(this).find('.calDayShort').fadeIn(fadeSp);
	});
	
	// set up ajaxie stuff
	var nextPrev = $('#hpCal div.headlinetools a');
	nextPrev.eq(0).click(function(){
		WTF.setLoader();
		$.ajax({
			type : "GET",
			url : $(this).attr('rel'),
			timeout : 5000,
			global : false,
			//data : encodeURI(new Date()),
			error : function(){ WTF.setErr() },
			success: function(data){ WTF.loadSuc(data) },
			dataType:"html"
		});
		return false;
	});
	nextPrev.eq(1).click(function(){
		WTF.setLoader();
		$.ajax({
			type : "GET",
			url : $(this).attr('rel'),
			timeout : 5000,
			global : false,
			//data : encodeURI(new Date()),
			error : function(){ WTF.setErr() },
			success: function(data){ WTF.loadSuc(data) },
			dataType:"html"
		});
		return false;
	});	
}

WTF.setInstruction = function(yesNo){
	var txt = (yesNo) ? 'Select a day to the left to see the day\'s information.' : 'No information for this month. You may<br \/>click "Previous" or "Next" to see another month.';
	$('#calHighlights').append('<p id="instr">' + txt + '</p>');
};

$(document).ready(function() {
	// if big calendar exists, set it up
	if ( $('#calBig').size() > 0 ) {
		$('#tabs').replaceWith(WTF.vars.tabs);
		// start with calendar view even tho page defaults to list
		if ($('#calBig').get(0).className == "list") {
			$('#calBig').removeClass("list").addClass("grid");
		}
		WTF.setupGrid();
	};

	// set up small calendar if present
	if ($('#cal.small').size() > 0){
		WTF.buildCal();
	}

	// build tab functions
	// TODO: this var x will need to change
	var x = $('div#filter').next('div');
	$('#tabList').click(function(){
		WTF.toggleTab(this);
		$(x).attr('class','list').attr('id','calBig');
		// destroy grid bindings
		$('li.data').unbind('click').find('div.calDayData').show();
		$('#calBig.list div.calDayData span.close').hide();
		return false;
	});
	$('#tabCalendar').click(function(){
		WTF.toggleTab(this);
		$('li.data').removeClass('on').find('div.calDayData').hide();
		$(x).attr('class','grid').attr('id','calBig');
		WTF.setupGrid();
		return false;
	});
	
	(getCookie('tablist') == 'true') ? $('#tabList').trigger('click') : $('#tabCalendar').trigger('click');
});
