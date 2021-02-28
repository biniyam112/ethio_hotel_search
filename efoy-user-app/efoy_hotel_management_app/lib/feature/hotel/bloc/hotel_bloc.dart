import 'package:dartz/dartz.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_event.dart';
import 'package:efoy_hotel_management_app/feature/hotel/bloc/hotel_state.dart';
import 'package:efoy_hotel_management_app/feature/hotel/data/repository/hotel_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;
  HotelBloc({@required this.hotelRepository})
      : assert(hotelRepository != null),
        super(HotelFetchingState());

  @override
  Stream<HotelState> mapEventToState(HotelEvent event) async* {
    if (event is FetchHotels) {
      yield HotelFetchingState();
      try {
        final hotels = await hotelRepository.fetchHotels();
        print('the hotels are $hotels');
        yield HotelFetchedState(hotels: hotels);
      } catch (e) {
        print('hotel fetch error : $e');
        yield HotelFetchFailedState();
      }
    }
    if (event is FetchHotelById) {
      yield HotelFetchingState();
      try {
        print('get by id succesful');
        final hotel = await hotelRepository.fetchHotelById(event.id);
        yield HotelFetchedById(hotel: hotel);
      } catch (e) {
        print('$e error while fetching hotels by id');
      }
    }
  }
}
