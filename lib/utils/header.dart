import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/painter/painter.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  var height, width;
  Header({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: CustomPaint(
              painter: Painter(),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Color(0xff98c4ff), MyTheme.lightblue])),
          ),
          Center(
            child: Container(
              height: height * 0.5,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                shape: BoxShape.circle,
                image: const DecorationImage(
                    image: AssetImage('images/login.png')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
