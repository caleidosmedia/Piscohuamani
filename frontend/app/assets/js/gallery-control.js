$(document).ready(function(){

	// Gallery Goods Control
	var $goodsGallery = $('#the-goods  .gallery-child');
	var $goodsGalleryNav = $('#the-goods .gallery');

	$goodsGalleryNav.flickity({
		//cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		wrapAround: true
	});

	$goodsGallery.flickity({
		//cellAlign: 'left',
		asNavFor: '#the-goods .gallery',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		wrapAround: true
	});

	$('#the-goods .gallery-button-left img').on( 'click', function(e) {
		e.preventDefault();
		setTimeout(function(){
	  	$goodsGalleryNav.flickity('previous');}, 500);
		$goodsGallery.flickity('previous');
	});
	$('#the-goods .gallery-button-right img').on( 'click', function(e) {
		e.preventDefault();
	  setTimeout(function(){
	  	$goodsGalleryNav.flickity('next');}, 500);
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
		wrapAround: true
	});

	$makeDrinkGallery.flickity({
		asNavFor: '#make-drink .gallery',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		draggable: false,
		wrapAround: true
	});

	$('#make-drink .gallery-button-left img').on( 'click', function(e) {
		e.preventDefault();
		setTimeout(function(){
	  	$makeDrinkGalleryNav.flickity('previous');}, 500);
	  $makeDrinkGallery.flickity('previous');
	});
	$('#make-drink .gallery-button-right img').on( 'click', function(e) {
		e.preventDefault();
		setTimeout(function(){
	  	$makeDrinkGalleryNav.flickity('next');}, 500);
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
		wrapAround: true
	});

	$eventsGallery.flickity({
		asNavFor: '#events .gallery',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: true
	});

	$('#the-events .gallery-button-left img').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGalleryNav.flickity('previous');
	});
	$('#the-events .gallery-button-right img').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGalleryNav.flickity('next');
	});
});