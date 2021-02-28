import 'package:efoy_hotel_management_app/feature/event/bloc/events_event.dart';
import 'package:efoy_hotel_management_app/feature/event/bloc/events_state.dart';
import 'package:efoy_hotel_management_app/feature/event/data/repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventBloc extends Bloc<EventsEvent, EventState> {
  final EventRepository eventRepository;
  EventBloc({@required this.eventRepository})
      : assert(eventRepository != null),
        super(FetchEventingState());

  @override
  Stream<EventState> mapEventToState(EventsEvent event) async* {
    if (event is FetchEvent) {
      yield FetchEventingState();
      try {
        final events = await eventRepository.fetchEvents();
        print('the event is : ${events[0].name}');
        yield FetchEventedState(events: events);
      } catch (e) {
        print('bloc level: $e');
        yield FetchEventFailedState();
      }
    }
  }
}
