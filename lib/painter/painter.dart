import 'package:attendance_app/Theme.dart';
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  Paint? design, design2, design3, design4, design5;
  Painter() {
    design = Paint()
      ..color = Colors.blue.shade200
      // ..color = MyTheme.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    design2 = Paint()
      ..color = Colors.white12
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    //  design3=Paint()
    // ..color=Colors.blue[200]
    // ..strokeWidth=2
    // ..style=PaintingStyle.fill;
    //  design4=Paint()
    // ..color=Colors.blue[200]
    // ..strokeWidth=2
    // ..style=PaintingStyle.fill;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var height = size.height;
    var width = size.width;
    Path mypath = Path();
    mypath.moveTo(0, 0);
    mypath.quadraticBezierTo(width * 0.5, height, width, height * 0.8);
    mypath.lineTo(width, 0);
    mypath.lineTo(0, 0);
    // mypath.quadraticBezierTo(
    //     width * 0.6, height * 0.1, width * 0.6, height * 0.4);
    // mypath.quadraticBezierTo(
    //     width * 0.85, height * 0.6, width * 0.8, height * 0.5);
    // mypath.quadraticBezierTo(width * 0.85, height * 0.55, width, height * 0.5);
    // // mypath.quadraticBezierTo(width * 0.85, height * 0.65, width, height * 0.6);
    // mypath.lineTo(width, height * 0.0);
    // mypath.lineTo(width * 0.0, height * 0.0);
    mypath.close();
    canvas.drawPath(mypath, design!);
    Path circle = Path();
    canvas.drawCircle(Offset(320, 265), 8, design2!);
    circle.close();
    Path circle2 = Path();
    canvas.drawCircle(Offset(180, 120), 10, design2!);
    circle2.close();
    Path circle3 = Path();
    canvas.drawCircle(Offset(150, 200), 15, design2!);
    circle3.close();
    Path circle4 = Path();
    canvas.drawCircle(Offset(140, 250), 8, design2!);
    circle4.close();
    Path circle6 = Path();
    canvas.drawCircle(Offset(330, 50), 10, design2!);
    circle6.close();
    Path circle7 = Path();
    canvas.drawCircle(Offset(450, 200), 15, design2!);
    circle7.close();
    // Path circle3 = Path();
    // canvas.drawCircle(Offset(340, 170), 25, design2!);
    // circle3.close();
    // Path circle4 = Path();
    // canvas.drawCircle(Offset(100, 170), 25, design2!);
    // circle4.close();
    Path circle5 = Path();
    canvas.drawCircle(Offset(320, 160), 70, design2!);
    circle5.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
