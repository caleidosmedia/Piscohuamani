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

$(document).ready( function() {
  // vanilla JS
  var $gallery = $('.main-gallery .gallery').flickity();
  $('.main-gallery').flickity({
      // options
      cellAlign: 'left',
      contain: true
    });

   var $gallery2 = $('.second-gallery .gallery').flickity();
  $('.second-gallery').flickity({
      // options
      cellAlign: 'left',
      contain: true
    });

  $('.button--previous').on( 'click', function() {

    $('.main-gallery').flickity('previous');
  });
  // previous wrapped
  $('.button--previous-wrapped').on( 'click', function() {
    $('.main-gallery').flickity( 'previous', true );
  });

// GO TO PREVIOUS
  // $('.main-gallery button.previous').on( 'click', function() {

  //   $('.second-gallery').flickity('previous');
  // });
  // previous wrapped
 $('.main-gallery button.previous').on( 'click', function() {
   $('.second-gallery').flickity( 'previous', true );
 });

// GO TO NEXT
  //  $('.main-gallery button.next').on( 'click', function() {

  //   $('.second-gallery').flickity('next');
  // });
  // previous wrapped
 $('.main-gallery button.next').on( 'click', function() {
   $('.second-gallery').flickity( 'next', true );
 });
  
});