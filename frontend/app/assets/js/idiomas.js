/* IDIOMAS */
$(document).ready( function () {
	var curr_url = window.location.href;
	var lang = (curr_url.indexOf("/en/") !== -1) ? "en" : "es";
	var new_url = {
		"es": curr_url.replace("/"+lang+"/", "/es/"),
		"en": curr_url.replace("/"+lang+"/", "/en/")
	};

  $(".idiomaH select").val(lang);

  $(".idiomaH select").on("change", function () {
      var this_val = $(this).val();

      location.href = new_url[this_val];
  });



	/*$(".idiomaH .es").attr("href", new_url.es);
	$(".idiomaH .en").attr("href", new_url.en);
	$(".idiomaH ."+lang).addClass("activei");*/
});
