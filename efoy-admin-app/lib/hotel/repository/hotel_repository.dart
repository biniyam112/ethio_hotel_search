import 'package:hotels/hotel/data_provider/data_provider.dart';
import 'package:hotels/hotel/models/hotel.dart';
import 'package:flutter/cupertino.dart';

class HotelRepository {
  final HotelDataProvider hotelProvider;

  HotelRepository({@required this.hotelProvider})
      : assert(hotelProvider != null);

  Future<Hotel> createHotel(
      {Hotel hotel, String password, String email}) async {
    return await hotelProvider.createHotel(
        hotel: hotel, password: password, email: email);
  }

  Future<List<Hotel>> getHotels() async {
    return await hotelProvider.getHotels();
  }

  Future<Hotel> getHotel(String id) async {
    return await hotelProvider.getHotel(id);
  }

  Future<void> updateHotel(Hotel hotel) async {
    await hotelProvider.updateHotel(hotel);
  }

  Future<void> deleteHotel(String id) async {
    await hotelProvider.deleteHotel(id);
  }
}
