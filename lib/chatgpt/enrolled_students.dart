import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolledStudentsScreen extends StatefulWidget {
  final String subjectName;

  const EnrolledStudentsScreen({required this.subjectName});

  @override
  _EnrolledStudentsScreenState createState() => _EnrolledStudentsScreenState();
}

class _EnrolledStudentsScreenState extends State<EnrolledStudentsScreen> {
  Stream<List<String>>? _enrolledStudentsStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    _enrolledStudentsStream = FirebaseFirestore.instance
        .collection('subject_allocation')
        .doc(widget.subjectName)
        .snapshots()
        .map((snapshot) => snapshot.get('students').cast<String>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enrolled Students'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<String>>(
        stream: _enrolledStudentsStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('None of the students are enrolled'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final studentname = snapshot.data![index];
              return Card(
                  child: ListTile(
                title: Text(studentname),
                // trailing: Text('Mark'),
              ));
            },
          );
        },
      ),
    );
  }
}
