import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



//TODO: ScaffoldMessanger widgetini öğren
class Utils {
  static final messangerkey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) {
      return;
    } else {
      var snackbar = SnackBar(content:  Text(text));
      messangerkey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
    }
  }

  static showAlertDialog(BuildContext context, String? content,
      {String title = "Alert"}) {
    if (content == null) {
      return;
    }

    return AlertDialog(
      content: Text(content),
      title: Text(title),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"))
      ],
    );
  }
}
