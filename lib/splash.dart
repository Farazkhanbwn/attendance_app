import 'dart:async';

import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/admin/admin_view.dart';
import 'package:attendance_app/forget_pass.dart';
import 'package:attendance_app/models/userModel.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/static_values.dart';
import 'package:attendance_app/student/student_view.dart';
import 'package:attendance_app/teacher/teacher_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    checkUserType();
  }

  Future<void> checkUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('UserId');
    String? userType = prefs.getString('userRoll');
    print('UserType is equal to = ${userType.toString()}');
    if (userType != null) {
      StaticValues.roll = userType;
      StaticValues.uid = userid;

      // user type found in shared preferences, navigate to the appropriate screen
      switch (userType) {
        case 'Admin':
          FirebaseFirestore.instance
              .collection('users')
              .doc(StaticValues.uid)
              .get()
              .then((value) {
            setState(() {
              StaticValues.model = UserModel.fromMap(value.data()!);
            });
          });
          Timer(
              const Duration(seconds: 6),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => AdminView())));

          break;
        case 'Teacher':
          FirebaseFirestore.instance
              .collection('users')
              .doc(StaticValues.uid)
              .get()
              .then((value) {
            setState(() {
              StaticValues.model = UserModel.fromMap(value.data()!);
            });
          });
          Timer(
              const Duration(seconds: 6),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => TeacherView())));
          break;
        case 'Student':
          FirebaseFirestore.instance
              .collection('users')
              .doc(StaticValues.uid)
              .get()
              .then((value) {
            setState(() {
              StaticValues.model = UserModel.fromMap(value.data()!);
            });
          });
          Timer(
              const Duration(seconds: 6),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => StudentView())));
          break;
        default:
          // user type not recognized, navigate to the login screen
          Timer(
              const Duration(seconds: 6),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => SignIn())));
      }
    } else {
      Timer(
          const Duration(seconds: 6),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => SignIn())));
    }
  }
  // void initState() {
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 6),
  //       () => Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (BuildContext context) => SignIn())));
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
            child: Text(
          'Hello we are Learning',
          style: TextStyle(
              fontSize: width * 0.06,
              fontWeight: FontWeight.w500,
              color: MyTheme.primaryColor),
        )),
        // child: Lottie.asset('assets/coms.json'),
      ),
    );
  }
}
