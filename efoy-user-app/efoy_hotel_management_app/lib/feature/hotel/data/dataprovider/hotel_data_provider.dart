import 'dart:convert';

import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HotelDataProvider {
  final http.Client client;
  final String baseUri = 'http://10.0.2.2:3000/api';
  HotelDataProvider({@required this.client}) : assert(client != null);

  Future<List<Hotel>> fetchHotels() async {
    final response = await client.get('$baseUri/hotels');

    if (response.statusCode == 200) {
      final hotels = jsonDecode(response.body)["hotels"] as List;
      print('hotel fetch done $hotels');
      return hotels.map((hotel) => Hotel.fromjson(hotel)).toList();
    } else {
      print('error in hotel provider');
      throw Exception('failed to fetch hotels');
    }
  }

  Future<Hotel> fetchHotelById(String id) async {
    print('\n\n\n$id\n\n\n');
    final response = await client.get('$baseUri/hotels/$id');
    if (response.statusCode == 200) {
      final hotel = jsonDecode(response.body)["data"];
      print('the hotel form id is $hotel');
      return Hotel.fromjson(hotel);
    } else {
      print('error on getting hotels by id');
      throw Exception('failed to get hotels by id');
    }
  }
}
