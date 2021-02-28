import 'package:hotels/event/repository/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events_event.dart';
import 'events_state.dart';

class EventBloc extends Bloc<EventsEvent, EventState> {
  final EventRepository eventRepository;
  EventBloc({@required this.eventRepository})
      : assert(eventRepository != null),
        super(EventFectchingInProgress());

  @override
  Stream<EventState> mapEventToState(EventsEvent event) async* {
    if (event is FetchEvent) {
      yield EventFectchingInProgress();
      try {
         print("=======fetching");
        final events = await eventRepository.fetchEvents();
        print("=======fetched");
        print('the event is : ${events[0].name}');
        yield EventFetchedSuccess(events: events);
      } catch (e) {
        print('bloc level: $e');
        yield EventFetchFailure();
      }
    }
    if (event is CreateEvent) {
      try {
        await eventRepository.addEvent(event.event);
        final events = await eventRepository.fetchEvents();
        print(events.length);
        yield EventFetchedSuccess(events: events);
      } catch (e) {
        print('$e is the fetch bloc error');
        yield EventFetchFailure();
      }
    }
    if (event is DeleteEvent) {
      try {
        await eventRepository.deleteEvent(event.event);
        final events = await eventRepository.fetchEvents();
        yield EventFetchedSuccess(events: events);
      } catch (e) {
        print('$e is the delete/fetch bloc error');
        yield EventFetchFailure();
      }
    }
    if (event is EditEvent) {
      try {
        await eventRepository.editEvent(event.event);
        final events = await eventRepository.fetchEvents();
        yield EventFetchedSuccess(events: events);
      } catch (e) {
        print('$e is the edit/fetch bloc error');
        yield EventFetchFailure();
      }
    }
  }
}
