/*
  SMOOTH SCROLL ACTIVE
*/
$(document).ready(function () {
  $(document).on("scroll", onScroll);
  $("nav.smooth a, a.smooth").click(function(e){
    $(document).off("scroll");
    $(this).addClass("active");
    $("html, body").stop().animate({
      scrollTop: $($(this).attr("href")).offset().top - 80
    }, 1000, function () {
      $(document).on("scroll", onScroll);
    });
    e.preventDefault();
  });
  /*$('.active-hover').on('click', function (e) {
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
  });*/
});
function onScroll(event){
  var scrollPos = $(document).scrollTop();
  $('.contenedor-menu a.active-hover[href^="#"]').each(function () {
    var currLink = $(this);
    var refElement = $(currLink.attr("href").toString());
    if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
      $('.contenedor-menu nav a').removeClass("active");
      currLink.addClass("active");
      //console.log("dsada");
    }
    else{
      currLink.removeClass("active");
    }
  });
}