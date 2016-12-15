/*
  SMOOTH SCROLL ACTIVE
*/
var flag = true;

$(document).ready(function () {
  $(document).on("scroll", onScroll);
  $('.active-hover').on('click', function (e) {
    e.preventDefault();
    flag = false;
    
    $('a').removeClass('active');

    $(this).addClass('active');
  
    var target = this.hash,
        menu = target;
    $target = $(target);
    $('html, body').stop().animate({
        'scrollTop': $target.offset().top+2
    }, 500, function () {
        //window.location.hash = target;
        flag = true;
    });
  });
});
function onScroll(event){
  var scrollPos = $(document).scrollTop();
  if (flag) {
    $('.contenedor-menu a.active-hover[href^="#"]').each(function () {
      var currLink = $(this);
      var refElement = $(currLink.attr("href").toString());
      if (
        refElement.position().top <= scrollPos //&&
        //refElement.position().top + refElement.height() > scrollPos
        ) {
        $('.contenedor-menu nav a').removeClass("active");
        currLink.addClass("active");
      }
      else{
        currLink.removeClass("active");
      }
    });
  }
}