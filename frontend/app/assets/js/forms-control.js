var numericReg = /^[0-9\b]+$/;

$(document).ready(function() {
  hola();
}); 

function hola() {
  input("#day", "31");
  input("#month", "12");
  validar();
}

function validar(e, number,names) {
  var inputVal = String.fromCharCode(e.keyCode);
  if(!numericReg.test(inputVal)) {
    $(names).val(number);
      e.preventDefault();
    }
  else {
    $(names).innerText = "";
    return;
  }
}

function input(names, number) {
  $(names).keydown(function(e) {
    if ( number < $(names).val()) {
      $(names).val(number);
    }
    validar(e);
  });
  $(names).keyup(function(e) {
    if ( number < $(names).val()) {
      $(names).val(number);
    }
    validar(e);
  });
  $(".number").keyup(function () {
    if (this.value.length == this.maxLength) {
      $(this).next('.number').focus();
    }
  });
} 