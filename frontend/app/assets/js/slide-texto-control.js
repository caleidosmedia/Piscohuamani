var contentLength = $(".text-opacity").length;

$(document).ready(function() {
	mostrarContenido();
});

/*controls*/
$("#slider_back").click(function(e) {
	accionEfect("back", "translate-right", $(this).parents().find(".slider-text-oficial"));
});

$("#slider_next").click(function(e) {
	accionEfect("next", "translate-left", $(this).parents().find(".slider-text-oficial"));
});

function accionEfect(control, translate, element) {
	$(element).addClass("opacity-active");
	$(element).removeClass("translate-active");
	$(element).addClass(translate);
	setTimeout(function() {
		interpolar(control)
	}, 400);
}

function mostrarContenido() {
	var current_element = obtenerContenidoActual();
	if (current_element != null) {
		$(".slider-text-oficial").html(current_element.html());
		$(".slider-text-oficial").removeClass("translate-left");
		$(".slider-text-oficial").addClass("translate-active");
		$(".slider-text-oficial").removeClass("translate-right");
		setTimeout(function() {
			$(".slider-text-oficial").removeClass("opacity-active");
		}, 300);
	};
}

function obtenerContenidoActual() {
	var current_element = null;
	$(".text-opacity").each(function(index, element) {
		var current = $(element).attr("data-current");
		if (current == 1) {
			current_element = $(element);
			return;
		};
	});
	return current_element;
}

function obtenerContenidoPorIndice(indice) {
	var content = null;
	$(".text-opacity").each(function(index, element) {
		var index = $(element).attr("data-index");
		if (index == indice) {
			content = $(element);
			return;
		};
	});
	return content;
}

function interpolar(accion) {
	var current_element = obtenerContenidoActual();
	var index = $(current_element).attr("data-index");
	if (accion == "next") {
		if (index == contentLength) { index = 0;};
		index++;	
	} else {
		if (index == 1) { index = contentLength + 1;};
		index--;
	};
	var element = obtenerContenidoPorIndice(index);
	$(current_element).attr("data-current", "0");
	$(element).attr("data-current", "1");
	mostrarContenido();
}