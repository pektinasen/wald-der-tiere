import '../domain.dart';
import '../util/list.dart';

mixin MonthsPrinter {

  Months northern;
  Months southern;

String mkMonthsNorthern() {
    var yesno = [
      northern.january,
      northern.february,
      northern.march,
      northern.april,
      northern.may,
      northern.june,
      northern.july,
      northern.august,
      northern.september,
      northern.oktober,
      northern.november,
      northern.december,
    ].map((_) => (_ == MonthValue.Yes));

    int firstMonth = 0, lastMonth = 0;

    bool seen = false;
    List<int> freeInbetween = [-1,-1];
    for(var e in yesno.withIndex()){
      var key = e.key;
      var value = e.value;

      // TODO: Check for multiple intervals
      if(value && !seen){
        firstMonth = key;
        seen = true;
      } else if (value && seen){
        lastMonth = key;
      } else if (!value && seen && freeInbetween[0] == -1){
        freeInbetween[0] = e.key;
      } else if (!value && seen && freeInbetween[0] != -1){
        freeInbetween[1] = e.key;
      }
    }
    if (freeInbetween[0] != -1 && freeInbetween[1] < lastMonth){
      firstMonth = freeInbetween[1] + 1;
      lastMonth = freeInbetween[0] - 1;
    }

    var map = {
      0 : "Jan",
      1 : "Feb",
      2 : "Mar",
      3 : "Apr",
      4 : "May",
      5 : "Jun",
      6 : "Jul",
      7 : "Aug",
      8 : "Sep",
      9 : "Okt",
      10 : "Nov",
      11 : "Dez",
    };
    return firstMonth == 0 && lastMonth == 11 
    ? "All year"
     : "${map[firstMonth]} - ${map[lastMonth]}";
  }

  String mkSouther() {
    return "southern";
  }
}