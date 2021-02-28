import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';

class Event {
  String name, description;
  Hotel hostHotel;
  List<dynamic> images;
  int price, discount;
  Event({
    this.hostHotel,
    this.name,
    this.images,
    this.price,
    this.description,
    this.discount,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['title'],
      description: json['description'],
      images: json['images'],
      // hostHotel: Hotel(
      //   name: json['hotel'],
      // ),
      // price: json['price'],
      // discount: json['discount'],
    );
  }
}
