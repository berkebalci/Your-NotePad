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

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
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
