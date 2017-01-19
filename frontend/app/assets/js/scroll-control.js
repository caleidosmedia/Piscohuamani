/*
  SMOOTH SCROLL
*/
$(document).ready(function(){
	$("nav.smooth a, a.smooth, a.smooth").click(function(e){
		$("html, body").stop().animate({
			scrollTop: $($(this).attr("href")).offset().top - 78
		}, 1000, function () {
			flag = true;
		});
		e.preventDefault();
	});

	$("#overlay-menu li a").click(function(e){
		$("html, body").stop().animate({
			scrollTop: $($(this).attr("href")).offset().top - 70
		}, 1000);
		e.preventDefault();
	});
	/*$("a.smooth").click(function(e){
		e.preventDefault();
		$("html, body").stop().animate({scrollTop: $($(this).attr("href")).offset().top - 80}, 1000);
	});*/
});