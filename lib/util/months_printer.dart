import 'package:tuple/tuple.dart';

import '../domain.dart';
import '../util/list.dart';

mixin MonthsPrinter {

  Months northern;
  Months southern;

  List<Tuple2<int,int>> evaluateIntervals(Iterable occurrences){
      bool seen = false;
      Tuple2<int, int> current = Tuple2(-1,-1);
      List<Tuple2<int,int>> intervals = [];
      for(var e in occurrences.withIndex()){
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
      return intervals;
  }

  String nameToChange(List<Tuple2<int, int>> intervals){
      const MONTHS = {
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

      String tuple2string(Tuple2<int, int> t) {
        if (t.item1 == t.item2) {
          return MONTHS[t.item1];
        }
        if (t.item1 == 0 && t.item2 == 11) {
          return "All year";
        }
        return "${MONTHS[t.item1]} - ${MONTHS[t.item2]}";
      } 

      // we have a wrapped interval
      if (intervals.length > 1 && intervals.first.item1 == 0 && intervals.last.item2 == 11) {
        intervals = [intervals[1], Tuple2(intervals.last.item1, intervals.first.item2)];
      }

      return intervals.map(tuple2string).join(" | ");
  }

String mkMonthsNorthern() {
    var occurrences = [
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

    List<Tuple2<int,int>> intervals = evaluateIntervals(occurrences);
    return nameToChange(intervals);
    
  }

  String mkSouther() {
    var occurrences = [
      southern.february,
      southern.january,
      southern.march,
      southern.april,
      southern.may,
      southern.june,
      southern.july,
      southern.august,
      southern.september,
      southern.oktober,
      southern.november,
      southern.december,
    ].map((_) => (_ == MonthValue.Yes));
    
    List<Tuple2<int,int>> intervals = evaluateIntervals(occurrences);
    return nameToChange(intervals);
  }
}