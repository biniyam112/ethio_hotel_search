import 'package:hotels/Room/bloc/bloc.dart';
import 'package:hotels/Room/repository/room_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc({@required this.roomRepository})
      : assert(roomRepository != null),
        super(RoomLoading());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is RoomLoad) {
      yield* _mapRoomLoadEventToState(event);
    }
    if (event is RoomCreate) {
      yield* _mapRoomCreateEventToState(event);
    }
    if (event is RoomUpdate) {
      yield* _mapRoomUpdateEventToState(event);
    }
    if (event is RoomDelete) {
      yield* _mapRoomDeleteEventToState(event);
    }
  }

  Stream<RoomState> _mapRoomLoadEventToState(RoomLoad event) async* {
    yield RoomLoading();

    try {
      final rooms = await roomRepository.getRooms();
      

      yield RoomLoadSuccess(rooms:rooms );
    } catch (_) {
      yield RoomOperationFailure();
    }
  }

  Stream<RoomState> _mapRoomCreateEventToState(RoomCreate event) async* {
    try {
      await roomRepository.createRoom(event.room);

      final rooms = await roomRepository.getRooms();
      print(rooms);
     
      yield RoomLoadSuccess(rooms: rooms);
    } catch (e) {
      print(e);
      yield RoomOperationFailure();
    }
  }

  Stream<RoomState> _mapRoomUpdateEventToState(RoomUpdate event) async* {
    try {
      print("Room update");
      await roomRepository.updateRoom(event.room);
      final rooms = await roomRepository.getRooms();

      yield RoomLoadSuccess(rooms: rooms);
    } catch (_) {
      yield RoomOperationFailure();
    }
  }

  Stream<RoomState> _mapRoomDeleteEventToState(RoomDelete event) async* {
    try {
      print(event.room);
      await roomRepository.deleteRoom(event.room.id);

      final rooms = await roomRepository.getRooms();
      yield RoomLoadSuccess(rooms: rooms);
    } catch (_) {
      yield RoomOperationFailure();
    }
  }
}
