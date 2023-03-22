// import 'package:attendance_app/chatgpt/studentlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CoursesShow6 extends StatefulWidget {
  @override
  _CoursesShowState createState() => _CoursesShowState();
}

class _CoursesShowState extends State<CoursesShow6> {
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
      // print('Course Stream = ${_coursesStream.toString()}');

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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
      ),
      body: Expanded(
        // width: width,
        // height: height,
        child: StreamBuilder<QuerySnapshot>(
          stream: _coursesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print('snapshot data is = ${snapshot}');
            print('course stream is = to the following ${_coursesStream}');
            if (snapshot.hasData) {
              final courseDocs = snapshot.data!.docs;
              // print('snapshot data is =${courseDocs}');
              return ListView.builder(
                itemCount: courseDocs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final course =
                      courseDocs[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(course['courseName'] ?? ''),
                    subtitle: StudentList(course['students'] ?? []),
                  );
                },
              );
            }
            return const Center(
              child: Text('No courses found.'),
            );
          },
        ),
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
