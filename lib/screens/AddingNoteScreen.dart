import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/CrudOperations.dart';

class AddingNoteScreen extends StatefulWidget {
  final bool iscollectionexists; //isCollection exists döndürülecek
  final VoidCallback onAddedFirstNote;
  AddingNoteScreen(
      {super.key,
      required this.iscollectionexists,
      required this.onAddedFirstNote});

  @override
  State<AddingNoteScreen> createState() => _AddingNoteScreenState();
}

class _AddingNoteScreenState extends State<AddingNoteScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController!.dispose();
    contentController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Add a Note")]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            textAlign: TextAlign.center,
            controller: titleController,
            decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(
            height: 60,
          ),
          TextField(
            maxLines:  null, //textfieldin asagi genislemesini sagliyor
            controller: contentController,
            decoration: InputDecoration(
                labelText: "Your Note",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (contentController!.text != "" &&
                  titleController!.text != "") {
                var object = FireStoreCrudOperations();

                await object
                    .createNote(
                  user!.uid,
                  titleController!.text,
                  contentController!.text,
                )
                    .catchError(() {
                  Utils.showSnackBar("Something went wrong :(");
                });
                titleController!.clear();
                contentController!.clear();
                widget.onAddedFirstNote();
                Utils.showSnackBar("Note has been added successfuly");
              } else {
                Utils.showSnackBar("Please fill in all the fields ");
              }
            },
            child: Text("Add Note"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ))),
          )
        ]),
      ),
    );
  }
}
