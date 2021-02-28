import 'package:efoy_hotel_management_app/feature/room/data/model/room.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class RoomFetchingState extends RoomState {}

class RoomFetchedState extends RoomState {
  final List<Room> rooms;
  // final bool hasreachedMax;

  RoomFetchedState({
    @required this.rooms,
    // @required this.hasreachedMax,
  });
}

class RoomFetchFailedState extends RoomState {}
