function slide(e, t, n, r, i) {
    $(e).click(function(e) {
        accionEfect(t, n, r, i)
    })
}

function accionEfect(e, t, n, r) {
    $(n).addClass("opacity-active");
    $(n).removeClass("translate-active");
    $(n).addClass(t);
    setTimeout(function() {
        interpolar(e, n, r)
    }, 400)
}

function mostrarContenido(e, t) {
    var n = obtenerContenidoActual(t);
    if (n != null) {
        $(e).html(n.html());
        $(e).removeClass("translate-left");
        $(e).addClass("translate-active");
        $(e).removeClass("translate-right");
        setTimeout(function() {
            $(e).removeClass("opacity-active")
        }, 300)
    }
    set_image_to_overlay()
}

function obtenerContenidoActual(e) {
    var t = null;
    $(e).each(function(e, n) {
        var r = $(n).attr("data-current");
        if (r == 1) {
            t = $(n);
            return
        }
    });
    return t
}

function obtenerContenidoPorIndice(e, t) {
    var n = null;
    $(t).each(function(t, r) {
        var t = $(r).attr("data-index");
        if (t == e) {
            n = $(r);
            return
        }
    });
    return n
}

function interpolar(e, t, n) {
    var r = $(n).length;
    var i = obtenerContenidoActual(n);
    var s = $(i).attr("data-index");
    if (e == "next") {
        if (s == r) {
            s = 0
        }
        s++
    } else {
        if (s == 1) {
            s = r + 1
        }
        s--
    }
    var o = obtenerContenidoPorIndice(s, n);
    $(i).attr("data-current", "0");
    $(o).attr("data-current", "1");
    mostrarContenido(t, n)
}

function setCurrentSlide(e, t) {
    var n = $(e).filter(function(e, n) {
        var r = $(n).attr("data-slide-id");
        if (t == r) return $(n)
    });
    n.attr("data-current", "1")
}
$(document).ready(function() {
    $(".text-opacity1:first-child, .text-opacity2:first-child").attr("data-current", "1");
    $(".ronda-1 li").each(function(e, t) {
        order = $(this).index();
        $(this).find("a").attr("data-image-index", order + 1);
        $(this).find("a").addClass("grid-image-" + (order + 1))
    });
    var e = window.location.href.indexOf("/events") > 0;
    if (e) {
        var t = localStorage.getItem("slide_id");
        setCurrentSlide(".text-opacity", t);
        setCurrentSlide(".ronda-1", t)
    } else {
        if ($('.events-slide[data-current="1"]').size() == 0) {
            $(".text-opacity:first-child").attr("data-current", "1")
        }
    }
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
    slide(".gallery-button-left", "back", "translate-right", "#container-ronda", ".ronda-1")
});
var set_image_to_overlay = function() {
    $(".grid-image").each(function() {
        var e;
        $(this).click(function() {
            e = $(this).attr("href");
            $(".img-overlay").attr("src", e);
            $("#overlay img").addClass("flex");
            $index = $(this).attr("data-image-index");
            setGalleryURLS($index);
            $overlay.show();
            return false
        })
    })
}
