
import 'package:flutter/material.dart';
import 'package:hotels/event/dataprovider/data_provider.dart';
import 'package:hotels/event/model/model.dart';

class EventRepository {
  final EventDataProvider eventDataProvider;

  EventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  Future<List<Event>> fetchEvents() async {
    return await eventDataProvider.fetchEvents();
  }

  Future<void> addEvent(Event event) async {
    return await eventDataProvider.addEvent(event);
  }

  Future<void> deleteEvent(Event event) async {
    return await eventDataProvider.deleteEvent(event);
  }

  Future<void> editEvent(Event event) async {
    return await eventDataProvider.editEvent(event);
  }
}
