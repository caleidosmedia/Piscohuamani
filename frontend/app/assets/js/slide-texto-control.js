$(document).ready(function() {
	$("text-opacity1:first-child, .text-opacity2:first-child").attr("data-current","1");
	/*EVENTS*/
	if($('.events-slide[data-current="1"]').size() == 0){
		$(".text-opacity:first-child").attr("data-current","1");
	}
	$(".ronda-1 li").each(function(index, element){ 
		order= $(this).index();  
		$(this).find("a").attr("data-image-index", order + 1);
		$(this).find("a").addClass("grid-image-" + (order +1));
	});
	/**/

	mostrarContenido("#slider-text-experience", ".text-opacity");
	slide("#slider_next_experience", "next", "translate-left", "#slider-text-experience", ".text-opacity");
	slide("#slider_back_experience", "back", "translate-right", "#slider-text-experience", ".text-opacity");
	mostrarContenido("#slider-text-goods", ".text-opacity1");
	slide("#slider_next_goods", "next", "translate-left", "#slider-text-goods", ".text-opacity1");
	slide("#slider_back_goods", "back", "translate-right", "#slider-text-goods", ".text-opacity1");
	mostrarContenido("#slider-text-make", ".text-opacity2");
	slide("#slider_next_make", "next", "translate-left", "#slider-text-make", ".text-opacity2");
	slide("#slider_back_make", "back", "translate-right", "#slider-text-make", ".text-opacity2");
	mostrarContenido("#container-ronda", ".ronda-1");
	slide(".gallery-button-right", "next", "translate-left", "#container-ronda", ".ronda-1");
	slide(".gallery-button-left", "back", "translate-right", "#container-ronda", ".ronda-1");
});


function slide(sender, action, classEffect, container, contentClass) {
	$(sender).click(function(e) {
		accionEfect(action, classEffect, container, contentClass);
	});
}

function accionEfect(control, translate, container, contentClass) {
	$(container).addClass("opacity-active");
	$(container).removeClass("translate-active");
	$(container).addClass(translate);
	setTimeout(function() {
		interpolar(control, container, contentClass)
	}, 400);
}

function mostrarContenido(container, contentClass) {
	var current_element = obtenerContenidoActual(contentClass);
	if (current_element != null) {
		$(container).html(current_element.html());
		$(container).removeClass("translate-left");
		$(container).addClass("translate-active");
		$(container).removeClass("translate-right");
		setTimeout(function() {
			$(container).removeClass("opacity-active");
		}, 300);
	};
	set_image_to_overlay();
}

function obtenerContenidoActual(contentClass) {
	var current_element = null;
	console.log(contentClass.length);
	$(contentClass).each(function(index, element) {
		var current = $(element).attr("data-current");
		if (current == 1) {
			current_element = $(element);
			return;
		};
	});
	return current_element;
}

function obtenerContenidoPorIndice(indice, contentClass) {
	var content = null;
	$(contentClass).each(function(index, element) {
		var index = $(element).attr("data-index");
		if (index == indice) {
			content = $(element);
			return;
		};
	});
	return content;
}

function interpolar(accion, container, contentClass) {
	var contentLength = $(contentClass).length;
	var current_element = obtenerContenidoActual(contentClass);
	var index = $(current_element).attr("data-index");
	if (accion == "next") {
		if (index == contentLength) { index = 0;};
		index++;	
	} else {
		if (index == 1) { index = contentLength + 1;};
		index--;
	};
	var element = obtenerContenidoPorIndice(index, contentClass);
	$(current_element).attr("data-current", "0");
	$(element).attr("data-current", "1");
	mostrarContenido(container, contentClass);
}


	var set_image_to_overlay = function (){
		$('.grid-image').each(function(){
			var href;
			$(this).click(function() {
					// e.preventDefault();
					href = $(this).attr('href');
					$(".img-overlay").attr("src", href);
					$('#overlay img').addClass("flex");
					$index = $(this).attr('data-image-index');
					setGalleryURLS($index);
					$overlay.show();
					return false;
				});
		});
	}
		