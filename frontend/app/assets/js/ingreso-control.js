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

/*media kit*/
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

/*COOKIES*/

// var close = $(".close-checkbox");

// $(document).ready(function(){
// 	$(".box").click(function(){
// 		createCookie(close, "checkbox", 7)
// 		alert("hola");
// 	});
// });
// function createCookie(name,value,days) {
// 	if (days) {
// 		var date = new Date();
// 		date.setTime(date.getTime()+(days*24*60*60*1000));
// 		var expires = "; expires="+date.toGMTString();
// 		console.log("hola")
// 	}
// 	else var expires = "";
// 	document.cookie = name+"="+value+expires+"; path=/";
// }

// function readCookie(name) {
// 	var nameEQ = name + "=";
// 	var ca = document.cookie.split(';');
// 	for(var i=0;i < ca.length;i++) {
// 		var c = ca[i];
// 		while (c.charAt(0)==' ') c = c.substring(1,c.length);
// 		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
// 	}
// 	return null;
// }

// function eraseCookie(name) {
// 	createCookie(name,"",-1);
// }