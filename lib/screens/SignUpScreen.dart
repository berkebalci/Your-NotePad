import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/services/authentication.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback OnClickedSignUp;
  SignUpScreen({super.key, required this.OnClickedSignUp});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailtextController = TextEditingController();
  final _passwtextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp Screen")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: _emailtextController,
            decoration: InputDecoration(
                labelText: "Write your Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: _passwtextController,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            onPressed: () async{
              var object = Authentication(
                  email: _emailtextController.text,
                  password: _passwtextController.text);
              await object.sign_up();
            },
            icon: Icon(Icons.forward_sharp),
            label: Text("Sign Up"),
          )
        ],
      )),
    );
  }
}
