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
  late Timer timer;

  @override 
  void initState() {
    print("initState'e girdi");
    super.initState(); 
    isEmailVerified = currentuser!.emailVerified;
    if (currentuser != null) {
       print("current is not null");
       timer = Timer.periodic(Duration(seconds: 3),(timer) =>checkemailStatus() ,);
    } 
    else {
      print("Current user is null");
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
}
  Future checkemailStatus() async{
     if (currentuser!.emailVerified == true) {
          print("Sj");
          timer.cancel();
        }
        await FirebaseAuth.instance.currentUser!.reload(); //Reload ederek Firebasedeki son değişiklikleri alıyoruz.
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;   
        });
       
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
