/*Menú Toggle*/
$(".switch").click(function() {
  $(this).toggleClass("on");
  $("#overlay-menu").toggleClass("open");
  $(".text-menu").toggleClass("hidde");
});

$("#overlay-menu a").click(function(){
	$(".switch").toggleClass("on");
	$("#overlay-menu").removeClass("open");
  $(".text-menu").toggleClass("hidde");
});
