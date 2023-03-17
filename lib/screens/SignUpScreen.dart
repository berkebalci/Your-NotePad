import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/services/Authentication/authentication.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';

late var userpasw;

class SignUpScreen extends StatefulWidget {
  final VoidCallback OnClickedSignUp;
  SignUpScreen({super.key, required this.OnClickedSignUp});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isPasswordvisible = false;
  TextEditingController? emailtextController;
  TextEditingController? passwtextController;
  
  @override
  void initState() {
    super.initState();
    emailtextController = TextEditingController();
    passwtextController = TextEditingController();
  }

  @override
  void dispose() {
    emailtextController!.clear();
    passwtextController!.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.OnClickedSignUp();
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
          centerTitle: true,
          title: Text("SignUp Screen")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              controller: emailtextController,
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
              controller: passwtextController,
              obscureText: !isPasswordvisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordvisible
                        ? Icons.visibility_off_sharp
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        isPasswordvisible = !isPasswordvisible;
                      });
                    },
                  ),
                  labelText: "Write your Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                var object = Authentication(
                    email: emailtextController!.text,
                    password: passwtextController!.text);

                try {
                  var result = await object.sign_up();

                  if (result == "email-already-in-use" ||
                      result == "invalid-email") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Utils.showAlertDialog(
                            context, "email-already-in-use or invalid email",
                            title: "Error");
                      },
                    ); 
                  }

                  Utils.showSnackBar(
                      "Please confirm your email via the button above");
                  userpasw = passwtextController!.text;
                } on FirebaseAuthException catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.forward_sharp),
              label: Text("Sign Up"),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    children: [
                  TextSpan(
                    text: "Already have an account?",
                  ),
                  TextSpan(
                      text: "Login Here",
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.OnClickedSignUp,
                      style: TextStyle(decoration: TextDecoration.underline))
                ]))
          ],
        ),
      )),
    );
  }

  get userpw {
    return userpasw;
  }
}
