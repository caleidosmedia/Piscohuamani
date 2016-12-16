/* IDIOMAS */
$(document).ready( function () {
	var curr_url = window.location.href;
	var lang = curr_url.substr(curr_url.indexOf("/home")-2, 2);
	var new_url = {
		"es": curr_url.replace("/"+lang+"/", "/es/"),
		"en": curr_url.replace("/"+lang+"/", "/en/")
	};

	$(".idiomaH .es").attr("href", new_url.es);
	$(".idiomaH .en").attr("href", new_url.en);
	$(".idiomaH ."+lang).addClass("activei");


$("#day, #month, #year, #country").on("change", function(){
	var this_id = $(this).attr("id");
	var this_val = $(this).val();
	sessionStorage.setItem(this_id, this_val);
});

$("#country").selectpicker("val", sessionStorage.getItem("country"));
$("#day").val(sessionStorage.getItem("day"));
$("#month").val(sessionStorage.getItem("month"));
$("#year").val(sessionStorage.getItem("year"));

});
