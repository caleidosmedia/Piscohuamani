$(document).ready(function() {
    var e = $("#the-goods  .gallery-child");
    var t = $("#the-goods .gallery");
    t.flickity({
        cellAlign: "center",
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    e.flickity({
        cellAlign: "left",
        asNavFor: "#the-goods .gallery",
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    $("#the-goods .gallery-button-left").on("click", function(n) {
        n.preventDefault();
        $("#the-goods .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            t.flickity("previous")
        }, 500);
        $("#the-goods .gallery .gallery-cell.is-selected").fadeOut();
        e.flickity("previous")
    });
    $("#the-goods .gallery-button-right").on("click", function(n) {
        n.preventDefault();
        $("#the-goods .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            t.flickity("next")
        }, 500);
        $("#the-goods .gallery .gallery-cell.is-selected").fadeOut();
        e.flickity("next")
    });
    var n = $("#make-drink .gallery-child");
    var r = $("#make-drink .gallery");
    r.flickity({
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    n.flickity({
        asNavFor: "#make-drink .gallery",
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    $("#make-drink .gallery-button-left").on("click", function(e) {
        e.preventDefault();
        $("#make-drink .gallery .gallery-cell").fadeIn();
        $("#make-drink .gallery-child .gallery-cell").removeClass("active-hidden");
        setTimeout(function() {
            r.flickity("previous")
        }, 500);
        $("#make-drink .gallery .gallery-cell.is-selected").fadeOut();
        $("#make-drink .gallery-child .gallery-cell.is-selected").addClass("active-hidden");
        n.flickity("previous")
    });
    $("#make-drink .gallery-button-right").on("click", function(e) {
        e.preventDefault();
        $("#make-drink .gallery .gallery-cell").fadeIn();
        $("#make-drink .gallery-child .gallery-cell").removeClass("active-hidden");
        setTimeout(function() {
            r.flickity("next")
        }, 500);
        $("#make-drink .gallery .gallery-cell.is-selected").fadeOut();
        $("#make-drink .gallery-child .gallery-cell.is-selected").addClass("active-hidden");
        n.flickity("next")
    });
    var i = $("#events .gallery-child");
    var s = $("#events .gallery");
    s.flickity({
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    i.flickity({
        asNavFor: "#events .gallery",
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        draggable: false,
        pageDots: false,
        friction: .4,
        wrapAround: true
    });
    $("#events .gallery-button-left").on("click", function(e) {
        e.preventDefault();
        $("#events .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            s.flickity("previous")
        }, 200);
        $("#events .gallery .gallery-cell.is-selected").fadeOut();
        i.flickity("previous")
    });
    $("#events .gallery-button-right").on("click", function(e) {
        e.preventDefault();
        $("#events .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            s.flickity("next")
        }, 200);
        $("#events .gallery .gallery-cell.is-selected").fadeOut();
        i.flickity("next")
    });
    var o = $("#slider-events .gallery-child");
    var u = $("#slider-events .gallery");
    u.flickity({
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        pageDots: false,
        draggable: false,
        friction: .4,
        wrapAround: true
    });
    o.flickity({
        asNavFor: "#slider-events .gallery",
        cellAlign: "left",
        contain: true,
        prevNextButtons: false,
        draggable: false,
        pageDots: false,
        friction: .4,
        wrapAround: true
    });
    $("#slider-events .gallery-button-left").on("click", function(e) {
        e.preventDefault();
        $("#slider-events .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            u.flickity("previous")
        }, 200);
        $("#slider-events .gallery .gallery-cell.is-selected").fadeOut();
        o.flickity("previous");
        console.log("anterior");
    });
    $("#slider-events .gallery-button-right").on("click", function(e) {
        e.preventDefault();
        $("#slider-events .gallery .gallery-cell").fadeIn();
        setTimeout(function() {
            u.flickity("next")
        }, 200);
        $("#slider-events .gallery .gallery-cell.is-selected").fadeOut();
        o.flickity("next");
        console.log("siguiente");
    })
})
