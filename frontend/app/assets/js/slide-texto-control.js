/*
  POPUP EVENTS
*/
var $slider = $('#slider-text-prueba');
// var $images = $('.grid-image').length;
var $next = $('#events container-sm gallery-button-right');
var $previous = $('#events container-sm gallery-button-left');

$(document).ready(function(){
	$(next).click(function (event) {
	  event.preventDefault();
	  var slideContenido = document.getElementById('text-opacity').innerHTML;
	  $(slider).append(slideContenido);
	  $index = $(this).attr('data-index');
	  setGalleryURLS($index);
	  $slider.show();
	});

	$next.click(function (event){
		event.preventDefault();
		$index = $(this).attr('data-index');
		$slider.attr("src", $(".grid-image-"+($index)).attr("href"))
	  setGalleryURLS($index);
	});

	$previous.click(function(event){
		event.preventDefault();
		$index = $(this).attr('data-image-index');
		$image.attr("src", $(".grid-image-"+($index)).attr("href"))
	  setGalleryURLS($index);
	});
});

function setGalleryURLS($index){

	 if ($index>0 &&  $index<($images+1)) {
	  $previous.attr("data-image-index", parseInt($index)-1);
		$previous.attr("href", $(".grid-image-"+($index-1)).attr("href"));
	
	  $next.attr("href", $(".grid-image-"+($index+1)).attr("href"));
	  $next.attr("data-image-index", parseInt($index)+1);
	}
}