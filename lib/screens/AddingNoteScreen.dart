import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';

class AddingNoteScreen extends StatefulWidget {
  final VoidCallback isCollectionExists; //isCollection exists döndürülecek
  AddingNoteScreen({super.key,required this.isCollectionExists});

  @override
  State<AddingNoteScreen> createState() => _AddingNoteScreenState();
}

class _AddingNoteScreenState extends State<AddingNoteScreen> {
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
    titleController!.clear();
    contentController!.clear();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Title ",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 60,
          ),
          TextField(
            controller: contentController,
            decoration: InputDecoration(
                label:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Content",
                    style: TextStyle(fontSize: 25),
                  )
                ]),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              if (contentController!.text != "" &&
                  titleController!.text != "") {
                print("Note added");

                //TODO: Not ekleme kodunu buraya yaz
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
