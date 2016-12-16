/* IDIOMAS */
$(document).ready( function () {
	var curr_url = window.location.href;
	var lang = curr_path.substr(curr_path.indexOf("/home")-2, 2);
	var new_url = {
		"es": curr_path.replace(lang, "es"),
		"en": curr_path.replace(lang, "en")
	}

	$(".idiomaH .es").attr("href", new_url.es);
	$(".idiomaH .en").attr("href", new_url.en);
});