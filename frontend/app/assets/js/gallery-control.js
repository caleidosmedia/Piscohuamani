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

});