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
});