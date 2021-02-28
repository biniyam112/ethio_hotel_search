import 'package:efoy_hotel_management_app/feature/room/data/dataprovider/room_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:flutter/material.dart';

class RoomRepository {
  final RoomDataProvider roomDataProvider;

  RoomRepository({@required this.roomDataProvider})
      : assert(roomDataProvider != null);

  Future<List<Room>> fetchRooms() async {
    return await roomDataProvider.fetchRooms();
  }
}
