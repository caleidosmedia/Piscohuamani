/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function(){
	$(this).parent().find('#up').toggleClass("hidden");
	$(this).parent().find('#down').toggleClass("hidden");	
});

