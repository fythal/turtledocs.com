// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var intervalId = 0;

function tester(){
	console.log("i am being tested");
}

function slideSwitch() {
	var $active = $('#slideshow div.active');
	if($active.length === 0){
		$active = $('#slideshow div:last');
	}

	var $next =  $active.next('.slide').length ? $active.next()
	: $('#slideshow div:first');
	$active.addClass('last-active');
	var previous_index = $active.index('.slide');
	$active.hide('slow');
	$next.css({opacity: 0.0})
	.addClass('active')
	.show('slow')
	.animate({opacity: 1.0}, 1000, function() {
		$active.removeClass('active last-active');
	});
	var index = $next.index('.slide');
	//console.log('remove check from ' + previous_index);
	$('#' + previous_index).attr('checked', false);
	$('#' + index).attr('checked', true);
}

$(function() {
	$('#slideshow div.active').show();
	intervalId = setInterval( "slideSwitch()", 5000 );
	
});

function isJson(value) {
    try {
        alert(JSON.stringify(value));
        return true;
    } catch (ex) {
        return false;
    }
}

function tester(){
	alert("this is a test")
}