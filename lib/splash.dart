import 'dart:async';

import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/forget_pass.dart';
import 'package:attendance_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => SignIn())));
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        // child: Center(
        //     child: Text(
        //   'Hello we are Learning',
        //   style: TextStyle(
        //       fontSize: width * 0.06,
        //       fontWeight: FontWeight.w500,
        //       color: MyTheme.primaryColor),
        // )),
        child: Lottie.asset('assets/coms.json'),
      ),
    );
  }
}
