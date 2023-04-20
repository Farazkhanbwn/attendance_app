import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MyButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        alignment: Alignment.center,
        width: width * 0.85,
        height: height * 0.06,
        decoration: BoxDecoration(
            //   boxShadow: [
            //   BoxShadow(
            //     color: Colors.blue.withOpacity(0.3),
            //     spreadRadius: 0,
            //     blurRadius: 10,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
            color: Colors.blue,
            borderRadius: BorderRadius.circular(05)),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.045,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
