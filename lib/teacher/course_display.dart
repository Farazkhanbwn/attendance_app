import 'package:attendance_app/teacher/EnrolledUsersScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseDisplay extends StatefulWidget {
  @override
  _CoursesShowState createState() => _CoursesShowState();
}

class _CoursesShowState extends State<CourseDisplay> {
  late User? _user;
  late String _currentUserName = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    // if (_user != null && _user!.displayName != null) {
    //   setState(() {
    //     _currentUserName = _user!.displayName!;
    //     print('Current user name is = ${_currentUserName}');
    //   });
    // }
    if (_user != null) {
      String email = _user!.email!;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get()
          .then((doc) {
        if (doc.exists) {
          setState(() {
            _currentUserName = doc['name'];
            print('Your current email is = ${email}');
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Courses'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('courses')
              .where('teacherName', isEqualTo: _currentUserName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final courseDocs = snapshot.data!.docs;
              if (courseDocs.isEmpty) {
                return const Center(
                  child: Text('None of the courses found.'),
                );
              }
              return ListView.builder(
                itemCount: courseDocs.length,
                itemBuilder: (context, index) {
                  final course =
                      courseDocs[index].data() as Map<String, dynamic>;
                  final String subjectname = course['courseName'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnrolledStudentsScreen(
                                    subjectName: subjectname,
                                  )));
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(course['courseName'] ?? ''),
                        subtitle: Text(course['courseID']),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20,
                        ),
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
        )

        // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance
        //       .collection('courses')
        //       .where('teacherName', isEqualTo: _currentUserName)
        //       // .where('teacherName', isEqualTo: 'Nazim Khan')

        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     // else if (!snapshot.hasData || snapshot.data!.isEnpty) {
        //     //   return const Center(
        //     //     child: Text('None of the students are enrolled'),
        //     //   );
        //     // }
        //     print('current user name is = ${_currentUserName}');

        //     if (snapshot.hasData) {
        //       final courseDocs = snapshot.data!.docs;
        //       print('Course document is = ${courseDocs}');
        //       return ListView.builder(
        //         itemCount: courseDocs.length,
        //         itemBuilder: (context, index) {
        //           final course = courseDocs[index].data() as Map<String, dynamic>;
        //           final String subjectname = course['courseName'];
        //           print('subjectname is equal to =${subjectname}');
        //           return GestureDetector(
        //             onTap: () {
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           // EnrollStudents(subjectName: subjectname),
        //                           EnrolledStudentsScreen(
        //                             subjectName: subjectname,
        //                           )));
        //             },
        //             child: Card(
        //               child: ListTile(
        //                 title: Text(course['courseName'] ?? ''),
        //                 subtitle: Text(course['courseID']),
        //                 trailing: const Icon(
        //                   Icons.arrow_forward_ios_rounded,
        //                   size: 20,
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //     return const Center(
        //       child: Text('No courses found.'),
        //     );
        //   },
        // ),
        );
  }
}
