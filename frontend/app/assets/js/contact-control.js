$(document).ready(function(){
	$(".send a").click(function(e){
		e.preventDefault();
		$(".overlay-contact").addClass("active-pop");
	});
});