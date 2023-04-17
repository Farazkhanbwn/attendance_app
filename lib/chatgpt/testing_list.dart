import 'package:flutter/material.dart';

class testList extends StatefulWidget {
  const testList({super.key});

  @override
  State<testList> createState() => _testListState();
}

class _testListState extends State<testList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: width * 0.5,
          height: height * 0.3,
          color: Colors.amber,
        ),
      ),
    );
  }
}
