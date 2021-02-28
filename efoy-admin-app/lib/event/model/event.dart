import 'dart:io';

class Event {
  String name, description, id;
  List<File> imagepath;
  // Hotel hostHotel;
  // int price, discount;
  Event({
    // this.hostHotel,
    this.id,
    this.name,
    this.imagepath,

    // this.price,
    this.description,
    // this.discount,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      name: json['title'],
     
      // hostHotel: Hotel(
      //   name: json['hotel'],
      // ),
      // imagePath: json['images'][0],
      // price: json['price'],

      imagepath: [File(json['images'][0])],
      description: json['description'],
      // discount: json['discount'],
    );
  }
}
