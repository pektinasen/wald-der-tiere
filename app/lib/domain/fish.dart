class Fish {
  final String name;
  final String nameDe;
  final String price;
  final String shadow;
  final String location;
  final String time;
  // final List<String> months_north;
  // final List<String> months_south;

  Fish(this.name, this.nameDe, this.price, this.shadow, this.location,
      this.time);

  Fish.fromJson(Map<String, dynamic> json)
      : name = json['Fish'],
        nameDe = json['Fish'],
        price = json['Price'],
        shadow = json['Shadow'],
        location = json['Location'],
        time = json['Time'];

}
