import 'package:flutter/material.dart';
import 'package:time_tracker_app_firebase/Utils/utils.dart';

class NoteEditingWidget extends StatefulWidget {
  BuildContext context;
  String content;
  NoteEditingWidget({super.key, required this.context, required this.content});

  @override
  State<NoteEditingWidget> createState() => _NoteEditingWidgetState();
}

class _NoteEditingWidgetState extends State<NoteEditingWidget> {
  bool isClickedonEditIcon = false;
  @override
  Widget build(BuildContext context) {
    return isClickedonEditIcon
        ? Utils.bottomSheet(widget.context, widget.content, isClickedonEdit,widget: TextField())
        : Utils.bottomSheet(widget.context, widget.content,isClickedonEdit);
  }

  void isClickedonEdit() {
    isClickedonEditIcon = !isClickedonEditIcon;
  }
}
