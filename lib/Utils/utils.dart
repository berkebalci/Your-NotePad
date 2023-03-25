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

  static bottomSheet(
      BuildContext context, String content, VoidCallback onClickedEditButton,
      {Widget? widget}) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        isScrollControlled: true //Bu değeri true yaptığımızda bottom sheetin
        //**yüksekliğini ayarlayacağız.
        ,
        context: context,
        builder: ((context) {
          return DraggableScrollableSheet(
            //Böylece bottom sheet
            expand: false,
            initialChildSize: 0.4,
            maxChildSize: 0.8,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -15,
                        child: Container(
                          width: 60,
                          height: 7,
                          decoration: BoxDecoration(color: Colors.white),
                        )),
                    SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                            ),
                            Text(
                              content,
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]);
            },
          );
        }));
  }

  static defaultOnclickedSnackBarFun() {}
  static defaultOnclickedOk() {}
}
