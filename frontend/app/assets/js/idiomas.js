/* IDIOMAS */
$(document).ready( function () {
	var curr_url = window.location.href;
	var lang = (curr_url.indexOf("/en/") !== -1) ? "en" : "es";
	var new_url = {
		"es": curr_url.replace("/"+lang+"/", "/es/"),
		"en": curr_url.replace("/"+lang+"/", "/en/")
	};

	$(".idiomaH .es").attr("href", new_url.es);
	$(".idiomaH .en").attr("href", new_url.en);
	$(".idiomaH ."+lang).addClass("activei");
});
