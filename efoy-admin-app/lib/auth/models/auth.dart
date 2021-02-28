import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class AuthData extends Equatable {
  final String email;
  final String password;
  AuthData({@required this.email, @required this.password});

  @override
  // TODO: implement props
  List<Object> get props => [email, password];

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      email: json['email'],
      password: json['password'],
    );
  }

  static Map<String, dynamic> toJson(AuthData authData) {
    return <String, dynamic>{
      'email': authData.email,
      'password': authData.password,
    };
  }
}
