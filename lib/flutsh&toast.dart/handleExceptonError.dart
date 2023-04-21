import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void handleFirebaseAuthException(
    BuildContext context, FirebaseAuthException error) {
  final String errorMessage;
  switch (error.code) {
    case "invalid-email":
      errorMessage = "invalid-email";
      break;
    case "wrong-password":
      errorMessage = "wrong-password";
      break;
    case "user-not-found":
      errorMessage = "user-not-found";
      break;
    case "user-disabled":
      errorMessage = "user-disabled";
      break;
    case "too-many-requests":
      errorMessage = "too-many-requests";
      break;
    case "operation-not-allowed":
      errorMessage = "operation-not-allowed";
      break;
    default:
      errorMessage = "An error occured";
  }
  showFlushbar(context, errorMessage);
}
