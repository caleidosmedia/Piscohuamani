$(document).ready(function(){

	// Gallery Make Drink Control
	var $makeDrinkGallery = $('#make-drink .gallery-child');
	var $makeDrinkGalleryNav = $('#make-drink .gallery');

	$makeDrinkGallery.flickity({
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false,
		draggable: false,
		wrapAround: true
	});

	$makeDrinkGalleryNav.flickity({
		asNavFor: '#make-drink .gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false,
		draggable: false,
		wrapAround: true
	});

	$('#make-drink .gallery-button-left span').on( 'click', function(e) {
		e.preventDefault();
	  $makeDrinkGallery.flickity('previous');
	});
	$('#make-drink .gallery-button-right span').on( 'click', function(e) {
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
		wrapAround: false,
		draggable: false,
		wrapAround: true
	});

	$goodsGalleryNav.flickity({
		asNavFor: '#the-goods .gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false,
		draggable: false,
		wrapAround: true
	});

	$('#the-goods .gallery-button-left span').on( 'click', function(e) {
		e.preventDefault();
	  $goodsGallery.flickity('previous');
	});
	$('#the-goods .gallery-button-right span').on( 'click', function(e) {
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
		asNavFor: '#events .gallery-child',
		cellAlign: 'left',
		contain: true,
		prevNextButtons: false,
		pageDots: false,
		wrapAround: false
	});

	$('#the-events .gallery-button-left span').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGalleryNav.flickity('previous');
	});
	$('#the-events .gallery-button-right span').on( 'click', function(e) {
		e.preventDefault();
	  $eventsGalleryNav.flickity('next');
	});
});