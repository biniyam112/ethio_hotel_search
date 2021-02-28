import 'package:equatable/equatable.dart';
import 'package:hotels/Room/models/room.dart';
import 'package:meta/meta.dart';

abstract class RoomState extends Equatable {
  const RoomState();
  @override
  List<Object> get props => [];
}

class RoomLoading extends RoomState {}

class RoomLoadSuccess extends RoomState {
  final List<Room> rooms;
  RoomLoadSuccess({@required this.rooms}) : assert(rooms != null);
  @override
  List<Object> get props => [this.rooms];
}

class RoomOperationFailure extends RoomState {}
