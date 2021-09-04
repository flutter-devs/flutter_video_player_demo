import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_player_demo/Utils/localData.dart';

import 'package:flutter_video_player_demo/splash_screen.dart';

import 'amplifyconfiguration.dart';

void main() {
  Utils.saveBooleanValue('isAuthenticated', false);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;
  bool checkAuthState = false;
  AmplifyAuthCognito auth = new AmplifyAuthCognito();
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    if (!mounted) return;
    auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print('Already configured!');
    }

    try {
      //getUserStatus();
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}
