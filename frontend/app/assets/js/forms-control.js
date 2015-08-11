/*
  VALIDACIÓN INGRESO
*/
// $(document).ready(function ($) {
//   $(".dropdown-menu li a").click(function () {
//     var selText = $(this).text();
//     $('.dropdown-menu').parent().find('.btn-default').html(selText +  '<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>');
//   });

  // $(".enter").click(function (event) {
  //   event.preventDefault();
  //   console.log('validating...');

  //   var day = validField($('#day'))? $('#day').val(): -1;
  //   var month = validField($('#month'))? $('#month').val(): -1;
  //   var year = validField($('#year'))? $('#year').val(): -1;
  //   var age =  21;
  //   var mydate = new Date();
  //   mydate.setFullYear(year, month-1, day);
  //   var currdate = new Date();
  //   currdate.setFullYear(currdate.getFullYear() - age);
  //   // return currdate > mydate;
  //   console.log(currdate > mydate);
  //   if(currdate>mydate){
  //     if( $('.checkbox .show').length > 0 ){
  //       createCookie('ageCheck', 'true');
  //     }
  //     // $(window).location.replace('/'+readCookie('lang')+'/index.php');
  //     $(location).attr('href','/index.html' );
  //   }
  // });

//   $(".btn-language").click(function (event) {
//     createCookie('lang',  $(this).attr('data-value'));
//   });
// });

// function validate(evt) {
//   var theEvent = evt || window.event;
//   var key = theEvent.keyCode || theEvent.which;
//   key = String.fromCharCode( key );
//   var regex = /[0-9]|\./;
//   if( !regex.test(key) ) {
//     theEvent.returnValue = false;
//     if(theEvent.preventDefault) {
//       theEvent.preventDefault();
//     }
//   }
// }

// function validField($field){
//   return ($field.is(":empty"));
// }

//Checkout
$(document).ready(function(){
  $(".box").on('click', function(){
    $(".close").toggleClass("show");
  });
});

//Contact
function enableordisable(){
if($(".name").val() !== ""){
  if($(".e-mail").val() !== ""){
    if($(".message").val() !== ""){
      $(".send").removeAttr("disabled");
      } else{
        $(".send").attr("disabled", "disabled");
      }
    }
  }
}
$(".name").keypress(enableordisable);
$(".e-mail").keypress(enableordisable);
$(".message").keypress(enableordisable);

//Ingresar
