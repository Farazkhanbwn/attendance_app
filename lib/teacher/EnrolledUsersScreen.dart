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
        .collection('subject_allocations')
        .doc(widget.subjectName)
        .snapshots()
        .map((snapshot) => snapshot.get('students').cast<String>());
    // getStudentIds();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrolled Students'),
        actions: [
          Center(
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                width: width * 0.1,
                height: height * 0.02,
                child: const Text(
                  'scan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
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
                trailing: const Text('pending'),
              ));
            },
          );
        },
      ),
    );
  }
}
