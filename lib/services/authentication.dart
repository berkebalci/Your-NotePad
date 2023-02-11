import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/test.dart';
import 'package:time_tracker_app_firebase/test.dart';

class Authentication {
  String user_name;
  String password;
  Authentication({required this.user_name, required this.password});

  Future sign_in() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user_name, 
      password: password);
  }
}
