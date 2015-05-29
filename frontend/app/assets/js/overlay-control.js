/*
  POPUP EVENTS
*/
var $overlay = $('#overlay');
var $image = $('#overlay img');
var $caption = $('#overlay p');

$('.grid ul li a').click(function (event) {
  event.preventDefault();
  var href = $(this).attr('href');
  var captionText = $(this).children("img").attr("alt");
  $caption.text(captionText);
  $image.attr("src", href);
  $overlay.addClass("#flex").show();
});

$overlay.click(function(){ 
      $overlay.hide();
});