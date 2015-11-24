/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function(event){
	$(this).parent().find('#up').toggleClass("hidden");
	$(this).parent().find('#down').toggleClass("hidden");
	var target = $( event.target );
	// $(target).parent(".panel-default").find(".panel-collapse").toggleClass("in");
});