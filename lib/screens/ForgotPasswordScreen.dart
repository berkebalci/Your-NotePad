import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/services/Authentication/PaswwordReset.dart';

class ForgotPswScreen extends StatefulWidget {
  const ForgotPswScreen({super.key});

  @override
  State<ForgotPswScreen> createState() => _ForgotPswScreenState();
}

class _ForgotPswScreenState extends State<ForgotPswScreen> {
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password Reset",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
                'https://www.gstatic.com/devrel-devsite/prod/vb06f043a05fab8044a3ccc5b2a77caba73848fbe764e2f874782b493081fa838/firebase/images/touchicon-180.png'),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  var object = PasswReset(email: emailcontroller.text);
                  try {
                    await object.reset_password();
                    Utils.showSnackBar(
                        "Password Link has been send to the given email");
                    Navigator.of(context).pop();
                  } on FirebaseAuthException catch (e) {
                    switch (e.code) {
                      case "invalid-email":
                        showDialog(
                          //TODO: showDialoglara Animation paketi ile animasyon ekle
                          context: context,
                          builder: (context) {
                            return Utils.showAlertDialog(
                                context, "invalid-email please try again",
                                title: "Error");
                          },
                        );
                        break;
                      case "user-not-found":
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Utils.showAlertDialog(
                                context, "Email couldn't be found",
                                title: "Error");
                          },
                        );
                    }
                  }
                },
                icon: Icon(Icons.email_outlined),
                label: Text("Send reset email"))
          ],
        ),
      ),
    );
  }
}
