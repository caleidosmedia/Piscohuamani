/*
vALIDACIÓN INGRESO
*/
$("#formulario").submit(function(){
  var day = $("#day").val();
  var month = $("#month").val();
  var year = $("#year").val();
  var age = 18;
  var mydate = new Date();
  mydate.setFullYear(year, month-1, day);

  var currdate = new Date();
  currdate.setFullYear(currdate.getFullYear() - age);
  if ((currdate - mydate) < 0){
    $('.change-arrow').click(function() {
    $(" #up").toggleClass("hidden");
    $(" #down").toggleClass('hidden');
    });
  }
  return true;
});

/*
  SMOOTH SCROLL
*/
$(document).ready(function(){
	$("nav.smooth a").click(function(e){
		e.preventDefault();
		$("html, body").stop().animate({scrollTop: $($(this).attr("href")).offset().top}, 1000);
	});
  $("a.smooth").click(function(e){
    e.preventDefault();
    $("html, body").stop().animate({scrollTop: $($(this).attr("href")).offset().top}, 1000);
  });
  $(document).on("scroll", onScroll);
});

/*
  CARROUSEL
*/
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

/*
  SMOOTH SCROLL ACTIVE
*/
$(document).ready(function () {
  $(document).on("scroll", onScroll);
  $('a[href^="#"]').on('click', function (e) {
    e.preventDefault();
    $(document).off("scroll");
    
    $('a').each(function () {
        $(this).removeClass('active');
    })
    $(this).addClass('active');
  
    var target = this.hash,
        menu = target;
    $target = $(target);
    $('html, body').stop().animate({
        'scrollTop': $target.offset().top+2
    }, 500, 'swing', function () {
        window.location.hash = target;
        $(document).on("scroll", onScroll);
    });
  });
});
function onScroll(event){
  var scrollPos = $(document).scrollTop();
  $('.contenedor-menu a[href^="#"]').each(function () {
    var currLink = $(this);
    var refElement = $(currLink.attr("href").toString());
    if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
      $('.contenedor-menu nav a').removeClass("active");
      currLink.addClass("active");
    }
    else{
      currLink.removeClass("active");
    }
  });
}

/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function() {
    $(" #up").toggleClass("hidden");
    $(" #down").toggleClass('hidden');
});

/*
  POPUP EVENTS
*/
var $overlay = $('#overlay');
var $image = $('#overlay img');
var $caption = $('#overlay p');

$('.grid ul li a').click(function (event) {
  event.preventDefault();
  var href = $(this).attr('href');
  var captionText = $(this).children("img").attr("alt");
  $caption.text(captionText);
  $image.attr("src", href);
  $overlay.addClass("#flex").show();
});

$overlay.click(function(){ 
      $overlay.hide();
});