import 'package:attendance_app/chatgpt/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolledStudentsScreen extends StatefulWidget {
  final String subjectName;

  EnrolledStudentsScreen({required this.subjectName});

  @override
  _EnrolledStudentsScreenState createState() => _EnrolledStudentsScreenState();
}

class _EnrolledStudentsScreenState extends State<EnrolledStudentsScreen> {
  late Stream<QuerySnapshot> _enrolledStudentsStream;

  @override
  void initState() {
    super.initState();
    _enrolledStudentsStream = FirebaseFirestore.instance
        .collection('subject_allocations')
        .where('subjectNamesList', arrayContains: widget.subjectName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName + ' Students'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _enrolledStudentsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ShimmerEffect(
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.blueGrey,
                ),
                duration: Duration(seconds: 2),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                width: 200,
                height: 50,
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('None of the students are enrolled'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              String userEmail = snapshot.data!.docs[index]['userEmail'];

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.002),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(userEmail),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
