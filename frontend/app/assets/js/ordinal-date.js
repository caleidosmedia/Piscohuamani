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
if (var dateNumber = 1; dateNumber < 32; ++dateNumber) {
    // ordinalDate(dateNumber);
    $(".fecha-evento").append("<sup>"+ ordinalDate(dateNumber) +"</sup>");
}