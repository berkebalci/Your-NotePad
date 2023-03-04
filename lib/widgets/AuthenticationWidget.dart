import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/screens/HomeScreen.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';

import '../screens/SignUpScreen.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});
  @override
  State<Auth> createState() => _AuthState();
}


class _AuthState extends State<Auth> {
  var isLogin = true;
  @override
  Widget build(BuildContext context) {
    print("build calistirildi");
    return isLogin
        ? LoginScreen(
            OnclickedSignUp: check_login,
          )
        : SignUpScreen(
            OnClickedSignUp: check_login,
          );
  }

  void check_login() {
    setState(() {
      isLogin = !isLogin;
      print("$isLogin value");
    });
  }
}
