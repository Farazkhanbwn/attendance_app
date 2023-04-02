import 'package:attendance_app/models/allocation_subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllocateSubjectForm extends StatefulWidget {
  @override
  _AllocateSubjectFormState createState() => _AllocateSubjectFormState();
}

class _AllocateSubjectFormState extends State<AllocateSubjectForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSubject;
  String? _selectedSubjectName;
  List<String> _selectedStudents = [];
  List<String> subjectNamesList = [];
  bool _selectAll = false;
  List<String> _checkedItems = [];
  Map<String, String> _selectedStudentNames = {};
  // String? studentName;
//   void saveSubjectNameList(List<String> subjectNameList) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('subjectNameList', subjectNameList);
//   }

// // Retrieve the subjectNameList from SharedPreferences
//   Future<List<String>> getSubjectNameList() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getStringList('subjectNameList') ?? [];
//   }

  CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');
  Future<void> allocateSubject(
    // List<String> selectedStudents,
    String selectedSubject,
    String selectedSubjectName,
    // String studentName,
  ) async {
    final CollectionReference allocationsRef =
        FirebaseFirestore.instance.collection('subject_allocations');
    // String gmail = data['email'];
    for (final gmail in _selectedStudents) {
      final docRef = allocationsRef.doc(gmail);
      // final docRef = allocationsRef.doc(Student['email'].toString());
      final studentName = _selectedStudentNames[gmail];
      print('student name of selected student is =${_selectedStudentNames}');
      await docRef.get().then(
        (doc) {
          final subjectAllocation = SubjectAllocation(
              userEmail: gmail,
              subjectId: _selectedSubject,
              subjectName: _selectedSubjectName,
              subjectNamesList: subjectNamesList,
              studentName: studentName);
          print(
            'selected subject is =${_selectedSubject}',
          );
          print(
            'selected subjectName is =${_selectedSubjectName}',
          );
          if (doc.exists) {
            // String? subjectName = doc.get('subjectName') as String?;
            // if (selectedSubject != null) {
            //   // subjectNamesList.add(selectedSubject);
            // }
            print('subject name list = ${subjectNamesList}');
            docRef.update(subjectAllocation.toMap()).then((value) {
              // print("Subject allocation updated with ID: $gmail");
            }).catchError((error) {
              print("Failed to update subject allocation: $error");
            });
          } else {
            docRef.set(subjectAllocation.toMap()).then((value) {
              // print("Subject allocation added with ID: $gmail");
            }).catchError((error) {
              print("Failed to add subject allocation: $error");
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Drop-down for selecting subject
                FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('courses').get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      items: snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return DropdownMenuItem<String>(
                          value: doc.id,
                          child: Text(data['courseName']),
                        );
                      }).toList(),
                      hint: const Text('Select a subject'),
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedSubject = value;
                            _selectedSubjectName = (snapshot.data!.docs
                                .firstWhere((doc) => doc.id == _selectedSubject)
                                .data() as Map<String, dynamic>)['courseName'];
                            if (!subjectNamesList
                                .contains(_selectedSubjectName)) {
                              subjectNamesList.add(_selectedSubjectName!);
                            }
                            // print(
                            //     'Name of the student is = ${studentName}');
                            // }
                            // else {
                            // _selectedStudents.remove(studentId);
                            // if (subjectNamesList
                            //     .contains(_selectedSubjectName)) {
                            // subjectNamesList.remove(_selectedSubjectName);
                            // }
                            print(
                                'The selected subject is = ${_selectedSubjectName.toString()}');
                          },
                        );
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a subject';
                        }
                        return null;
                      },
                    );
                  },
                ),
                CheckboxListTile(
                  title: const Text('Select All'),
                  value: _selectAll,
                  onChanged: (bool? value) {
                    setState(() {
                      _selectAll = value!;
                      if (_selectAll) {
                        _checkedItems = List.from(subjectNamesList);
                      } else {
                        _checkedItems.clear();
                      }
                    });
                  },
                ),
                // Container(
                //   child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //     stream:
                //         usersRef.where('role', isEqualTo: 'Student').snapshots(),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                //             snapshot) {
                //       if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       }

                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Text('Loading...');
                //       }

                //       List<DropdownMenuItem<String>> items = [];

                //       // Loop through the documents in the snapshot and add each user to the dropdown list
                //       for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
                //           in snapshot.data!.docs) {
                //         String userEmail = docSnapshot.id;
                //         String role = docSnapshot.get('role');
                //         String userName = docSnapshot.get('name');
                //         String userFullName = '$userName ($userEmail)';

                //         items.add(DropdownMenuItem<String>(
                //           value: userEmail,
                //           child: Text(userFullName),
                //         ));
                //       }
                //       return DropdownButton<String>(
                //         items: items,
                //         onChanged: (String? value) {
                //           // Do something with the selected value, such as update a variable or call a function
                //         },
                //         hint: const Text('Select a user'),
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(height: 16),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      // .collection('users')
                      // .doc('2')
                      // .collection('Student')
                      // .get(),
                      .collection('users')
                      .where('role', isEqualTo: 'Student')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!.docs.map((doc) {
                        String studentId = doc.id;
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        String studentName = data['name'];
                        // print('Student Name is = ${studentName}');
                        // String studentName = data['name'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,
                            child: CheckboxListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              title: Text(studentName),
                              subtitle: Text(data['email']),
                              value: _selectedStudents.contains(studentId),
                              //  && _selectedStudents.contains(studentName),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    // _selectedStudents.add(studentName);
                                    _selectedStudents.add(studentId);
                                    // studentName = data['name'];
                                    // studentNamesList.add(studentName);
                                    _selectedStudentNames[studentId] =
                                        studentName;
                                    print(
                                        'Name of the student is = ${studentName}');
                                  } else {
                                    _selectedStudents.remove(studentId);
                                    // studentNamesList.remove(studentName);
                                    _selectedStudentNames.remove(studentId);
                                  }
                                  print(
                                      'Name of the student is = ${studentName}');
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    child: const Text('Allocate Subject'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        allocateSubject(
                          _selectedSubject.toString(),
                          _selectedSubjectName.toString(),
                          // studentName.toString(),
                        );
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Subject allocated to ${_selectedStudents.length} students'),
                          ),
                        );

                        // Allocate subject to selected students
                        // CollectionReference allocationsRef = FirebaseFirestore
                        //     .instance
                        //     .collection('subject_allocations');
                        // _selectedStudents.forEach((gmail) {
                        //   DocumentReference docRef = allocationsRef.doc(gmail);
                        //   docRef.set({
                        //     'user_email': gmail,
                        //     'subject_id': _selectedSubject!,
                        //     'subject_name': _selectedSubjectName,
                        //   }, SetOptions(merge: true)).then((value) {
                        //     print(
                        //         "Subject allocation added/updated with ID: $gmail");
                        //   }).catchError((error) {
                        //     print(
                        //         "Failed to add/update subject allocation: $error");
                        //   });
                        // });
                        // // Show success message
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //         'Subject allocated to ${_selectedStudents.length} students'),
                        //   ),
                        // );
                        // Reset form
                        // DocumentReference docRef;
                        // CollectionReference allocationsRef = FirebaseFirestore
                        //     .instance
                        //     .collection('subject_allocations');

                        // _selectedStudents.forEach((gmail) async {
                        //   docRef = allocationsRef.doc(gmail);

                        //   await docRef.get().then((doc) {
                        //     if (doc.exists) {
                        //       // subjectNamesList.add(doc.data()['subject_name']);

                        //       docRef.update({
                        //         'subject_id': _selectedSubject!,
                        //         // 'subject_name': _selectedSubjectName,
                        //       }).then((value) {
                        //         print(
                        //             "Subject allocation updated with ID: $gmail");
                        //       }).catchError((error) {
                        //         print(
                        //             "Failed to update subject allocation: $error");
                        //       });
                        //     } else {
                        //       // subjectNamesList.add(doc.data()['subject_name']);
                        //       docRef.set({
                        //         'user_email': gmail,
                        //         'subject_id': _selectedSubject!,
                        //         'subject_name': _selectedSubjectName,
                        //       }).then((value) {
                        //         print(
                        //             "Subject allocation added with ID: $gmail");
                        //       }).catchError((error) {
                        //         print(
                        //             "Failed to add subject allocation: $error");
                        //       });
                        //     }
                        //   });
                        // });

                        _formKey.currentState!.reset();
                        // _selectedSubject = null;
                        // subjectNamesList = [];
                        _selectedStudents = [];
                      }
                    },
                  ),
                ),
                // Checkbox list for selecting students

                const SizedBox(height: 16),
                // Button for submitting the form
              ],
            ),
          ),
        ),
      ),
    );
  }
}
