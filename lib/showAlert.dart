import 'package:attendance_app/Theme.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(
            // backgroundColor: MyTheme.blue,
            // color: MyTheme.primaryColor,
            ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Loading",
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
