$(document).ready(function(){
	if ($(".img-right").attr("src") != null) { 
		$(".texto-izquierdo").addClass("col-md-8 ph-0")
	} else {
		$(".texto-izquierdo").removeClass("col-md-8 ph-0")
	}
});