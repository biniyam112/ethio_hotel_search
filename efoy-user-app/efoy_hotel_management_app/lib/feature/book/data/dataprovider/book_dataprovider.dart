import 'dart:convert';

import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDataProvider {
  final http.Client client;
  final String baseUri = 'http://10.0.2.2:3000/api';
  BookDataProvider({@required this.client}) : assert(client != null);

  Future<void> bookHotel(Room room, String phone) async {
    var response = await client.post(
      '$baseUri/bookings',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'room': room.id,
          'phoneNumber': phone,
          'hotel': room.hotelId,
        },
      ),
    );
    if (response.statusCode == 201) {
      // todo : here
      print('booking successful');
    } else {
      print(response.reasonPhrase);
      print(response.body);
      throw Exception('unable to book room');
    }
  }
}
