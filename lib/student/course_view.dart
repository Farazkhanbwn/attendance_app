import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/student/updat_blueId.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    // _getCourses();
  }

  // void _getCourses() async {
  //   QuerySnapshot querySnapshot =
  //       await allocationsRef.where('user_email', isEqualTo: user?.email).get();

  //   setState(() {
  //     _courses = querySnapshot.docs;
  //   });
  // }

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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('subject_allocations')
                    .where('students', arrayContains: widget.name)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('display name is = ${user!.displayName}');
                    print('why display name is null');
                    print('wiget name is = ${widget.name}');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No courses found'),
                    );
                  } else {
                    final courses =
                        snapshot.data!.docs.map((doc) => doc.data()).toList();
                    print('courses is = ${courses}');
                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        var course = courses[index] as Map<String, dynamic>;
                        var subjectNames = course['subjectname'];
                        return Center(
                          child: Card(
                              child: ListTile(
                            title: Text('${subjectNames}'),
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
                    );

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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
