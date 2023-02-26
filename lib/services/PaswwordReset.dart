import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PasswReset {
  String email;
  PasswReset({required this.email});

  Future reset_password() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  
  }
}
