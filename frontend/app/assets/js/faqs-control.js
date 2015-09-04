/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function(){
	$(this).parent().find('#up').toggleClass("hidden");
	$(this).parent().find('#down').toggleClass("hidden");	
});



var backgrounds = ["assets/img/fotos/foto-home.png", "assets/img/fotos/IMG_0212.png","assets/img/fotos/IMG_0230.png", "assets/img/fotos/IMG_0279.png"]

$(document).ready(function () {
	var i = Math.floor(Math.random()*4)
	$("#background").attr("style", "background-image: url("+backgrounds[i]+"); background-position-y:30%");
});