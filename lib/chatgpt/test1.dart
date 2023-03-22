import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CoursesShow7 extends StatefulWidget {
  @override
  _CoursesShowState createState() => _CoursesShowState();
}

class _CoursesShowState extends State<CoursesShow7> {
  late User? _user;
  late String _currentUserId;
  Stream<QuerySnapshot> _coursesStream = Stream.empty();
  // final teacherName = 'Nazim Khan';
  // late final _courseStream;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _getUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    // final uid = _user!.uid;
    // print('User Current id is = ${uid}');
    if (_user != null) {
      setState(() {
        _currentUserId = _user!.uid;
      });
      final teacherDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('1')
          .collection('Teacher')
          .doc('1yKAK0aEM8szPNfA9YfN')
          // doc()
          .get();
      final teacherName = teacherDoc.data()?['name'];
      _coursesStream = await FirebaseFirestore.instance
          .collection('courses')
          .where('teacherName', isEqualTo: '$teacherName')
          .snapshots();
      // final courseStream = FirebaseFirestore.instance
      //     .collection('courses')
      //     .where('teacherName', isEqualTo: '$teacherName')
      //     .snapshots();
      // print('Course Stream = $courseStream');
      print("teacherName is = ${teacherName}");
      // // print("teacher doc is = ${teacherDoc}");
      print('Course Stream = ${_coursesStream.toString()}');

      // final querySnapshot = await FirebaseFirestore.instance
      //     .collection('courses')
      //     .where('teacherName', isEqualTo: 'Nazim Khan')
      //     .get();
      // if (querySnapshot.docs.isNotEmpty) {
      //   // There is at least one course with the specified teacherName
      //   print('Teacher name matches.');
      // } else {
      //   // There are no courses with the specified teacherName
      //   print('Teacher name does not match.');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _coursesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              print('course stream is = to the following ${_coursesStream}');
              if (snapshot.hasData) {
                final courseDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: courseDocs.length,
                  itemBuilder: (context, index) {
                    final course =
                        courseDocs[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 3),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(course['courseName'] ?? ''),
                          subtitle: StudentList(course['students'] ?? []),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Text('No courses found.'),
              );
            },
          ),
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection('courses')
          //       .where('teacherName', isEqualTo: teacherName)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       // Show a loading indicator while waiting for data
          //       return CircularProgressIndicator();
          //     }
          //     if (snapshot.hasData) {
          //       final courseDocs = snapshot.data!.docs;
          //       if (courseDocs.isEmpty) {
          //         // There are no courses for the teacher with the given name
          //         return Text('No courses found for $teacherName');
          //       } else {
          //         // There are courses for the teacher with the given name
          //         return Text(
          //             'Found ${courseDocs.length} courses for $teacherName');
          //       }
          //     }
          //     // If the snapshot doesn't have data, show an error message
          //     return Text('Error: ${snapshot.error}');
          //   },
          // )
        ],
      ),
    );
  }

  Widget StudentList(List<dynamic> students) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Students:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(students.join(', ')),
      ],
    );
  }
}
