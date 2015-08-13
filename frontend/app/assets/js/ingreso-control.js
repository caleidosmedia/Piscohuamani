/*INGRESO*/
$(".btn-language").click(function() {
	$(".btn-language").removeClass("active-btn");
  $(this).toggleClass("active-btn");
});

/*BLOG MENU2*/
$(".btn-select").click(function(event) {
	event.preventDefault()
  $(".btn-select").removeClass("active-select");
  $(this).toggleClass("active-select");
});

/*CHECKBOX*/
$(".box").click(function(){
	$(".close").toggleClass("show");
});
