class Fish {
  final String uuid;
  final String name;
  final int price;
  final String shadow;
  final String location;
  final String time;
  final String image;
  // final List<String> months_north;
  // final List<String> months_south;

  Fish(this.uuid, this.name, this.price, this.shadow, this.location,
      this.time, this.image);

  Fish.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        price = json['price'],
        shadow = json['shadow'],
        location = json['location'],
        time = json['time'],
        image = json['image_name'];

}

class Bug {
  final String uuid;
  final String name;
  final int price;
  final String location;
  final String time;
  final String image;

  // final List<String> months_north;
  // final List<String> months_south;

  Bug(this.uuid, this.name, this.price, this.location,
      this.time, this.image);

  Bug.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        price = json['price'],
        location = json['location'],
        time = json['time'],
        image = json['image_name'];

}
