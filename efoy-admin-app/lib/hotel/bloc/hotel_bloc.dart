import 'package:hotels/hotel/bloc/bloc.dart';
import 'package:hotels/hotel/repository/hotel_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;

  HotelBloc({@required this.hotelRepository})
      : assert(hotelRepository != null),
        super(HotelLoading());

  @override
  Stream<HotelState> mapEventToState(HotelEvent event) async* {
    if (event is HotelLoad) {
      yield* _mapHotelLoadEventToState(event);
    }
    if (event is HotelCreate) {
      yield* _mapHotelCreateEventToState(event);
    }
    if (event is HotelUpdate) {
      yield* _mapHotelUpdateEventToState(event);
    }
    if (event is HotelDelete) {
      yield* _mapHotelDeleteEventToState(event);
    }
  }

  Stream<HotelState> _mapHotelLoadEventToState(HotelLoad event) async* {
    yield HotelLoading();

    try {
      final hotels = await hotelRepository.getHotels();

      yield HotelLoadSuccess(hotels: hotels);
    } catch (e) {
      print('hotel load error $e');
      yield HotelOperationFailure();
    }
  }

  Stream<HotelState> _mapHotelCreateEventToState(HotelCreate event) async* {
    yield HotelAddingState();
    try {
      await hotelRepository.createHotel(
          hotel: event.hotel, email: event.email, password: event.password);
      yield HotelAddedState();
    } catch (e) {
      print(e);
      yield HotelOperationFailure();
    }
  }

  Stream<HotelState> _mapHotelUpdateEventToState(HotelUpdate event) async* {
    try {
      print("hotel update");
      await hotelRepository.updateHotel(event.hotel);
      final hotels = await hotelRepository.getHotels();

      yield HotelLoadSuccess(hotels: hotels);
    } catch (_) {
      yield HotelOperationFailure();
    }
  }

  Stream<HotelState> _mapHotelDeleteEventToState(HotelDelete event) async* {
    try {
      await hotelRepository.deleteHotel(event.hotel.id);

      final hotels = await hotelRepository.getHotels();
      print('hotel deleted');
      yield HotelLoadSuccess(hotels: hotels);
    } catch (e) {
      print('hotel deleteion failed $e');
      yield HotelOperationFailure();
    }
  }
}
