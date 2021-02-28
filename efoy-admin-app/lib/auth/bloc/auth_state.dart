//sending auth
//auth success
//auth failed
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hotels/auth/data_provider/auth_provider.dart';

class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialAuthState extends AuthState {}

class SendingAuthData extends AuthState {}

class AuthSuccess extends AuthState {
  final TempAuthState authState;
  AuthSuccess({@required this.authState});

  //it will be received from the fetch operations in the sendinf client
}

class AuthFailed extends AuthState {
  final String error;
  AuthFailed({@required this.error});

  @override
  List<Object> get props => [error];
}
