import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnrolledStudentsScreens extends StatefulWidget {
  final String subjectName;

  EnrolledStudentsScreens({required this.subjectName});

  @override
  _EnrolledStudentsScreenState createState() => _EnrolledStudentsScreenState();
}

class _EnrolledStudentsScreenState extends State<EnrolledStudentsScreens> {
  late Stream<QuerySnapshot> _enrolledStudentsStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    // Replace with the subject name you want to retrieve

    FirebaseFirestore.instance
        .collection('subject_allocation')
        .doc(widget.subjectName)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        List<dynamic> enrolledStudents = docSnapshot.data()!['students'];
        print(enrolledStudents);
      } else {
        print('No allocation found for subject ${widget.subjectName}');
      }
    }).catchError((error) => print('Failed to get allocation: $error'));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName + ' Students'),
        actions: [Icon(Icons.search)],
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
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('None of the students are enrolled'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              String StudentName = snapshot.data!.docs[index]['studentName'];

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.002),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(StudentName),
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
