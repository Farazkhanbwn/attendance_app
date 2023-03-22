import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TeacherDisplay extends StatefulWidget {
  const TeacherDisplay({super.key});

  @override
  State<TeacherDisplay> createState() => _TeacherDisplayState();
}

class _TeacherDisplayState extends State<TeacherDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Display'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
    );
  }
}
