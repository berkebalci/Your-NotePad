import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/services/FireStoreOperations/CrudOperations.dart';

class EditingNoteScreen extends StatefulWidget {
  String title;
  String content;
  String noteUID;
  VoidCallback onClickedEdit;
  EditingNoteScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.noteUID,
      required this.onClickedEdit});

  @override
  State<EditingNoteScreen> createState() => _EditingNoteScreenState();
}

class _EditingNoteScreenState extends State<EditingNoteScreen> {
  late TextEditingController titlecontroller;
  late TextEditingController contentcontroller;
  late String previoustitletext;
  late String previouscontenttext;
  var isConfirmButtonvisible = false;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    titlecontroller = TextEditingController(text: widget.title);
    contentcontroller = TextEditingController(text: widget.content);
    previoustitletext = titlecontroller.text;
    previouscontenttext = contentcontroller.text;
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    contentcontroller.dispose();
    super.dispose();
  }

  void onChanged(String value) {
    if (titlecontroller.text != previouscontenttext) {
      setState(() {
        previoustitletext = titlecontroller.text;
        isConfirmButtonvisible = true;
      });
    } else if (contentcontroller.text != previouscontenttext) {
      setState(() {
        previouscontenttext = contentcontroller.text;
        isConfirmButtonvisible = true;
      });
    } else {
      setState(() {
        print("Else bloguna girildi");
        isConfirmButtonvisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(isConfirmButtonvisible);
    return Scaffold(
      appBar: AppBar(title: Text("Note Editing Screen")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            onChanged: onChanged,
            maxLines: null,
            textAlign: TextAlign.center,
            controller: titlecontroller,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                hintText: "Title"),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
              onChanged: onChanged,
              controller: contentcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Content")),
          ElevatedButton(
              onPressed: isConfirmButtonvisible
                  ? () {
                      try {
                        var object = FireStoreCrudOperations();
                        object.updateNotes(user!.uid, widget.noteUID,
                            titlecontroller.text, contentcontroller.text);
                        Utils.showSnackBar(
                            "Your Note has been edited successfuly");
                        setState(() {
                          previoustitletext = titlecontroller.text;
                          previouscontenttext = contentcontroller.text;
                        });
                      } on FirebaseException catch (e) {
                        Utils.showSnackBar("Something went wrong :(");
                      }
                    }
                  : null,
              child: Text("Confirm Changes"))
        ]),
      ),
    );
  }
}
