import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/teacher/EnrolledUsersScreen.dart';
import 'package:attendance_app/teacher/controller/teacher_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDisplay extends StatefulWidget {
  @override
  _CoursesShowState createState() => _CoursesShowState();
}

class _CoursesShowState extends State<CourseDisplay> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.primaryColor,
          title: const Text('All Courses'),
          centerTitle: true,
        ),
        body: GetBuilder<TeacherController>(initState: (state) {
          TeacherController.to.getCourseListMethod();
        }, builder: (obj) {
          return SizedBox(
            height: height,
            width: width,
            child: obj.allTeacherCources.isEmpty
                ? const Center(child: Text("No Record Found"))
                : ListView.builder(
                    itemCount: obj.allTeacherCources.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            print("object");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EnrolledStudentsScreen(
                                          subjectName: obj
                                              .allTeacherCources[index]
                                              .courseName,
                                          subjectId: obj
                                              .allTeacherCources[index]
                                              .courseID,
                                        )));
                          },
                          child: Container(
                            child: ListTile(
                              title:
                                  Text(obj.allTeacherCources[index].courseName),
                              subtitle:
                                  Text(obj.allTeacherCources[index].courseID),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        })

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
