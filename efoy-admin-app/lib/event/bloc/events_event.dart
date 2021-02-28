import 'package:hotels/event/model/event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchEvent extends EventsEvent {
  List<Object> get props => [];
}

class CreateEvent extends EventsEvent {
  final Event event;

  CreateEvent({@required this.event});

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventsEvent {
  final Event event;

  DeleteEvent({@required this.event});

  @override
  List<Object> get props => [event];
}

class EditEvent extends EventsEvent {
  final Event event;

  EditEvent({@required this.event});

  @override
  List<Object> get props => [event];
}
