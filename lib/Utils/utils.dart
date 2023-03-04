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
    } else {
      var snackbar = SnackBar(
        padding: EdgeInsets.all(8),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(text),
            ),
          ],
        ),
        action: SnackBarAction(
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
      {String title = "Alert", VoidCallback onClickedOk = defaultOnclickedOk}) {
    if (content == null) {
      return;
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(content),
          title: Text(title),
          actions: [ElevatedButton(onPressed: onClickedOk, child: Text("Ok"))],
        );
      },
    );
  }

  static defaultOnclickedSnackBarFun() {}
  static defaultOnclickedOk() {}
}
