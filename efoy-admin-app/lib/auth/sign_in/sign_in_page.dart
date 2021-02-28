import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels/auth/bloc/auth_bloc.dart';
import 'package:hotels/auth/bloc/auth_event.dart';
import 'package:hotels/auth/bloc/auth_state.dart';
import 'package:hotels/auth/models/auth.dart';
import 'package:hotels/screens/home/home_screen.dart';

class SignInPage extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // print(state is InitialAuthState);
            if (state is InitialAuthState || state is AuthFailed) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 150,
                        /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: FlutterLogo(
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Password'),
                    ),
                  ),
                  state is AuthFailed
                      ? Padding(
                          padding: EdgeInsets.all(
                            10,
                          ),
                          child: Text(
                            '${state.error}',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),

                  TextButton(
                    onPressed: () {
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      //todo show circular spinner if user logging in
                      //todo show button if the user data is not correct
                      //todo send to home page if the user data is correct
                      //todo save the info in shared preferences
                      onPressed: () {
                        var email = _emailController.value.text;
                        String password = _passwordController.value.text;
                        if (email != '' && password != '') {
                          BlocProvider.of<AuthBloc>(context).add(SendAuthData(
                              authData:
                                  AuthData(email: email, password: password)));
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 100,
                  ),
                  Text('New User? Create Account'),
                ],
              );
            } else if (state is AuthSuccess) {
              // print(state.authState.role);
              try {
                // final box = GetStorage();
                // box.read('authToken');
                //send the AuthToken with every request
              } catch (err) {
                throw Exception(err);
              }

              return state.authState.role == 'HOTEL'
                  ? HomeScreen()
                  : Text(
                      'Admin Page',
                    );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height - 200,
                width: double.infinity,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(
                        strokeWidth: 18,
                        // backgroundColor: Colors.red,
                      ),
                    ),
                    Text(
                      'Logging In...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
