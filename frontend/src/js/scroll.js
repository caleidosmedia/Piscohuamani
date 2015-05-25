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

 $('.main-gallery button.previous').on( 'click', function() {
   $('.second-gallery').flickity( 'previous', true );
 });

 $('.main-gallery button.next').on( 'click', function() {
   $('.second-gallery').flickity( 'next', true );
 });
 
});

// asNavFor can be set a selector string
asNavFor: '.gallery-main'
// or an element
asNavFor: $('.gallery-main')[0]
asNavFor: document.querySelector('.gallery-main')

// 1st gallery, main
$('.gallery-main').flickity();
// 2nd gallery, navigation
$('.gallery-nav').flickity({
  asNavFor: '.gallery-main',
  contain: true,
  pageDots: false
});
