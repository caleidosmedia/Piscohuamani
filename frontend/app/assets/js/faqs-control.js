/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function(event){
	$(this).parent().find('#up').toggleClass("hidden");
	$(this).parent().find('#down').toggleClass("hidden");
	var target = $( event.target );
	// $(target).parent(".panel-default").find(".panel-collapse").toggleClass("in");
});

$(document).ready(function(){
	
});

var backgrounds = ["assets/img/fotos/foto-home.png", "assets/img/fotos/IMG_0212.png","assets/img/fotos/hero2.jpg", "assets/img/fotos/hero1.jpg"]

$(document).ready(function () {
	var i = Math.floor(Math.random()*4)
	$("#background").attr("style", "background-image: url("+backgrounds[i]+"); background-position-y:30%");
});