import 'package:dataclass/dataclass.dart';

part 'domain.g.dart';

enum MonthsValue { Yes, No, Unknown }

@dataClass
class Months {
  final MonthsValue january;
  final MonthsValue february;
  final MonthsValue march;
  final MonthsValue april;
  final MonthsValue may;
  final MonthsValue june;
  final MonthsValue july;
  final MonthsValue august;
  final MonthsValue september;
  final MonthsValue oktober;
  final MonthsValue november;
  final MonthsValue december;

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
class Fish extends _$Fish {
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
          january : MonthsValue.Yes,
          february : MonthsValue.Yes,
          march : MonthsValue.Yes,
          april : MonthsValue.Yes,
          may : MonthsValue.Yes,
          june : MonthsValue.Yes,
          july : MonthsValue.Yes,
          august : MonthsValue.Yes,
          september : MonthsValue.Yes,
          oktober : MonthsValue.Yes,
          november : MonthsValue.Yes,
          december : MonthsValue.Yes),
        southern = Months(
          january : MonthsValue.Yes,
          february : MonthsValue.Yes,
          march : MonthsValue.Yes,
          april : MonthsValue.Yes,
          may : MonthsValue.Yes,
          june : MonthsValue.Yes,
          july : MonthsValue.Yes,
          august : MonthsValue.Yes,
          september : MonthsValue.Yes,
          oktober : MonthsValue.Yes,
          november : MonthsValue.Yes,
          december : MonthsValue.Yes);

}

@dataClass
class Bug extends _$Bug {
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
          january : MonthsValue.Yes,
          february : MonthsValue.Yes,
          march : MonthsValue.Yes,
          april : MonthsValue.Yes,
          may : MonthsValue.Yes,
          june : MonthsValue.Yes,
          july : MonthsValue.Yes,
          august : MonthsValue.Yes,
          september : MonthsValue.Yes,
          oktober : MonthsValue.Yes,
          november : MonthsValue.Yes,
          december : MonthsValue.Yes),
        southern = Months(
          january : MonthsValue.Yes,
          february : MonthsValue.Yes,
          march : MonthsValue.Yes,
          april : MonthsValue.Yes,
          may : MonthsValue.Yes,
          june : MonthsValue.Yes,
          july : MonthsValue.Yes,
          august : MonthsValue.Yes,
          september : MonthsValue.Yes,
          oktober : MonthsValue.Yes,
          november : MonthsValue.Yes,
          december : MonthsValue.Yes);
}
