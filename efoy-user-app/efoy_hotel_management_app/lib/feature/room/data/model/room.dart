class Room {
  // Hotel hotel;
  String hotelId, description, id;
  List<String> imagePath;
  int price;
  int discount, rating;
  int bedCount;

  Room({
    // this.hotel,
    this.id,
    this.imagePath,
    this.hotelId,
    this.price,
    this.bedCount,
    this.discount,
    this.rating,
    this.description,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'],
      price: json['pricePerNight'],
      // imagePath: json['images'],
      bedCount: json['numberOfBedrooms'],
      // rating: json['rating'],
      description: json['description'],
      hotelId: json["hotel"],
      discount: json['discountPercent'],
      // hotel: Hotel(
      // name: json['name'],
      // location: json['location'],
      // ),
    );
  }
}
