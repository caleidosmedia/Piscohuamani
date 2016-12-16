/* IDIOMAS */
$(document).ready( function () {
	var curr_path = window.location.pathname;
	var lang = curr_path.substr(curr_path.indexOf("/home")-2, 2);
	var new_url = {
		"es": curr_path.replace(lang, "es"),
		"en": curr_path.replace(lang, "en")
	}

	$(".idiomaH .es").text(new_url.es);
	$(".idiomaH .en").text(new_url.en);
});