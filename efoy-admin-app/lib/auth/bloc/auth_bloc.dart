import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/auth/bloc/auth_event.dart';
import 'package:hotels/auth/bloc/auth_state.dart';
import 'package:hotels/auth/data_provider/auth_provider.dart';
import 'package:hotels/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({@required this.repository}) : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SendAuthData) {
      yield SendingAuthData();
      try {
        TempAuthState authState =
            await this.repository.checkAuth(event.authData);
        if (authState.isAuthorized) {
          yield AuthSuccess(authState: authState);
        } else {
          yield AuthFailed(error: 'Incorrect username or password');
        }
      } catch (err) {
        print(err);
        yield AuthFailed(error: 'Error on connection');
      }
    }
  }
}
