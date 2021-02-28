import 'dart:convert';

import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RoomDataProvider {
  final http.Client client;
  final _baseUrl = 'http://10.0.2.2:3000/api';

  RoomDataProvider({@required this.client}) : assert(client != null);
  Future<List<Room>> fetchRooms() async {
    final response = await client.get('$_baseUrl/rooms');
    if (response.statusCode == 200) {
      print('provider level room: fetching done succesfully');
      final rooms = jsonDecode(response.body)["rooms"] as List;
      print('$rooms');
      return rooms.map((room) => Room.fromJson(room)).toList();
    } else {
      print('failed to get data');
      throw Exception('failed to fetch rooms');
    }
  }
}
