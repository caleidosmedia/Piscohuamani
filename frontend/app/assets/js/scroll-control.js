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