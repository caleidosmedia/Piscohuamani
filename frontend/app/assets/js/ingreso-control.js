/*INGRESO*/
$(document).ready(function(){
	$(".btn-language.active").addClass("active-btn");
});

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

/*checkbox*/
$(".close-checkbox").click(function(){
	if($(this).is(":checked")) {
		$(".close").addClass("show");
	} else {
		$(".close").removeClass("show");
	}
});
/*Remember data*/
$(document).ready(function(){

	$("#logear").on("click", function(){
		if($(".close-checkbox").is(":checked")) {
			sessionStorage.setItem ("answer", "ultimo");
		}
	});
	sessionStorage.getItem("answer");
});