import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback OnClickedSignUp;
  SignUpScreen({super.key,required this.OnClickedSignUp});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailtextController = TextEditingController();
  final _passwtextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
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
          TextField()
        ],
      )),
    );
  }
}
