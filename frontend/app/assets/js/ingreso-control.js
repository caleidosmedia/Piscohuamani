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

$(document).ready(function(){
	$("#day, #month, #year, #country").on("change", function(){
		var this_id = $(this).attr("id");
		var this_val = $(this).val();
		sessionStorage.setItem(this_id, this_val);
	});

	$(window).load( function () {
		$("#country").selectpicker("val", sessionStorage.country);
		$("#day").val(sessionStorage.day);
		$("#month").val(sessionStorage.month);
		$("#year").val(sessionStorage.year);
		validarEdad();
	});
});
