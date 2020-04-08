// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$Fish {
  const _$Fish();

  String get uuid;
  String get name;
  int get price;
  String get shadow;
  String get location;
  String get time;
  String get image;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! Fish) return false;

    return true &&
        this.uuid == other.uuid &&
        this.name == other.name &&
        this.price == other.price &&
        this.shadow == other.shadow &&
        this.location == other.location &&
        this.time == other.time &&
        this.image == other.image;
  }

  int get hashCode {
    return mapPropsToHashCode(
        [uuid, name, price, shadow, location, time, image]);
  }

  String toString() {
    return 'Fish <\'uuid\': ${this.uuid},\'name\': ${this.name},\'price\': ${this.price},\'shadow\': ${this.shadow},\'location\': ${this.location},\'time\': ${this.time},\'image\': ${this.image},>';
  }

  Fish copyWith(
      {String uuid,
      String name,
      int price,
      String shadow,
      String location,
      String time,
      String image}) {
    return Fish(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      price: price ?? this.price,
      shadow: shadow ?? this.shadow,
      location: location ?? this.location,
      time: time ?? this.time,
      image: image ?? this.image,
    );
  }
}

abstract class _$Bug {
  const _$Bug();

  String get uuid;
  String get name;
  int get price;
  String get location;
  String get time;
  String get image;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! Bug) return false;

    return true &&
        this.uuid == other.uuid &&
        this.name == other.name &&
        this.price == other.price &&
        this.location == other.location &&
        this.time == other.time &&
        this.image == other.image;
  }

  int get hashCode {
    return mapPropsToHashCode([uuid, name, price, location, time, image]);
  }

  String toString() {
    return 'Bug <\'uuid\': ${this.uuid},\'name\': ${this.name},\'price\': ${this.price},\'location\': ${this.location},\'time\': ${this.time},\'image\': ${this.image},>';
  }

  Bug copyWith(
      {String uuid,
      String name,
      int price,
      String location,
      String time,
      String image}) {
    return Bug(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      price: price ?? this.price,
      location: location ?? this.location,
      time: time ?? this.time,
      image: image ?? this.image,
    );
  }
}
