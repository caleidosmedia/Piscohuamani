/*INGRESO*/
$(document).ready(function(){
	$(".btn-language.active").addClass("active-btn");
		/*CHECKBOX*/
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

/*remenber data*/
$(".btn-select:first-child").addClass("active-select");

	$(document).ready(function(){
		var inputDay= document.getElementById("day");
		var inputMonth= document.getElementById("month");
		var inputYear= document.getElementById("year");
		var inputCountry= document.getElementById("country");
		$(".close-checkbox").click(function(){
			if ($(this).is(":checked")) {
				$(".close").addClass("show");
				localStorage.setItem("day", inputDay.value);
				localStorage.setItem("month", inputMonth.value);
				localStorage.setItem("year", inputYear.value);
				localStorage.setItem("country", inputCountry.value);
			}else {
				$(".close").removeClass("show");
			}
		});
		var storedDay = localStorage.getItem("day");
		var storedMonth = localStorage.getItem("month");
		var storedYear = localStorage.getItem("year");
		var storedCountry = localStorage.getItem("country");
		$("#day").val(storedDay);
		$("#month").val(storedMonth);
		$("#year").val(storedYear);
		$("#country").val(storedCountry);

		// var logeado = $(".enter").click();
		// localStorage.logeado = $(".enter").click();
	});