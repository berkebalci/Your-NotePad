//This class is testing for Firebase operations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
  final VoidCallback OnclickedSignUp;
  const LoginScreen({super.key, required this.OnclickedSignUp});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwController = TextEditingController();
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, 
        title:Text("Login Screen"),)
      ,body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: "UserName",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    ),

                ),
                controller: emailController),
            SizedBox(
              height: 30,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
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
              height: 25,
            ),
            RichText(
              
              text: TextSpan(
                style: TextStyle(color: Colors.blueAccent,fontSize: 20)
                ,
                children: [
                  TextSpan(text: "Don't have an Account?"),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = widget.OnclickedSignUp 
                    //SignUp'a bastığımız zaman AuthenticationWidget'daki isLogin'e bakılıyor  ,
                    ,style: TextStyle(decoration: TextDecoration.underline)
                    ,text: "SignUp")
                ]))
          ]),
        ),
      ),
    );
  }
}
