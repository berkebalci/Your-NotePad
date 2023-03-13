import 'package:flutter/material.dart';

class AddingNoteScreen extends StatefulWidget {
  const AddingNoteScreen({super.key});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center
          ,children: [
          TextField(
            controller: titleController
            ,decoration: InputDecoration(
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  ,children: [
                    Text("Title ",style: TextStyle(fontSize: 25),),
                  ],
                )
                ,border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(height: 60,),
          TextField(
            controller: contentController,
            decoration: InputDecoration(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Content",style: TextStyle(fontSize: 25),)])
              ,border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),)
        ]),
      ),
    );
  }
}
