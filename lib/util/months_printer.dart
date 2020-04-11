import 'package:tuple/tuple.dart';

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
    Tuple2<int, int> current = Tuple2(-1,-1);
    List<Tuple2<int,int>> intervals = [];
    for(var e in yesno.withIndex()){
      var index = e.key;
      var value = e.value;

      if (!seen && value) {
        current = Tuple2(index, index);
        seen = true;
      } else if (index == 11 && value){
        current = Tuple2(current.item1, index);
        intervals.add(current);
      } else if (seen && value) {
        current = Tuple2(current.item1, index);
      } else if (seen && !value) {
        intervals.add(current);
        seen = false;
      }
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

    if(intervals.isEmpty){
      return "doesn't exist";
    }

    String output = "";
    bool isWrapped = intervals.first.item1 == 0 && intervals.last.item2 == 11;
    if(isWrapped && intervals.length > 2){
      output = "${map[intervals[1].item1]} - ${map[intervals[1].item2]}";
      output += " | ${map[intervals.last.item1]} - ${map[intervals.first.item2]}";
    } else if(intervals.first.item1 == 0 && intervals.first.item2 == 11){
      output = "All year";
    } else if(intervals.first.item1 == intervals.first.item2){
      output = map[intervals.first.item1];
    } else if(isWrapped){
      output = "${map[intervals.last.item1]} - ${map[intervals.first.item2]}";
    } else{
      output = intervals.map((e) => "${map[e.item1]} - ${map[e.item2]}").join(" | ");
    }
    return output;
  }

  String mkSouther() {
    return "southern";
  }
}