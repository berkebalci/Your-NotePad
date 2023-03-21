import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/main.dart';
import 'package:time_tracker_app_firebase/screens/AddingNoteScreen.dart';
import 'package:time_tracker_app_firebase/services/Authentication/authentication.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/CrudOperations.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/FireStoreOperations.dart';
import 'package:time_tracker_app_firebase/services/models/Note.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user;
  late var isCollectionExists = false;
  var crudop = FireStoreCrudOperations();
  late var lengthofquery = 0;
  @override
  void initState() {
    //currentUser bir getter metodu
    checkisCollectionExists();

    setState(() {});
    //Kullanicinin hiç notu yoksa bir yazı çıkacak varsa notlar gözükecek.

    super.initState();
  }

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
      body: StreamBuilder<dynamic>(
          stream: crudop.readNotes(user!.email!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final notes = snapshot.data;
              print(notes);
              print(notes.length);
              return ListView.separated(
                //TODO: Çekilen veri sayisinin düzgün yazılması gerekiyor
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(15),
                itemCount: notes.length,
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
                          Text("${notes[index].title} , ${notes[index].content}",
                              style: TextStyle(fontSize: 30)),
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
              );
            } else if (snapshot.hasError) {
              print("Something went wrong");
            } else {
              return Center(
                child: Text("To add note press +"),
              );
            }
            return CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AddingNoteScreen(
                  iscollectionexists: isCollectionExists,
                  onAddedFirstNote: checkCollectionexists,
                );
              },
            ));
          },
          child: Icon(
            Icons.add,
            size: 30,
          )),
    );
  }

  void checkCollectionexists() {
    setState(() {
      isCollectionExists = !isCollectionExists;
    });
  }
}
