/*
  VALIDACIÓN INGRESO
*/
$(document).ready(function(){
  $("#formulario").submit(function(){
    var day = $("#day").val();
    var month = $("#month").val();
    var year = $("#year").val();
    var age = 18;
    var mydate = new Date();
    mydate.setFullYear(year, month-1, day);

    var currdate = new Date();
    currdate.setFullYear(currdate.getFullYear() - age);
    if ((currdate - mydate) < 0){
      $(".enter").click(function(){
        $("this").removeAttr("href").css("cursor","pointer");
      });
    };
  });
});

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
