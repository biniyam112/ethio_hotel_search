import 'package:efoy_hotel_management_app/feature/hotel/data/model/hotel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HotelState extends Equatable {
  @override
  List<Object> get props => [];
}

class HotelFetchingState extends HotelState {}

class HotelFetchedState extends HotelState {
  final List<Hotel> hotels;
  // final bool hasreachedMax;

  HotelFetchedState({
    @required this.hotels,
    // @required this.hasreachedMax,
  });
}

class HotelFetchedById extends HotelState {
  final Hotel hotel;

  HotelFetchedById({@required this.hotel});
}

class HotelFetchFailedState extends HotelState {}
