import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/main.dart';
import 'package:time_tracker_app_firebase/services/authentication.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user =
        FirebaseAuth.instance.currentUser; //currentUser bir getter metodu

    late var useremail;
    if (user?.email != null) {
      useremail = user!.email!;
    }

    //TODO: üst satırdan dolayı çıkan hatayı düzelt
    //print("$user");
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HomeScreen"),
          ],
        )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("User has logged in $useremail"),
              ElevatedButton(
                  onPressed: () async {
                    await Authentication.sign_out(); //User Logout işlemi.
                    Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
                  },
                  child: Text("Sign Out")),
            ],
          ),
        ));
  }
}
