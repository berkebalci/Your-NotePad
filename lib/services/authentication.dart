import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';

class Authentication {
  String email;
  String password;
  String deletepassword = "";
  Authentication({required this.email, required this.password});

  Future sign_in() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static Future sign_out() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<dynamic> sign_up() async {
    try {
      print("sign_up metoduna girildi");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("$e s ve j işte tüm mesele bu");
      return e.code;

      //throw FirebaseAuthException(code: "FirebaseAuthException");
    }
  }

  Future confirmEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future deleteuser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reauthenticateWithCredential(
            EmailAuthProvider.credential(email: email, password: password));
        await user.delete();
      } else {
        throw FirebaseAuthException(code: "invalid-credential");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
