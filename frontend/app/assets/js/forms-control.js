var numericReg = /^[0-9\b]+$/;
var current_year = new Date().getFullYear();
var current_day = new Date().getDate();
var current_month = new Date().getMonth();
var year = $("#year");

var paises = "";
function loadJson(callback) {
  var xobj = new XMLHttpRequest();
  xobj.overrideMimeType("application/json");
  xobj.open('GET', 'assets/json/drinkingage.json', true);
  xobj.onreadystatechange = function () {
    if (xobj.readyState == 4 && xobj.status == "200") {
      callback(xobj.responseText);
    }
  };
  xobj.send(null);
}

function init() {
  loadJson(function(response) {
    var data = JSON.parse(response);
    paises = data.countries;
  });
}

init();


$(document).ready(function() {
  /*Validación edad*/
  hola();

  $(year).change(function(){
    if (year.val().length === 4) {
      var min_age = 0;
      $("#country").change(function(){
        var selected_country = $("#country option:selected").text();
        console.log(selected_country);
        for (var i = 0; i < paises.length; i++) {
          if (paises[i].country === selected_country) {
            min_age = paises[i].age;
            console.log(min_age);
            return;
          };
        var newYear = $(year).val();
         if ((current_year - $(newYear).parseInt() > min_age)) {
            $(".enter").removeAttr("disabled");
            $(".enter").addClass("active-enter");
          }
          else {
              $(".enter").Attr("disabled");
              $(".enter").removeClass("active-enter");
            }  
         
        };

        // if ((current_year - $(year).val() <= min_age)) {
        //   var year_1 = $(year).val();
        //   var month_1 = parseInt($(month).val());
        //   var day_1 = parseInt($(day).val());
        //   var days_to_birthday = 0;
        //   var days_to_today = 0;
        //   for (var i = 1; i < month_1; i++) {
        //     days_to_birthday += new Date(year_1, month_1-i, 0).getDate();
        //   };
        //   days_to_birthday += day_1;
        //   console.log(days_to_birthday);
        //   for (var i = 0; i < current_month; i++) {
        //     days_to_today += new Date(current_year, current_month-i, 0).getDate();
        //   };
        //   days_to_today += current_day;
        //   console.log(days_to_today); 
        //   if (days_to_today < days_to_birthday) {
        //     $(".enter").attr("disabled", "disabled");
        //     $(".enter").removeClass("active-enter");
        //   };    
        // }
        
      });
    }
  });
}); 

/*Número máximo y autojump*/
function hola() {
  input("#day", 31);
  input("#month", 12);
  input("#year", current_year);
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