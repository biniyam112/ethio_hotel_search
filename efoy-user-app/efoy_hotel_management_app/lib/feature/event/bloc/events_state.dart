import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../data/model/event.dart';

class EventState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEventingState extends EventState {}

class FetchEventedState extends EventState {
  final List<Event> events;
  // final bool hasreachedMax;

  FetchEventedState({
    @required this.events,
    // @required this.hasreachedMax,
  });
}

class FetchEventFailedState extends EventState {}
