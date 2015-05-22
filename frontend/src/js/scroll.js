/*$("a.smooth").live("click", function(e) {
	e.preventDefault();
    var $link = $(this);
    var anchor  = $link.attr('href');
    $('html, body').stop().animate({
        scrollTop: $(anchor).offset().top
    }, 1000);
});*/
$(document).ready(function(){
	$("nav.smooth a").click(function(e){
		e.preventDefault();
		$("html, body").stop().animate({scrollTop: $($(this).attr("href")).offset().top}, 1000);
	});
});

/*Carrousel*/

// jQuery
$gallery.flickity( 'next', isWrapped )
// vanilla JS
flkty.next( isWrapped )

$(document).ready(function() {
  var $gallery = $('.gallery').flickity();

  // previous
  $('.button--previous').on('click', function() {
    $gallery.flickity('previous');
  });
  // previous wrapped
  $('.button--previous-wrapped').on('click', function() {
    $gallery.flickity('previous', true);
  });
});