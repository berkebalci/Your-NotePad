import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/main.dart';
import 'package:time_tracker_app_firebase/screens/AddingNoteScreen.dart';
import 'package:time_tracker_app_firebase/services/Authentication/authentication.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/CrudOperations.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/FireStoreOperations.dart';
import 'package:time_tracker_app_firebase/services/models/Note.dart';
import 'package:time_tracker_app_firebase/widgets/AuthenticationWidget.dart';
import 'package:time_tracker_app_firebase/widgets/NoteEditingWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user;
  late var isCollectionExists = false;
  var crudop = FireStoreCrudOperations();

  List<int> NoteObjects = [1, 2, 3];

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
    print(response);
    bool isEditIconClicked = false;
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
          ? StreamBuilder<dynamic>(
              stream: crudop.readNotes(user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final notes = snapshot.data;
                  print(notes);
                  print(notes.length);
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(15),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      print("itembuilderin içindeyiz");
                      print(notes[index]);

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
                              Text("${notes[index].title}",
                                  style: TextStyle(fontSize: 25)),
                            ],
                          ),
                          subtitle: Expanded(
                            child: Text(
                              "${notes[index].content}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          trailing: Icon(Icons.forward),
                          onTap: () {
                            //Basmada sıkıntı yok
                            print("Notlarin üzerine basildi");
                            Utils.bottomSheet(context, notes[index].title,
                                notes[index].content,notes[index].noteUID);
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
              })
          : Center(
              child: Text("To add new note press ➕"),
            ),
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
      isCollectionExists = true;
    });
  }
}
