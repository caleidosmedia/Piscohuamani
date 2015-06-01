$(document).ready(function(){

	// Gallery Make Drink Control
	var $makeDrinkGallery = $('#make-drink .gallery-child');
	var $makeDrinkGalleryNav = $('#make-drink .gallery');

	$makeDrinkGallery.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$makeDrinkGalleryNav.flickity({
		asNavFor: '.gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$('#make-drink .gallery-button-left a').on( 'click', function(e) {
		e.preventDefault();
	  $makeDrinkGallery.flickity('previous');
	});
	$('#make-drink .gallery-button-right a').on( 'click', function(e) {
		e.preventDefault();
	  $makeDrinkGallery.flickity('next');
	});

	// Gallery Goods Control
	var $goodsGallery = $('#the-goods  .gallery-child');
	var $goodsGalleryNav = $('#the-goods .gallery');

	$goodsGallery.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$goodsGalleryNav.flickity({
		asNavFor: '.gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$('#the-goods .gallery-button-left a').on( 'click', function(e) {
		e.preventDefault();
	  $goodsGallery.flickity('previous');
	});
	$('#the-goods .gallery-button-right a').on( 'click', function(e) {
		e.preventDefault();
	  $goodsGallery.flickity('next');
	});

	// Gallery Events Control
	var $eventsGallery = $('#events .gallery-child');
	var $eventsGalleryNav = $('#events .gallery');

	$eventsGallery.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$eventsGalleryNav.flickity({
		asNavFor: '.gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$('#the-events .gallery-button-left a').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGallery.flickity('previous');
	});
	$('#the-events .gallery-button-right a').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGallery.flickity('next');
	});
});