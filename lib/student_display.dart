import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class StudentDisplay extends StatefulWidget {
  const StudentDisplay({super.key});

  @override
  State<StudentDisplay> createState() => _StudentDisplayState();
}

class _StudentDisplayState extends State<StudentDisplay> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
// Create a reference to the Firestore database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Create a function to get a list of a user's teachers
  Future<List<Map<String, dynamic>>> getTeachersForUser(String userId) async {
    // Get a reference to the user's teachers subcollection
    CollectionReference<Map<String, dynamic>> teachersCollection =
        _firestore.collection('users').doc(userId).collection('Teachers');

    // Fetch all the teacher documents from the subcollection
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await teachersCollection.get();

    // Convert the query snapshot into a list of maps
    List<Map<String, dynamic>> teacherList =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    // Return the list of teacher maps
    return teacherList;
  }

// Create a function to get a list of a user's students
  Future<List<Map<String, dynamic>>> getStudentsForUser(String userId) async {
    // Get a reference to the user's students subcollection
    CollectionReference<Map<String, dynamic>> studentsCollection =
        _firestore.collection('users').doc('Student').collection(userId);
    print('Usercollection is = ${studentsCollection}');

    // Fetch all the student documents from the subcollection
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await studentsCollection.get();

    // Convert the query snapshot into a list of maps
    List<Map<String, dynamic>> studentList =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    print(
        'studentsCollection after get from firebase is ${studentsCollection}');

    // Return the list of student maps
    return studentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Data',
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: users.snapshots(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Text('Error: ${snapshot.error}');
          //       }

          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       }

          //       return ListView(
          //         children:
          //             snapshot.data!.docs.map((DocumentSnapshot document) {
          //           Map<String, dynamic> user =
          //               document.data()! as Map<String, dynamic>;

          //           return StreamBuilder<QuerySnapshot>(
          //             stream:
          //                 document.reference.collection('Teachers').snapshots(),
          //             builder: (BuildContext context,
          //                 AsyncSnapshot<QuerySnapshot> snapshot) {
          //               if (snapshot.hasError) {
          //                 return Text('Error: ${snapshot.error}');
          //               }

          //               if (snapshot.connectionState ==
          //                   ConnectionState.waiting) {
          //                 return CircularProgressIndicator();
          //               }

          //               List<Widget> teacherList = [];
          //               snapshot.data!.docs
          //                   .forEach((DocumentSnapshot document) {
          //                 Map<String, dynamic> teacher =
          //                     document.data()! as Map<String, dynamic>;
          //                 teacherList.add(Card(
          //                   child: Column(
          //                     mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       ListTile(
          //                         title: Text(teacher['name']),
          //                         subtitle: Text(teacher['password']),
          //                         trailing: Text(teacher['role']),
          //                       ),
          //                     ],
          //                   ),
          //                 ));
          //               });

          //               return Column(
          //                 children: [
          //                   Card(
          //                     margin: const EdgeInsets.symmetric(
          //                         horizontal: 20, vertical: 06),
          //                     // shadowColor: Colors.red,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(12.0),
          //                     ),
          //                     elevation: 5,
          //                     child: ListTile(
          //                       title: Text(user['name']),
          //                       subtitle: Text(user['email']),
          //                       trailing: Text(user['role']),
          //                     ),
          //                   ),
          //                   Column(
          //                     children: teacherList,
          //                   ),
          //                 ],
          //               );
          //             },
          //           );
          //         }).toList(),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('3')
                  .collection('Admin')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        // return Text(doc['name']);
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(doc['name']),
                          subtitle: Text(doc['email']),
                          trailing: Text(doc['role']),
                        );
                      });
                } else {
                  return Text("No data");
                }
              },
            ),
          ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('users')
          //         .doc('1')
          //         .collection('Teacher')
          //         .get().then((value) => )
          //     builder: (context, snapshot) {
          //       return ListView.builder(
          //         itemCount: snapshot.data?.docs.length,
          //         itemBuilder: (context, index) {
          //           DocumentSnapshot course = snapshot.data.document[index];
          //           return ListTile(
          //             leading: Icon(Icons.percent),
          //             title: Text(course['name']),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),

          // Expanded(
          //   child: StreamBuilder(
          //     builder: (context, snapshot) {
          //       ListView.builder(
          //         itemBuilder: ((context, index) {
          //           return ListTile(
          //             title: Text('Hello Faraz'),
          //           );
          //         }),
          //       );
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: _firestore.collection('Teachers').snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       }

          //       if (!snapshot.hasData) {
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }

          //       final studentDocs = snapshot.data!.docs;

          //       return ListView.builder(
          //         itemCount: studentDocs.length,
          //         itemBuilder: (context, index) {
          //           final student = studentDocs[index].data();
          //           print('The value of student is ${student}');

          //           return Card(
          //             color: Colors.red,
          //             child: ListTile(
          //               title: Text('Name: ${student}'),
          //               subtitle: Text('Age: ${student}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: StreamBuilder<QuerySnapshot>(
          //     stream: _firestore.collection('Teachers').snapshots(),
          //     builder: (context, snapshot) {
          //       print(
          //           'show error ${_firestore.collection('Student').snapshots()}');
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       }
          //       print('value of variable is ${_firestore}');

          //       if (!snapshot.hasData) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }

          //       final teacherDocs = snapshot.data!.docs;

          //       return ListView.builder(
          //         itemCount: teacherDocs.length,
          //         itemBuilder: (context, index) {
          //           final teacher = teacherDocs[index].data();
          //           return Card(
          //             child: ListTile(
          //               title: Text('Name: ${teacher}'),
          //               subtitle: Text('Subject: ${teacher}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
