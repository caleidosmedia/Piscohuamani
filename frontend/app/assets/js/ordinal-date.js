function ordinalDate(date) {
    switch (date) {
    case 1:
    case 21:
    case 31:
        return 'st';
    case 2:
    case 22:
        return 'nd';
    case 3:
    case 23:
        return 'rd';
    default:
        return 'th';
    }
}
var dateNumber = $(".fecha-evento").html().substr(4);
// $(".fecha-evento").each(function(){
    if (dateNumber < 32) {
      $(".fecha-evento").append("<sup>"+ ordinalDate(dateNumber) +"</sup>");
    }
// });

// var dateNumber = $(".fecha-evento").html().substr(4);
// $(".fecha-evento").each(function(){
//   if (dateNumber= 1 || dateNumber= 21 || dateNumber= 31) {
//     $(".fecha-evento").append("<sup>st</sup>");
//   }
//   else if (dateNumber= 2 || dateNumber= 22) {
//     $(".fecha-evento").append("<sup>nd</sup>");
//   }
//   else if (dateNumber= 3 || dateNumber= 23) {
//     $(".fecha-evento").append("<sup>rd</sup>");
//   }
//   else {
//     $(".fecha-evento").append("<sup>th</sup>");
//   }
// });
