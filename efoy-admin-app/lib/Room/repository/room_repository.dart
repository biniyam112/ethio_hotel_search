
import 'package:hotels/Room/data_provider/room_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotels/Room/models/room.dart';

class RoomRepository {
  final RoomDataProvider roomProvider;

  RoomRepository({@required this.roomProvider})
      : assert(roomProvider != null);

  Future<Room> createRoom(Room room) async {
    return await roomProvider.createRoom(room);
  }

  Future<List<Room>> getRooms() async {
    return await roomProvider.getRooms();
  }

  Future<Room> getRoom(String id) async {
    return await roomProvider.getRoom(id);
  }

  Future<void> updateRoom(Room room) async {
    await roomProvider.updateRoom(room);
  }

  Future<void> deleteRoom(String id) async {
    await roomProvider.deleteRoom(id);
  }
}
