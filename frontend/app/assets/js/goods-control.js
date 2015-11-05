$(document).ready(function(){
	i = 0
	$(".text-opacity1").each(function(){
		ubicacion = $(".text-opacity1").eq(i);
		numberData = $(ubicacion).index();
		$(ubicacion).attr("data-index", numberData + 1);
		i++
	});
});