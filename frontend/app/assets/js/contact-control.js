/*Validacion formulario*/

$(document).ready(function() {
  $("button.send").click(function(e){
    if($("#nombre").val() == "" || $("#correo").val() == "" || $("#comentario").val() == ""){
      e.preventDefault();
      submitValidate("#nombre", ".error-nombre", '<div style="width:160px">This field is required</div>');
      submitValidate("#correo", ".error-correo", '<div style="width:160px">This field is required</div>');
      submitValidate("#comentario", ".error-comentario", '<div style="width:160px">This field is required</div>');
      function submitValidate( inputName, divError, img){
        if($(inputName).val() == ""){
          $(divError).html(img);
        }
      }
    }
  });

  $('#nombre').keydown(function(e) {
  	var inputVal = String.fromCharCode(e.keyCode);
    var numericReg = /^[0-9]+$/;
    var numberInput = $("#nombre").data("id");
    if(numericReg.test(inputVal) && e.keyCode != 8) {
      e.preventDefault();
      $(".error-nombre").html('<div style="width:192px">Please enter a valid name</div>');
    }
    else if($('.input-contact').keydown){
      if((e.which == 13) && ($("#nombre").val() == "")){
        e.preventDefault();
        $(".error-nombre").html('<div style="width:160px">This field is required</div>');
      }else if ((e.which == 13) && ($("#nombre").val() != "")) {
        e.preventDefault();
        $('.input-contact')[numberInput+1].focus();  
        return;
      }
      else {
        $(".error-nombre").empty();
        return;
      }
    }
    else {
      $(".error-nombre").empty();
      return;
    }
  });
  $('#comentario').keydown(function(e) {
  	if($('.input-contact').keydown){
      if((e.which == 13) && ($("#comentario").val() == "")){
        e.preventDefault();
        $(".error-comentario").html('<div style="width:160px">This field is required</div>');
      }else if ((e.which == 13) && ($("#comentario").val() != "")) {
        e.preventDefault();
        $('.input-contact')[numberInput+1].focus();  
        return;
      }
      else {
        $(".error-comentario").empty();
        return;
      }
    }
    else {
      $(".error-comentario").empty();
      return;
    }
  });
  $('#correo').keyup(function(e) {
    var inputVal = $("#correo").val();
    var numericRegEmail = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{1,63}$/; 
    if((e.which == 13) && (inputVal != "")) {
      e.preventDefault();
      var numberInput = $("#correo").data("id");
      if(!numericRegEmail.test(inputVal) ) {
        $(".error-correo").html('<div style="width:198px">Please enter a valid e-mail</div>');
      }
      else {
        $(".error-correo").empty();
        $('.input-contact')[numberInput+1].focus(); 
        return;
      }
    } 
    else if ((inputVal != "") && !numericRegEmail.test(inputVal)){
      $(".error-correo").html('<div style="width:198px">Please enter a valid e-mail</div>');
    }
    else if( (e.which == 13) && (inputVal == "")) {
      e.preventDefault();
      $(".error-correo").html('<div style="width:160px">This field is required</div>');
    }
    else {
      $(".error-correo").empty();
      return;
    }
  });
});