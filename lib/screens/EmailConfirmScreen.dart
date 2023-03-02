import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/widgets/ConfirmEmail.dart';

class EmailConfirmScreen extends StatefulWidget {
  final VoidCallback onEmailVerified;
  EmailConfirmScreen({super.key, required this.onEmailVerified});

  @override
  State<EmailConfirmScreen> createState() => _EmailConfirmScreenState();
}

class _EmailConfirmScreenState extends State<EmailConfirmScreen> {
  User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: ElevatedButton(
        child: Icon(Icons.keyboard_backspace_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )),
      body: Center(
          //TODO: Confirm email özelliğini yap
          child: Column(
        children: [
          ElevatedButton.icon(
            label: Text("Send Confirm Email"),
            icon: Icon(Icons.email_rounded),
            onPressed: () {
              Utils.showSnackBar(
                  "Confirmation email has been sent to your email");
            },
          ),
          ElevatedButton.icon(
            onPressed: (() {
              if (currentuser!.emailVerified == true) {
                widget.onEmailVerified();
              } else {
                Utils.showSnackBar("Your email is not confirmed yet");
                
              }
            }),
            label: Text("Click here if you confirmed your email"),
            icon: Icon(Icons.check),
          )
        ],
      )),
    );
  }
}
