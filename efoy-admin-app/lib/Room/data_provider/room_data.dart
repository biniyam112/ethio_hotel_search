import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:http/http.dart' as http;

class RoomDataProvider {
  final http.Client httpClient;
  final _baseUrl = "http://10.0.2.2:3000/api";

  RoomDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Room> createRoom(Room room) async {
    // File imageFile = Room.images[0];

    // Path path=Path();

    try {
      final response = await httpClient.post("$_baseUrl/rooms",
          headers: <String, String>{"Content-type": "application/json"},
          body: jsonEncode(<String, dynamic>{
            'pricePerNight': room.pricePerNight,
            'numberOfBedrooms': room.numberOfBedrooms,
            'description': room.description,
            'count': room.count,
            // 'onDiscount':room.onDiscount,
            // 'discountPercent':room.discountPercent,
          }));

      print("we are here");
      if (response.statusCode == 201) {
        print("response object");
        return Room.fromJson(jsonDecode(response.body));
      } else {
        print(response.body);
        throw Exception("Failed to create Room.");
      }
    } catch (e) {
      print("error happened");
      print(e);
      throw Exception(e);
    }

    // print(Room);
  }

  Future<List<Room>> getRooms() async {
    try {
      final response = await httpClient.get('$_baseUrl/rooms');
      if (response.statusCode == 200) {
        print(response.body);
        final room = jsonDecode(response.body)["rooms"] as List;
        return room.map((room) => Room.fromJson(room)).toList();
      } else {
        print("=====> here is the error");
      }
    } catch (e) {
      print(e);
      throw Exception("failed to load Rooms");
    }
  }

  Future<Room> getRoom(String id) async {
    final response = await httpClient.get('$_baseUrl/rooms/$id');
    if (response.statusCode == 200) {
      final room = json.decode(response.body);

      return Room.fromJson(room);
    } else {
      throw Exception("Failed to load Room");
    }
  }

  Future<void> deleteRoom(String id) async {
    print(id);
    try {
      final response = await httpClient.delete("$_baseUrl/rooms/$id",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      if (response.statusCode != 204) {
        print(response.body);
      }
    } catch (e) {
      print(e);
      throw Exception("failed to delete Rooms");
    }
  }

  Future<void> updateRoom(Room room) async {
    print('${room.id}@@@@@@@@@');
    final http.Response response = await httpClient.put(
      "http://10.0.2.2:3000/api/rooms/${room.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        // 'id':room.id,
        'pricePerNight': room.pricePerNight,
        'numberOfBedrooms': room.numberOfBedrooms,
        'description': room.description,
        'count': room.count,
        // 'onDiscount':room.onDiscount,
        // 'discountPercent':room.discountPercent,
        // 'hotel':room.hotel,
      }),
    );
    print(response.body);
    if (response.statusCode != 204) {
      throw Exception('Failed to update room.');
    }
  }
}
