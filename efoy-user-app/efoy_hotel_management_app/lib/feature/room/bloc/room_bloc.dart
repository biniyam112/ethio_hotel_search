import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_event.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_event.dart';
import 'package:efoy_hotel_management_app/feature/room/bloc/room_state.dart';
import 'package:efoy_hotel_management_app/feature/room/data/repository/room_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  RoomBloc({@required this.roomRepository})
      : assert(roomRepository != null),
        super(RoomFetchingState());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is FetchRoom) {
      yield RoomFetchingState();
      try {
        final rooms = await roomRepository.fetchRooms();
        print('the room is butch:${rooms[0].description}');
        yield RoomFetchedState(rooms: rooms);
      } catch (e) {
        print('$e this is room error');
        yield RoomFetchFailedState();
      }
    }
  }
}
