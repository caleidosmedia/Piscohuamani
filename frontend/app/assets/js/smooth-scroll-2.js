$(document).on('click', 'a.scroll-event', function(e) {
	e.preventDefault();
    var $link = $(this);
    var anchor  = $link.attr('href');
    $('html, body').stop().animate({
        scrollTop: $(anchor).position().top
    }, 1000);
});