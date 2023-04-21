import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushbar(BuildContext context, String message) {
  Flushbar(
    // title: 'Title here',
    messageColor: Colors.black54,
    messageSize: 20,
    // messageText: ,
    message: message,
    duration: const Duration(seconds: 3),
    borderRadius: BorderRadius.circular(8.0),
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue.shade400,
    ),
    backgroundGradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 253, 253, 253),
        Color.fromARGB(255, 184, 220, 250)
      ],
      stops: [0.6, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.6),
        blurRadius: 8.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
    margin: EdgeInsets.all(25),
    padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    animationDuration: Duration(milliseconds: 500),
  ).show(context);
}
