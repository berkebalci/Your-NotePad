/*import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';
import 'package:time_tracker_app_firebase/screens/EditingNote.dart';

class NoteEditingWidget extends StatefulWidget {
  String content;
  NoteEditingWidget({super.key, required this.content});

  @override
  State<NoteEditingWidget> createState() => _NoteEditingWidgetState();
}

class _NoteEditingWidgetState extends State<NoteEditingWidget> {
  late TextEditingController contentcontroller;
  @override
  void initState() {
    // TODO: implement initState
    contentcontroller = TextEditingController(text: widget.content);
    super.initState();
  }

  @override
  void dispose() {
    contentcontroller.dispose();
    super.dispose();
  }

  bool isClickedonEditIcon = false;
  @override
  Widget build(BuildContext context) {
    print("NoteEditing");
    return isClickedonEditIcon
        ?  EditingNoteScreen():
        Utils.bottomSheet(context, widget.content, isClickedonEdit);
        
  }

  void isClickedonEdit() {
    setState(() {
      isClickedonEditIcon = !isClickedonEditIcon;
    });
  }
}
*/

//TODO: Update ve Delete işlemleri bittikten sonra Security Rules'i düzenle
