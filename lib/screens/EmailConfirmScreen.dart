import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/services/authentication.dart';
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
          print("Sj");
          Utils.showAlertDialog(
            context,
            "You are about to cancel siging up.Your informations will be deleted",
            title: "Are you sure?",
            onClickedOk: () async {
              await FirebaseAuth.instance.currentUser!.delete();
            },
          );
        },
      )),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            label: Text("Send Confirm Email"),
            icon: Icon(Icons.email_rounded),
            onPressed: () async {
              try {
                await currentuser!.sendEmailVerification();
                Utils.showSnackBar(
                    "Confirmation email has been sent to your email");
              } on FirebaseAuthException catch (e) {
                print(e);
              }
            },
          ),
          /*ElevatedButton.icon(
            onPressed: (() async {
              print("$currentuser");
              await currentuser!.reload();
              print("${currentuser!.emailVerified}");
              if (currentuser!.emailVerified == true) {
                setState(() {
                  widget.onEmailVerified();
                });
                //TODO: SignUp has completed yazısını düzelt
              } else {
                Utils.showSnackBar(
                  "Email is not confirmed yet",
                  actiontext: "Resent",
                  onClickedSnackBar: () async {
                    try {
                      currentuser!.sendEmailVerification();
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    }
                  },
                );
              }
            }),
            label: Text("Click here if you confirmed your email"),
            icon: Icon(Icons.check),
          )*/
        ],
      )),
    );
  }
}
