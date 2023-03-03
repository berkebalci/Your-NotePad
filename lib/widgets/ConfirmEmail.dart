import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/screens/EmailConfirmScreen.dart';
import 'package:time_tracker_app_firebase/screens/HomeScreen.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';

class EmailVerWidget extends StatefulWidget {
  const EmailVerWidget({super.key});

  @override
  State<EmailVerWidget> createState() => _EmailVerWidgetState();
}

class _EmailVerWidgetState extends State<EmailVerWidget> {
  var isEmailVerified = false;
  User? currentuser = FirebaseAuth.instance.currentUser;
  late Timer _timer;
  
  @override //TODO: Bu widget'daki setstate or markneeds build sorununu çöz!
  void initState() {
    super.initState();
    isEmailVerified = currentuser!.emailVerified;
    if (currentuser != null) {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        if (currentuser!.emailVerified == true) {
          timer.cancel();
          }
        await FirebaseAuth.instance.currentUser!.reload();
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? HomeScreen()
        : EmailConfirmScreen(
            onEmailVerified: setemailVerf,
          );
  }

  void setemailVerf() {
    setState(() {
      isEmailVerified = !isEmailVerified;
    });
  }
}
