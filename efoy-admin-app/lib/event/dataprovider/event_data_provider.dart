import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotels/event/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class EventDataProvider {
  final _baseUrl = 'http://10.0.2.2:3000/api';
  final http.Client httpClient;
  EventDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await httpClient.get('$_baseUrl/events');

      if (response.statusCode == 200) {
        print('provider level event: fetching done succesfully');
        final events = jsonDecode(response.body)['data'] as List;
        return events.map((event) => Event.fromJson(event)).toList();
      } else {
        print('provider level: fetching failed');
        throw Exception('failed to fetch events');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Event> addEvent(Event event) async {
    File imageFile = event.imagepath[0];
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse('$_baseUrl/events'));
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          imageFile.readAsBytesSync(),
          filename: path.basename(imageFile.path),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({
        'title': event.name,
        'description': event.description,
      });
      print("request: " + request.toString());
      var responseStream = await request.send();
      final responseString = await responseStream.stream.bytesToString();
      if (responseStream.statusCode == 200) {
        print("response object");

        return Event.fromJson(jsonDecode(responseString));
      } else {
        print(responseString);
      }
    } catch (e) {
      print('$e is the provider error');
      throw Exception(e);
    }
  }

  Future<void> deleteEvent(Event event) async {
    try {
      final http.Response response = await httpClient.delete(
        'http://10.0.2.2:3000/api/events/${event.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode != 204) {
        // throw Exception('Failed to delete course.');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> editEvent(Event event) async {
    File imageFile = event.imagepath[0];
    try {
      print('${event.id}');
      print('${event.name}');
      print('${event.description}');
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://10.0.2.2:3000/api/events/${event.id}'),
      );
      print("event editing *************");
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          imageFile.readAsBytesSync(),
          filename: path.basename(imageFile.path),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({
        'title': event.name,
        'description': event.description,
      });
      print("request: " + request.toString());
      var responseStream = await request.send();
      final responseString = await responseStream.stream.bytesToString();
      print("${responseStream.statusCode} *******");
      if (responseStream.statusCode == 200) {
        print("response object");

        return Event.fromJson(jsonDecode(responseString));
      } else {
        print(responseString);
      }
    } catch (e) {
      print('$e is the provider error');
      throw Exception(e);
    }
  }
}
