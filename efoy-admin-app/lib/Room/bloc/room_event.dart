import 'package:equatable/equatable.dart';
import 'package:hotels/Room/models/room.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
  @override
  List<Object> get props => [];
}

class RoomLoad extends RoomEvent {
  const RoomLoad();
}

class RoomCreate extends RoomEvent {
  final Room room;
  const RoomCreate(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() {
    return "Room created {Room:$room}";
  }
}

class RoomUpdate extends RoomEvent {
  final Room room;
  const RoomUpdate(this.room);

  @override
  List<Object> get props => [Room];

  @override
  String toString() {
    return "Room updated {Room:$room}";
  }
}

class RoomDelete extends RoomEvent {
  final Room room;
  const RoomDelete(this.room);

  @override
  List<Object> get props => [Room];

  @override
  String toString() {
    return "Room deleted {Room:$Room}";
  }
}
