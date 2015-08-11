var contentLength = $(".text-opacity").length; 

$(document).ready(function() {
	mostrarContenido();
});


$("#slider_back").click(function(e) {
	$("#slider-text-oficial").addClass("opacity-active");
	setTimeout(function() {
		interpolar("back")
	}, 300);
});

$("#slider_next").click(function(e) {
	$("#slider-text-oficial").addClass("opacity-active");
	setTimeout(function() {
		interpolar("next")
	}, 300);
});

function mostrarContenido() {
	var current_element = obtenerContenidoActual();
	if (current_element != null) {
		$("#slider-text-oficial").html(current_element.html());
		setTimeout(function() {
			$("#slider-text-oficial").removeClass("opacity-active");
		}, 200);
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