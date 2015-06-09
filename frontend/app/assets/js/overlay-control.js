/*
  POPUP EVENTS
*/
var $overlay = $('#overlay');
var $image = $('#overlay img');
var $next = $('#overlay .next-overlay');
var $previous = $('#overlay .previous-overlay');


$(document).ready(function(){
	$('.grid ul li a').click(function (event) {
	  event.preventDefault();
	  var href = $(this).attr('href');
	  $image.attr("src", href);
	  $overlay.addClass("flex");
	  $overlay.show();
	});
	$overlay.click(function(){ 
	   $overlay.hide();
	   $overlay.removeClass("flex");
	});
	
	$next.click(function (event){
		event.preventDefault();
		var href = $(this).attr('href');
	  $image.attr("src", href[1]);
	  $overlay.show();
	});
	$previous.click(function(event){
		event.preventDefault();
		var href = $(this).attr('href');
	  var captionText = $(this).children("img").attr("alt");
	});
});