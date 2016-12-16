$(document).ready(function(){

	// Gallery Goods Control
	var $goodsGallery = $('#the-goods  .gallery-child');
	var $goodsGalleryNav = $('#the-goods .gallery');

	$goodsGalleryNav.flickity({
		cellAlign: 'center',
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$goodsGallery.flickity({
		cellAlign: 'left',
		asNavFor: '#the-goods .gallery',
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$('#the-goods .gallery-button-left').on( 'click', function(e) {
		e.preventDefault();
		$('#the-goods .gallery .gallery-cell').fadeIn();
		setTimeout(function(){
	  	$goodsGalleryNav.flickity('previous');}, 500);
		$('#the-goods .gallery .gallery-cell.is-selected').fadeOut();
		$goodsGallery.flickity('previous');
	});
	$('#the-goods .gallery-button-right').on( 'click', function(e) {
		e.preventDefault();
		$('#the-goods .gallery .gallery-cell').fadeIn();
	  setTimeout(function(){
	  	$goodsGalleryNav.flickity('next');}, 500);
	  $('#the-goods .gallery .gallery-cell.is-selected').fadeOut();
		$goodsGallery.flickity('next');
	});

	// Gallery Make Drink Control
	var $makeDrinkGallery = $('#make-drink .gallery-child');
	var $makeDrinkGalleryNav = $('#make-drink .gallery');

	$makeDrinkGalleryNav.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$makeDrinkGallery.flickity({
		asNavFor: '#make-drink .gallery',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$('#make-drink .gallery-button-left').on( 'click', function(e) {
		e.preventDefault();
		$('#make-drink .gallery .gallery-cell').fadeIn();
		$('#make-drink .gallery-child .gallery-cell').removeClass("active-hidden");
		setTimeout(function(){
	  	$makeDrinkGalleryNav.flickity('previous');}, 500);
		$('#make-drink .gallery .gallery-cell.is-selected').fadeOut();
		$('#make-drink .gallery-child .gallery-cell.is-selected').addClass("active-hidden");
	  $makeDrinkGallery.flickity('previous');
	});
	$('#make-drink .gallery-button-right').on( 'click', function(e) {
		e.preventDefault();
		$('#make-drink .gallery .gallery-cell').fadeIn();
		$('#make-drink .gallery-child .gallery-cell').removeClass("active-hidden");
		setTimeout(function(){
	  	$makeDrinkGalleryNav.flickity('next');}, 500);
		$('#make-drink .gallery .gallery-cell.is-selected').fadeOut();
		$('#make-drink .gallery-child .gallery-cell.is-selected').addClass("active-hidden");
	  $makeDrinkGallery.flickity('next');
	});

	// Gallery Events Control
	var $eventsGallery = $('#events .gallery-child');
	var $eventsGalleryNav = $('#events .gallery');

	$eventsGalleryNav.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$eventsGallery.flickity({
		asNavFor: '#events .gallery',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		draggable: false,
		pageDots: false,
		friction: 0.4,
		wrapAround: true
	});

	$('#events .gallery-button-left').on( 'click', function(e) {
		e.preventDefault();
		$('#events .gallery .gallery-cell').fadeIn();
		setTimeout(function(){
	  	$eventsGalleryNav.flickity('previous');}, 200);
		$('#events .gallery .gallery-cell.is-selected').fadeOut();
	  $eventsGallery.flickity('previous');
	});
	$('#events .gallery-button-right').on( 'click', function(e) {
		e.preventDefault();
		$('#events .gallery .gallery-cell').fadeIn();
		setTimeout(function(){
	  	$eventsGalleryNav.flickity('next');}, 200);
		$('#events .gallery .gallery-cell.is-selected').fadeOut();
	  $eventsGallery.flickity('next');
	});

	// Slider-Events Control
	var $sliderEventsGallery = $('#slider-events .gallery-child');
	var $sliderEventsGalleryNav = $('#slider-events .gallery');

	$sliderEventsGalleryNav.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		friction: 0.4,
		wrapAround: true
	});

	$sliderEventsGallery.flickity({
		asNavFor: '#slider-events .gallery',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		draggable: false,
		pageDots: false,
		friction: 0.4,
		wrapAround: true
	});

	$('#slider-events .gallery-button-left img').on( 'click', function(e) {
		e.preventDefault();
		$('#slider-events .gallery .gallery-cell').fadeIn();
		setTimeout(function(){
	  	$sliderEventsGalleryNav.flickity('previous');}, 200);
		$('#slider-events .gallery .gallery-cell.is-selected').fadeOut();
	  $sliderEventsGallery.flickity('previous');
	});
	$('#slider-events .gallery-button-right img').on( 'click', function(e) {
		e.preventDefault();
		$('#slider-events .gallery .gallery-cell').fadeIn();
		setTimeout(function(){
	  	$sliderEventsGalleryNav.flickity('next');}, 200);
		$('#slider-events .gallery .gallery-cell.is-selected').fadeOut();
	  $sliderEventsGallery.flickity('next');
	});
});