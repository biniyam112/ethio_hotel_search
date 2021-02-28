import 'package:efoy_hotel_management_app/feature/hotel/data/dataprovider/hotel_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:flutter/material.dart';

class HotelRepository {
  final HotelDataProvider hotelDataProvider;
  final String hotelId;

  HotelRepository({@required this.hotelDataProvider, this.hotelId})
      : assert(hotelDataProvider != null);

  Future<List<Hotel>> fetchHotels() async {
    return await hotelDataProvider.fetchHotels();
  }

  Future<Hotel> fetchHotelById(String id) async {
    return await hotelDataProvider.fetchHotelById(id);
  }
}
