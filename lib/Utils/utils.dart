import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static final messangerkey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text,
      {String actiontext = "",
      VoidCallback onClickedSnackBar = defaultOnclickedSnackBarFun}) {
    if (text == null) {
      return;
    }
    if (actiontext == "") {
      var snackbar = SnackBar(
        content: Text(text),
      );
      messangerkey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(snackbar);
    } 
    
    else {
      var snackbar = SnackBar(
        backgroundColor: Color(300),
        content: Text(text),
        action: SnackBarAction(

          textColor: Color(400),
          label: actiontext,
          onPressed: onClickedSnackBar,
        ),
      );
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

  static defaultOnclickedSnackBarFun() {
    print("**");
  }
}
