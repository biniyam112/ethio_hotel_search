import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hotels/auth/models/auth.dart';
import 'package:http/http.dart' as http;

class AuthDataProvider {
  final String _baseUrl = 'http://10.0.2.2:3000/api';
  final http.Client httpClient;

  AuthDataProvider({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<TempAuthState> checkAuth(AuthData authData) async {
    http.Response response = await this.httpClient.post(
          Uri.http('10.0.2.2:3000', '/api/auth/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': authData.email,
            'password': authData.password,
          }),
        );

    if (response.statusCode == 200) {
      final info = jsonDecode(response.body)['info']['type'];
      final authToken = jsonDecode(response.body)['token'];

      try {
        final box = GetStorage();
        box.write("authToken", authToken);
        print('Token saved');
      } catch (err) {
        throw Exception(err);
      }
      return TempAuthState(isAuthorized: true, token: authToken, role: info);
    }
    return TempAuthState(isAuthorized: false);
  }
}

class TempAuthState {
  final String token;
  bool isAuthorized = false;
  String role = 'HOTEL';
  TempAuthState({this.token, @required this.isAuthorized, this.role});
}
