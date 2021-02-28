import 'package:flutter/cupertino.dart';
import 'package:hotels/auth/data_provider/auth_provider.dart';
import 'package:hotels/auth/models/auth.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  AuthRepository({@required this.dataProvider});

  Future<TempAuthState> checkAuth(AuthData authData) async {
    return await dataProvider.checkAuth(authData);
  }
}
