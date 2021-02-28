import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hotels/event/model/event.dart';


class EventState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventFectchingInProgress extends EventState {}

class EventFetchedSuccess extends EventState {
  final List<Event> events;
  // final bool hasreachedMax;

  EventFetchedSuccess({
    @required this.events,
    // @required this.hasreachedMax,
  });
  @override

  List<Object> get props => [this.events];
}

class EventFetchFailure extends EventState {}
