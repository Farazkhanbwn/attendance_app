import 'package:attendance_app/chatgpt/shimmer.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmers Effect'),
        centerTitle: true,
      ),
      body: Column(children: <Widget>[
        ShimmerEffect(
          duration: const Duration(microseconds: 30),
          baseColor: Colors.black,
          highlightColor: Colors.amber,
          width: 300,
          height: 400,
          child: Text('Shimmer Effect'),
        )
      ]),
    );
  }
}
