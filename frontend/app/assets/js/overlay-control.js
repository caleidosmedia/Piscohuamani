/*
  POPUP EVENTS
*/
var $overlay = $('#overlay');
var $image = $('#overlay img');
var $caption = $('#overlay p');

$(document).ready(function(){
	$('.grid ul li a').click(function (event) {
	  event.preventDefault();
	  var href = $(this).attr('href');
	  var captionText = $(this).children("img").attr("alt");
	  $caption.text(captionText);
	  $image.attr("src", href);
	  $overlay.addClass("flex");
	  $overlay.show();
	});
	$overlay.click(function(){ 
	   $overlay.hide();
	   $overlay.removeClass("flex");
	});
});