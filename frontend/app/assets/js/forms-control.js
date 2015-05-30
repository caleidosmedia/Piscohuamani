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