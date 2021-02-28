import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';

class Hotel {
  String name, description, location;
  List<dynamic> images;
  int rating;
  List<Room> rooms;

  Hotel({
    this.images,
    this.name,
    this.description,
    this.location,
    this.rooms,
    this.rating,
  });

  factory Hotel.fromjson(Map<String, dynamic> json) {
    return Hotel(
      name: json["name"],
      location: json["location"],
      rating: json["stars"],
      description: json["description"],
      // rooms: json["rooms"],
      images: json["images"],
    );
  }
}
