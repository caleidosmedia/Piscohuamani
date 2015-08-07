/*
  COLLAPSE FAQS
*/
$('.change-arrow').click(function(){
	$(this).parent().find('#up').toggleClass("hidden");
	$(this).parent().find('#down').toggleClass("hidden");	
});



var backgrounds = ["assets/img/fotos/foto-home.png", "https://images.unsplash.com/reserve/Af0sF2OS5S5gatqrKzVP_Silhoutte.jpg?q=80&fm=jpg&s=aa0399d0a07be6afd5470a6dd6092bb3","https://images.unsplash.com/photo-1438109491414-7198515b166b?q=80&fm=jpg&s=cbdabf7a79c087a0b060670a6d79726c", "https://unsplash.com/photos/t-W4_309hi8/download", "https://unsplash.imgix.net/photo-1436915947297-3a94186c8133?fit=crop&fm=jpg&q=75&w=1050", "https://unsplash.imgix.net/photo-1435459025078-9857f8933bc9?fit=crop&fm=jpg&h=1050&q=75&w=1050", "https://ununsplash.imgix.net/photo-1434828927397-62ea053f7a35?fit=crop&fm=jpg&h=700&q=75&w=1050"]

$(document).ready(function () {
	var i = Math.floor(Math.random()*5)
	$("#background").attr("style", "background-image: url("+backgrounds[i]+")")
});