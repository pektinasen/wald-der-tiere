class Bug {
  final String name;
  final String nameDe;
  final String price;
  final String shadow;
  final String location;
  final String time;
  // final List<String> months_north;
  // final List<String> months_south;

  Bug(this.name, this.nameDe, this.price, this.shadow, this.location,
      this.time);

  Bug.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        nameDe = json['Name'],
        price = json['Price'],
        shadow = json['Shadow'],
        location = json['Location'],
        time = json['Time'];

}
