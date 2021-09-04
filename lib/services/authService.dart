import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'package:flutter/material.dart';
import 'package:flutter_video_player_demo/home_screen.dart';
import 'package:flutter_video_player_demo/screens/authPage.dart';
import 'package:flutter_video_player_demo/screens/confirmationPage.dart';

class AuthService {
  signUp(email, username, password, context) async {
    try {
      print('11');
      Map<String, String> userAttributes = {'email': email};
      Amplify.Auth.signUp(
              username: username,
              password: password,
              options: CognitoSignUpOptions(userAttributes: userAttributes))
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ConfirmationPage(
                    username: username,
                  ))));
    } catch (e) {
      print("Here @@ -> " + e.toString());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => AuthPage()));
    }
  }

  //Confirm User
  confirmUser(username, otp, context) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: otp);
      if (res.isSignUpComplete) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {}
  }

  //sign In
  signIn(username, password, userSignedIn, context) async {
    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: username, password: password);
      if (res.isSignedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      print(e);
    }
  }
  //signOut

}
