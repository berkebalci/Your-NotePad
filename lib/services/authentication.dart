import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';

class Authentication {
  String email;
  String password;
  Authentication({required this.email, required this.password});

  Future sign_in() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password);
      
  }
}
