import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BookEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BookRoomEvent extends BookEvent {
  final Room room;
  final String phone;

  BookRoomEvent({@required this.room, @required this.phone});
}
