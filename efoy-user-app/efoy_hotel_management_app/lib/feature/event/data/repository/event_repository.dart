import 'package:efoy_hotel_management_app/feature/event/data/dataprovider/event_data_provider.dart';
import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';
import 'package:flutter/material.dart';

class EventRepository {
  final EventDataProvider eventDataProvider;

  EventRepository({@required this.eventDataProvider})
      : assert(eventDataProvider != null);

  Future<List<Event>> fetchEvents() async {
    return await eventDataProvider.fetchEvents();
  }
}
