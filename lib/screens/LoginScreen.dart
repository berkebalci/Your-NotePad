//This class is testing for Firebase operations
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker_app_firebase/screens/ForgotPasswordScreen.dart';
import 'package:time_tracker_app_firebase/services/Authentication/authentication.dart';
/*
final usernamecontrollerProvider = StateProvider((ref) {
  return "";
});
final passwcontrollerProvider = StateProvider(
  (ref) => "",
);*/

class LoginScreen extends StatefulWidget {
  final VoidCallback
      OnclickedSignUp; //Hem checklogin hem de checkemailverified callbackleri gelcek
  const LoginScreen({super.key, required this.OnclickedSignUp});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwController = TextEditingController();
  bool isPswvisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  obscureText: !isPswvisible,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isPswvisible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isPswvisible = !isPswvisible;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  controller: passwController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text("Sign In"),
                      onPressed: () async {
                        var Authobject = Authentication(
                            email: emailController.text,
                            password: passwController.text);
                        await Authobject.sign_in();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                          children: [
                            TextSpan(text: "Don't have an Account?"),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.OnclickedSignUp
                                //SignUp'a bastığımız zaman AuthenticationWidget'daki isLogin'e bakılıyor  ,
                                ,
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                                text: "SignUp")
                          ])),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 20),
                          children: [
                        TextSpan(
                          text: "Forgot your password?",
                        ),
                        TextSpan(
                            text: "Reset your pasword",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgotPswScreen(),
                                ));
                              })
                      ]))
                ])
              ]),
        ),
      ),
    );
  }
}
