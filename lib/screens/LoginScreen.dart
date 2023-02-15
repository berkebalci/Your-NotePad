//This class is testing for Firebase operations
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker_app_firebase/services/authentication.dart';
/*
final usernamecontrollerProvider = StateProvider((ref) {
  return "";
});
final passwcontrollerProvider = StateProvider(
  (ref) => "",
);*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen"),)
      ,body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "UserName",
                ),
                controller: emailController),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
              controller: passwController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("Sign In"),
                  onPressed: () {
                    var Authobject = Authentication(
                        email: emailController.text,
                        password: passwController.text);
                    Authobject.sign_in();
                    print("Signing in is succesfful");
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            
          ]),
        ),
      ),
    );
  }
}
