import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/static_data.dart';
import 'package:attendance_app/student/controller/student_controller.dart';
import 'package:attendance_app/student/updat_blueId.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCoursesPage extends StatefulWidget {
  final String name;

  const MyCoursesPage({Key? key, required this.name}) : super(key: key);

  @override
  _MyCoursesPageState createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  // final CollectionReference allocationsRef =
  // FirebaseFirestore.instance.collection('subject_allocations');
  List<DocumentSnapshot> _courses = [];
  String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
  List<String> subjectNames = [];

  // List<CourseAllocate> courses = [];
  // getcourse() async {
  //   await FirebaseFirestore.instance
  //       .collection("subject_allocations")
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       setState(() {
  //         courses.add(CourseAllocate.fromMap(element.data()));
  //       });
  //     });
  //   });
  //   print("model =" + courses.toString());
  // }

  getEnrolledSubjects() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    if (userEmail != null) {
      final subjectNames = <String>[];
      final snapshot = await FirebaseFirestore.instance
          .collection('subject_allocations')
          .doc()
          .collection(userEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (final doc in snapshot.docs) {
          subjectNames.add(doc.id);
        }
      }
      print('Enrolled subject names: $subjectNames');
    }
  }

  @override
  void initState() {
    super.initState();
    // _getCourses()
    // ;
    getEnrolledSubjects();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      //   appBar: AppBar(
      //     title: Text('My Courses'),
      //   ),
      //   body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(child: CircularProgressIndicator());
      //       }
      //       if (snapshot.hasError) {
      //         return Center(child: Text('Error fetching courses'));
      //       }
      //       if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      //         return Center(child: Text('No courses found'));
      //       }

      //       final courses = snapshot.data!.docs.map((doc) => doc.data()).toList();

      //       return ListView.builder(
      //         itemCount: courses.length,
      //         itemBuilder: (context, index) {
      //           final course = courses[index];
      //           return Card(
      //             child: Padding(
      //               padding: const EdgeInsets.all(16.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'Subject ID: ${course['subject_id']}',
      //                     style: const TextStyle(
      //                         fontSize: 18.0, fontWeight: FontWeight.bold),
      //                   ),
      //                   const SizedBox(height: 5.0),
      //                   Text(
      //                     'Subject Name: ${course['subject_name']}',
      //                     style: TextStyle(fontSize: 16.0),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     },
      //   ),
      // );
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        title: const Text('My Courses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Student Courses:',
            //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10.0),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _courses.length,
            //     itemBuilder: (context, index) {
            //       var course = _courses[index].data() as Map<String, dynamic>;
            //       return Card(
            //         elevation: 5,
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Subject Name: ${course['subject_name'] ?? 'N/A'}',
            //                 style: const TextStyle(
            //                     fontSize: 18.0, fontWeight: FontWeight.w500),
            //               ),
            //               const SizedBox(height: 5.0),
            //               Text(
            //                 'Subject Id: ${course['subject_id']}',
            //                 style: TextStyle(fontSize: 14.0),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            GetBuilder<StudentController>(initState: (state) {
              StudentController.to.getCourseListMethod().then((value) {
                StudentController.to.getMyCourseListMethod(value);
              });
            }, builder: (obj) {
              return Expanded(
                  child: SizedBox(
                height: height,
                width: width,
                child: obj.myAllCorces.isEmpty
                    ? Center(child: const Text("No Record Found"))
                    : ListView.builder(
                        itemCount: obj.myAllCorces.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Card(
                                child: ListTile(
                              title: Text(obj.myAllCorces[index].subjectname!),
                            )),
                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: subjectNames.map((subjectName) {
                            //     return SizedBox(
                            //       width: width * 0.9,
                            //       height: height * 0.08,
                            //       child: Card(
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(8)),
                            //         elevation: 5,
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.center,
                            //             children: [
                            //               Text('${subjectName ?? 'N/A'}',
                            //                   style: const TextStyle(
                            //                       fontSize: 18.0,
                            //                       fontWeight: FontWeight.w500)),
                            //               const SizedBox(height: 5.0),
                            //               // Text(
                            //               //   'Subject Id: ${course['subjectId']}',
                            //               //   style:
                            //               //       const TextStyle(fontSize: 14.0),
                            //               // ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   }).toList(),
                            // ),
                          );
                        },
                      ),
              )

                  // final courses =
                  //     snapshot.data!.docs.map((doc) => doc.data()).toList();
                  // return ListView.builder(
                  //   itemCount: courses.length,
                  //   itemBuilder: (context, index) {
                  //     var course = courses[index] as Map<String, dynamic>;
                  //     return Card(
                  //       elevation: 5,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               // 'Subject Name: ${course['subjectNamesList'] ?? 'N/A'}',
                  //               'Subject Name: ${course['subjectNamesList'][index] ?? 'N/A'}',
                  //               style: const TextStyle(
                  //                   fontSize: 18.0,
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //             const SizedBox(height: 5.0),
                  //             Text(
                  //               'Subject Id: ${course['subjectId']}',
                  //               style: const TextStyle(fontSize: 14.0),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );

                  );
            }),
          ],
        ),
      ),
    );
  }
}
