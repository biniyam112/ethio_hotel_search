import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HotelEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHotels extends HotelEvent {}

class FetchHotelById extends HotelEvent {
  final String id;
  FetchHotelById({@required this.id});
}
