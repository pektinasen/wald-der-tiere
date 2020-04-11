import 'package:dataclass/dataclass.dart';
import 'package:wald_der_tiere/util/months_printer.dart';

part 'domain.g.dart';

enum MonthValue { Yes, No, Unknown }
abstract class MonthsValue {
  static of(String s) {
    if (s == '✓') {
      return MonthValue.Yes;
    }
    if (s == '-') {
      return MonthValue.No;
    }
    return MonthValue.Unknown;
  }
}

@dataClass
class Months {
  final MonthValue january;
  final MonthValue february;
  final MonthValue march;
  final MonthValue april;
  final MonthValue may;
  final MonthValue june;
  final MonthValue july;
  final MonthValue august;
  final MonthValue september;
  final MonthValue oktober;
  final MonthValue november;
  final MonthValue december;

  const Months(
      {this.january,
      this.february,
      this.march,
      this.april,
      this.may,
      this.june,
      this.july,
      this.august,
      this.september,
      this.oktober,
      this.november,
      this.december});
}

@dataClass
class Fish extends _$Fish with MonthsPrinter {
  final String uuid;
  final String name;
  final int price;
  final String shadow;
  final String location;
  final String time;
  final String image;
  final Months northern;
  final Months southern;

  Fish(
      {this.uuid,
      this.name,
      this.price,
      this.shadow,
      this.location,
      this.time,
      this.image,
      this.northern,
      this.southern});

  Fish.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        price = json['price'],
        shadow = json['shadow'],
        location = json['location'],
        time = json['time'],
        image = json['image_name'],
        northern = Months(
          january : MonthsValue.of(json['northern']['jan']),
          february : MonthsValue.of(json['northern']['feb']),
          march : MonthsValue.of(json['northern']['mar']),
          april : MonthsValue.of(json['northern']['apr']),
          may : MonthsValue.of(json['northern']['may']),
          june : MonthsValue.of(json['northern']['jun']),
          july : MonthsValue.of(json['northern']['jul']),
          august : MonthsValue.of(json['northern']['aug']),
          september : MonthsValue.of(json['northern']['sep']),
          oktober : MonthsValue.of(json['northern']['okt']),
          november : MonthsValue.of(json['northern']['nov']),
          december : MonthsValue.of(json['northern']['dec'])),
        southern = Months(
          january : MonthsValue.of(json['southern']['jan']),
          february : MonthsValue.of(json['southern']['feb']),
          march : MonthsValue.of(json['southern']['mar']),
          april : MonthsValue.of(json['southern']['apr']),
          may : MonthsValue.of(json['southern']['may']),
          june : MonthsValue.of(json['southern']['jun']),
          july : MonthsValue.of(json['southern']['jul']),
          august : MonthsValue.of(json['southern']['aug']),
          september : MonthsValue.of(json['southern']['sep']),
          oktober : MonthsValue.of(json['southern']['okt']),
          november : MonthsValue.of(json['southern']['nov']),
          december : MonthsValue.of(json['southern']['dec']));
          
}

@dataClass
class Bug extends _$Bug with MonthsPrinter {
  final String uuid;
  final String name;
  final int price;
  final String location;
  final String time;
  final String image;
  final Months northern;
  final Months southern;
  // final List<String> months_north;
  // final List<String> months_south;

  Bug({this.uuid, this.name, this.price, this.location, this.time, this.image, this.northern, this.southern});

  Bug.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        price = json['price'],
        location = json['location'],
        time = json['time'],
        image = json['image_name'],
        northern = Months(
          january : MonthsValue.of(json['northern']['jan']),
          february : MonthsValue.of(json['northern']['feb']),
          march : MonthsValue.of(json['northern']['mar']),
          april : MonthsValue.of(json['northern']['apr']),
          may : MonthsValue.of(json['northern']['may']),
          june : MonthsValue.of(json['northern']['jun']),
          july : MonthsValue.of(json['northern']['jul']),
          august : MonthsValue.of(json['northern']['aug']),
          september : MonthsValue.of(json['northern']['sep']),
          oktober : MonthsValue.of(json['northern']['okt']),
          november : MonthsValue.of(json['northern']['nov']),
          december : MonthsValue.of(json['northern']['dec'])),
        southern = Months(
          january : MonthsValue.of(json['southern']['jan']),
          february : MonthsValue.of(json['southern']['feb']),
          march : MonthsValue.of(json['southern']['mar']),
          april : MonthsValue.of(json['southern']['apr']),
          may : MonthsValue.of(json['southern']['may']),
          june : MonthsValue.of(json['southern']['jun']),
          july : MonthsValue.of(json['southern']['jul']),
          august : MonthsValue.of(json['southern']['aug']),
          september : MonthsValue.of(json['southern']['sep']),
          oktober : MonthsValue.of(json['southern']['okt']),
          november : MonthsValue.of(json['southern']['nov']),
          december : MonthsValue.of(json['southern']['dec']));
}
