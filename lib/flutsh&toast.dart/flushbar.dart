import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushbar(BuildContext context, String message) {
  Flushbar(
    maxWidth: MediaQuery.of(context).size.width * 0.8,
    backgroundColor: Colors.black,
    flushbarPosition: FlushbarPosition.TOP,
    margin: const EdgeInsets.all(3),
    message: message,
    icon: const Icon(
      Icons.check_circle_outline,
      size: 28.0,
      color: Colors.black54,
    ),
    duration: const Duration(seconds: 2),
    leftBarIndicatorColor: Colors.grey,
  ).show(context);
}
