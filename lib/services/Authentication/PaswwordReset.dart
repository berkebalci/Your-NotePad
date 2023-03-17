import 'package:firebase_auth/firebase_auth.dart';

class PasswReset {
  String email;
  PasswReset({required this.email});

  Future reset_password() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  
  }
}
