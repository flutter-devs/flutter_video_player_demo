import 'package:flutter/material.dart';

import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_video_player_demo/services/authService.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<String> _onLogin(BuildContext context, LoginData data) async {
    List<String> username = data.name.split('@');
    print("Username -> " + username[0]);
    AuthService().signIn(username[0], data.password, userSignedIn, context);
    return data.toString();
  }

  Future<String> _onSignup(BuildContext context, LoginData data) async {
    List<String> username = data.name.split('@');
    print("Username -> " + username[0]);
    AuthService().signUp(data.name, username[0], data.password, context);
    return '';
  }

  String username = '', password = '';
  var userSignedIn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FlutterLogin(
                onLogin: (LoginData data) => _onLogin(context, data),
                onRecoverPassword: (String pswd) {
                  return null;
                },
                onSignup: (LoginData data) => _onSignup(context, data))));
  }
}
