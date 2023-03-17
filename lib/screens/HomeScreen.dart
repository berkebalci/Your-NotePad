import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/main.dart';
import 'package:time_tracker_app_firebase/screens/AddingNoteScreen.dart';
import 'package:time_tracker_app_firebase/services/Authentication/authentication.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/FireStoreOperations.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user;
  late var isCollectionExists = false;
  @override
  void initState() {
    //currentUser bir getter metodu
    checkisCollectionExists();
    setState(() {});
    //Kullanicinin hiç notu yoksa bir yazı çıkacak varsa notlar gözükecek.
    super.initState();
  }

  @override
  checkisCollectionExists() async {
    user = FirebaseAuth.instance.currentUser;
    var FireStoreobject = FireStoreOperations();
    bool response = await FireStoreobject.isThisUsersFirstNote(user!.uid);
    setState(() {
      isCollectionExists = response;
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("$user");
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () async {
                await Authentication.sign_out(); //User Logout işlemi.
              },
              child: Text("Sign Out")),
          Text("HomeScreen"),
        ],
      )),
      body: isCollectionExists
          ? ListView.separated( //TODO: Buraya FireStore'dan read özelliği gelmesi lazım
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(15),
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 10,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not", style: TextStyle(fontSize: 30)),
                      ],
                    ),
                    trailing: Icon(Icons.forward),
                    onTap: () async {
                      //TODO: FireStore Read ve ayrıca bir container gerekiyor
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                );
              },
            )
          : Center(
              child: Text("There is nothing here"),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddingNoteScreen(isCollectionExists: sendCollectionExists,);
              },
            ));
          },
          child: Icon(
            Icons.add,
            size: 30,
          )),
    );
  }

  get sendCollectionExists{
    return  isCollectionExists;
  }
}
