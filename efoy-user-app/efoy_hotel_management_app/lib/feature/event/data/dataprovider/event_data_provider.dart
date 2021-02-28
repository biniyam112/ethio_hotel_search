import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:efoy_hotel_management_app/feature/event/data/model/event.dart';
import 'package:http/http.dart' as http;

class EventDataProvider {
  final _baseUrl = 'http://10.0.2.2:3000/api';
  final http.Client httpClient;
  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Event>> fetchEvents() async {
    final response = await httpClient.get('$_baseUrl/events');
    if (response.statusCode == 200) {
      print('provider level event: fetching done succesfully');
      final events = jsonDecode(response.body)['data'] as List;
      return events.map((event) => Event.fromJson(event)).toList();
    } else {
      print('provider level: fetching failed');
      throw Exception('failed to fetch events');
    }
  }
}
