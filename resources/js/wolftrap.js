// configuration variables
var animspeed = 500; // reuseable value for animation times. in milliseconds.
var txt_expand = "Expand";
var txt_collapse = "Collapse";
var txt_mailLink = "mailto:";
	txt_mailLink+= "?subject=Wolf Trap Show! Let's Go!";
	txt_mailLink+= "&body=" + location.href;
// reuseable functions
function getCookie( name ) {
	var start = document.cookie.indexOf( name + "=" );
	var len = start + name.length + 1;
	if ( ( !start ) && ( name != document.cookie.substring( 0, name.length ) ) ) {
		return null;
	}
	if ( start == -1 ) return null;
	var end = document.cookie.indexOf( ';', len );
	if ( end == -1 ) end = document.cookie.length;
	return unescape( document.cookie.substring( len, end ) );
}

function setCookie( name, value, expires, path, domain, secure ) {
	var today = new Date();
	today.setTime( today.getTime() );
	if ( expires ) {
		expires = expires * 1000 * 60 * 60 * 24;
	}
	var expires_date = new Date( today.getTime() + (expires) );
	document.cookie = name+'='+escape( value ) +
		( ( expires ) ? ';expires='+expires_date.toGMTString() : '' ) + //expires.toGMTString()
		( ( path ) ? ';path=' + path : '' ) +
		( ( domain ) ? ';domain=' + domain : '' ) +
		( ( secure ) ? ';secure' : '' );
}
// jQuery code
$(document).ready(function(){
	// add a class of "last" to the last LI in every UL
	$('ul').each(function(){
		$('li:last',this).addClass('last');
	});
	// adjust icons in navigation lists
	$('#leftnav ul.nav li li li.active').parents('li').find('a:first').addClass('open');
	// replace HR tags with a DIV using the class "hr"
	$('hr').wrap('<div class="hr"><\/div>');
	// mild adjustment for two-column bullet lists
	$('.two-col li:odd').css('float','right');
	$('.two-col li:even').css('clear','left');
	// right rail tabbed module
	$('div#radiovideo div.tabs a').click(function(){
		var switchto = $(this).attr('class');
		$(this).parents('#radiovideo').removeClass('radio').removeClass('video').addClass(switchto);
		this.blur();
		return false;
	});
	// search page column switcher
	$('#col1 .insert .p10').prepend('<div class="switcher"><a class="collapse" href="#">'+txt_collapse+'<\/a><\/div>');
	$('#col2 .insert .p10').prepend('<div class="switcher"><a class="expand" href="#">'+txt_expand+'<\/a><\/div>');
	$('.siteSearch').css({
	});
    
	
	
	$('#col1 .switcher a').click(function(){
		if(this.className=='collapse'){
			$('#col1').removeClass('grid-ad').addClass('grid-ab');
			$('.grid-ab').css({
				margin:'10px 0 10px 10px',
				width:'315px'
			});
			$('#col2').removeClass('grid-ef').addClass('grid-cf');
			$(this).removeClass('collapse').addClass('expand').text(txt_expand);
			$('#col2 .switcher a').removeClass('expand').addClass('collapse').text(txt_collapse);
			setCookie('searchcol','col2',1,'/'); // set col2 as open
		}else{
			$('#col1').removeClass('grid-ab').addClass('grid-ad');
			$('.grid-ad').attr('style','');
			$('#col2').removeClass('grid-cf').addClass('grid-ef');
			$(this).removeClass('expand').addClass('collapse').text(txt_collapse);
			$('#col2 .switcher a').removeClass('collapse').addClass('expand').text(txt_expand);
			setCookie('searchcol','col1',1,'/'); //set col1 as open
		}
		this.blur();
		return false;
	});
	$('#col2 .switcher a').click(function(){
		if(this.className=='expand'){
			$('#col1').removeClass('grid-ad').addClass('grid-ab');
			$('.grid-ab').css({
				margin:'10px 0 10px 10px',
				width:'315px'
			});
			$('#col2').removeClass('grid-ef').addClass('grid-cf');
			$(this).removeClass('expand').addClass('collapse').text(txt_collapse);
			$('#col1 .switcher a').removeClass('collapse').addClass('expand').text(txt_expand);
			setCookie('searchcol','col2',1,'/'); // set col2 as open
		}else{
			$('#col1').removeClass('grid-ab').addClass('grid-ad');
			$('.grid-ad').attr('style','');
			$('#col2').removeClass('grid-cf').addClass('grid-ef');
			$(this).removeClass('collapse').addClass('expand').text(txt_expand);
			$('#col1 .switcher a').removeClass('expand').addClass('collapse').text(txt_collapse);
			setCookie('searchcol','col1',1,'/'); // set col1 as open
		}
		this.blur();
		return false;
	});
	if($('#col1').get(0) && getCookie('searchcol')=='col2'){
		$('#col1').removeClass('grid-ad').addClass('grid-ab');
		$('.grid-ab').css({
			margin:'10px 0 10px 10px',
			width:'315px'
		});
		$('#col2').removeClass('grid-ef').addClass('grid-cf');
		$('#col1 .switcher a').removeClass('collapse').addClass('expand').text(txt_expand);
		$('#col2 .switcher a').removeClass('expand').addClass('collapse').text(txt_collapse);
	}
	$("li a.emailLink").attr("href", txt_mailLink);
});