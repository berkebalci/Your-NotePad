import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print("$user");
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
              Text("${user!.email} has logged in"),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut(); //User Logout işlemi.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
                  },
                  child: Text("Sign Out")),
            ],
          ),
        ));
  }
}
