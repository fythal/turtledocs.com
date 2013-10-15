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
var margin_left = 0;

function save_to_favorite(document_id){
	$.ajax({
		type: "Post",
		data: {"document_id" : document_id},
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/documents/save_favorite",
		success: function(data){
			if(data == 'error'){
				$('#messaging').html("Document is already saved.");
					$('#messaging').show('slow', function() {
						$('#messaging').fadeOut(10000, function() {});
					});
			}else{
				$('#fav_' + document_id).html('');
				$('#recent_' + document_id).css('margin-left', 20);
				$('#favorites_container').html(data);
			}
		}
	});
}

function delete_favorite(favorite_id){
	$.ajax({
		type: "Post",
		data: {"favorite_id" : favorite_id},
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/documents/delete_favorite",
		success: function(data){
			if(data == 'error'){
				$('#messaging').html("Error deleting favorite.");
					$('#messaging').show('slow', function() {
						$('#messaging').fadeOut(10000, function() {});
					});
			}else{
				get_recent_docs();
				$('#favorites_container').html(data);
			}
		}
	});
}

function get_recent_docs(){
	$.ajax({
		type: "Post",
		//data: {"favorite_id" : favorite_id},
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		url: "/logs/get_recent_docs",
		success: function(data){
			if(data == 'error'){
				$('#messaging').html("Error deleting favorite.");
					$('#messaging').show('slow', function() {
						$('#messaging').fadeOut(10000, function() {});
					});
			}else{
				$('#recent_container').html(data);
			}
		}
	});
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

function isJson(value) {
    try {
        alert(JSON.stringify(value));
        return true;
    } catch (ex) {
        return false;
    }
}

