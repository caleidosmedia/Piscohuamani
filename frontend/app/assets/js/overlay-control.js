/*
  POPUP EVENTS
*/
var $overlay = $('#overlay');
var $image = $('#overlay .img-overlay');
var $next = $('#overlay .next-overlay');
var $previous = $('#overlay .previous-overlay');
var $images = $('.grid-image').length;
var $close = $('.close');

var ready = function(){

		$close.click(function(){
			$overlay.hide();
			$overlay.removeClass("flex");
		});

		$next.click(function(event){
			event.preventDefault();
			$index = $(this).attr('data-image-index');
			$image.attr("src", $("#container-ronda .grid-image-"+($index)).attr("href"))
		  setGalleryURLS($index);
		});

		$previous.click(function(event){
			event.preventDefault();
			$index = $(this).attr('data-image-index');
			$image.attr("src", $("#container-ronda .grid-image-"+($index)).attr("href"))
		  setGalleryURLS($index);
		});
	// }
};

function setGalleryURLS($index){

	 if ($index>0 &&  $index<($images+1)) {
	  $previous.attr("data-image-index", parseInt($index)-1);
		$previous.attr("href", $("#container-ronda .grid-image-"+($index-1)).attr("href"));
	
	  $next.attr("href", $("#container-ronda .grid-image-"+($index+1)).attr("href"));
	  $next.attr("data-image-index", parseInt($index)+1);
	}
}


$(document).ready(ready);
$(document).on('page:load', ready);