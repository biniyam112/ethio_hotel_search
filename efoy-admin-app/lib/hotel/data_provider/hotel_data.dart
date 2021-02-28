import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:hotels/hotel/models/hotel.dart';
import 'package:path/path.dart' as path;

class HotelDataProvider {
  final http.Client httpClient;
  final _baseUrl = "http://10.0.2.2:3000/api";

  HotelDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Hotel> createHotel(
      {Hotel hotel, String password, String email}) async {
    File imageFile = hotel.images[0];

    // Path path=Path();
    print("we are here");
    // try {
    // final response = await httpClient.post("$_baseUrl/hotels",
    //     headers: <String, String>{"Content-type": "multipart/form-data"},
    //     body: jsonEncode(<String, dynamic>{
    //       'name': hotel.name,
    //       'location': hotel.location,
    //       'description': hotel.description,
    //       'stars': hotel.stars,
    //       'images': http.MultipartFile(
    //         'images',
    //         imageFile.readAsBytes().asStream(),
    //         imageFile.lengthSync(),
    //       )
    //     }));

    // if (response.statusCode == 200) {
    //   print("response object");
    //   return Hotel.fromJson(jsonDecode(response.body));
    // } else {
    //   print(response.body);
    //   // throw Exception("Failed to create hotel.");
    // }
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://10.0.2.2:3000/api/hotels"));

    Map<String, String> headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile.fromBytes(
      'images',
      imageFile.readAsBytesSync(),
      filename: path.basename(imageFile.path),
    ));
    request.headers.addAll(headers);
    request.fields.addAll({
      'name': hotel.name,
      'location': hotel.location,
      'description': hotel.description,
      "stars": hotel.stars.toString(),
      "password": password,
      "email": email,
    });
    print("request: " + request.toString());
    var responseStream = await request.send();
    // print("This is response:"+response.toString());
    final responseString = await responseStream.stream.bytesToString();
    if (responseStream.statusCode == 200) {
      print("response object");
      // var response = await http.Response.fromStream(responseStream);

      return Hotel.fromJson(jsonDecode(responseString));
    } else {
      print(responseString);
      print(responseStream.stream);
      return null;
    }
    // return res.statusCode;
    // } catch (e) {
    // print("error happened");
    // print(e);
    // throw Exception(e);
    // }

    // print(hotel);
  }

  Future<List<Hotel>> getHotels() async {
    // try {
    final response = await httpClient.get('$_baseUrl/hotels');
    if (response.statusCode == 200) {
      print(response.body);
      final hotels = jsonDecode(response.body)["hotels"] as List;
      return hotels.map((hotel) => Hotel.fromJson(hotel)).toList();
    } else {
      print("=====> here is the error");
      return null;
    }
    // } catch (e) {
    // print(e);
    // throw Exception("failed to load hotels");
    // }
  }

  Future<Hotel> getHotel(String id) async {
    final response = await httpClient.get('$_baseUrl/hotels/$id');
    if (response.statusCode == 200) {
      final hotel = json.decode(response.body);

      return Hotel.fromJson(hotel);
    } else {
      throw Exception("Failed to load hotel");
    }
  }

  Future<void> updateHotel(Hotel hotel) async {
    File imageFile = hotel.images[0];

    // Path path=Path();
    print(hotel.name);
    print("we are here");
    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse("http://localhost:3000/api/hotels/${hotel.id}"));

      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile.fromBytes(
        'images',
        imageFile.readAsBytesSync(),
        filename: path.basename(imageFile.path),
      ));
      request.headers.addAll(headers);
      request.fields.addAll({
        'name': hotel.name,
        'location': hotel.location,
        'description': hotel.description,
        "stars": hotel.stars.toString(),
      });
      print("request: " + request.toString());
      var responseStream = await request.send();

      final responseString = await responseStream.stream.bytesToString();
      if (responseStream.statusCode == 200) {
        print("response object");
      } else {
        print(responseString);
      }
    } catch (e) {
      print("error happened");
      print(e);
      throw Exception(e);
    }
  }

  Future<void> deleteHotel(String id) async {
    print(id);
    try {
      final response = await httpClient.delete("$_baseUrl/hotels/$id",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      if (response.statusCode != 204) {
        print(response.body);
      }
    } catch (e) {
      print('hotel deletion error $e');
      throw Exception("failed to delete hotels");
    }
  }
}
