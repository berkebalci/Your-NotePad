import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker_app_firebase/screens/HomeScreen.dart';
import 'package:time_tracker_app_firebase/screens/LoginScreen.dart';

//Providers for Firebase operations:
/*
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final authStateChangesProvider = StreamProvider(
  (ref) {
    return ref.watch(firebaseAuthProvider).authStateChanges();
  },
);*/

Future main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Bu satır ile firebase server'i bağlantısı kuruluyor
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: StreamBuilder(
          //stream parametresinde değişiklik olduğunda StreamBuilder rebuild oluyor ve
          //içinde olan kodlar yeniden çalışıyor.
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("StreamBuilder if");
              return HomeScreen();
            } else {
              print("StreamBuilder else");
              return LoginScreen();
            }
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
