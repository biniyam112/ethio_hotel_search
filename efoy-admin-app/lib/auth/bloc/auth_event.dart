import 'package:equatable/equatable.dart';
import 'package:hotels/auth/models/auth.dart';

class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendAuthData extends AuthEvent {
  final AuthData authData;
  SendAuthData({this.authData});

  @override
  List<Object> get props => [authData];
}
