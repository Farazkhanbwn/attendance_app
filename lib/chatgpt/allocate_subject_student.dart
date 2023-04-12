import 'package:attendance_app/models/allocation_subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectToStudents extends StatefulWidget {
  @override
  _AllocateSubjectFormState createState() => _AllocateSubjectFormState();
}

class _AllocateSubjectFormState extends State<SubjectToStudents> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSubject;
  String? _selectedSubjectName;
  List<String> _selectedStudents = [];
  List<String> subjectNamesList = [];
  bool _selectAll = false;
  List<String> enrolledStudents = [];
  List<String> _checkedItems = [];
  Map<String, String> _selectedStudentNames = {};

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
      final docRef = allocationsRef.doc(_selectedSubjectName);
      // final docRef = allocationsRef.doc(Student['email'].toString());
      final studentName = _selectedStudentNames[gmail];
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
                      onChanged: (value) async {
                        setState(
                          () {
                            // _selectedStudents = enrolledStudents;
                            _selectedSubject = value;
                            _selectedSubjectName = (snapshot.data!.docs
                                .firstWhere((doc) => doc.id == _selectedSubject)
                                .data() as Map<String, dynamic>)['courseName'];
                            print(
                                'The selected subject is = ${_selectedSubjectName.toString()}');
                          },
                        );
                        if (_selectedSubject == null ||
                            _selectedSubject is! String) {
                          // handle the error, such as displaying an error message or returning null
                          return null;
                        }

                        DocumentSnapshot studentSnapshot =
                            await FirebaseFirestore.instance
                                .collection('subject_allocation')
                                .doc(_selectedSubjectName)
                                .get();
                        if (studentSnapshot.exists) {
                          enrolledStudents = List<String>.from((studentSnapshot
                              .data() as Map<String, dynamic>)['students']);
                        }
                        // build the list of checkboxes for all students, marking those already enrolled as checked
                        List<CheckboxListTile> studentCheckboxes =
                            snapshot.data!.docs.map((doc) {
                          Map<String, dynamic> data =
                              doc.data() as Map<String, dynamic>;
                          String studentName = data['name'] ?? '';
                          print('student name is =${studentName}');
                          print(
                              'Enrolled Students is = ${enrolledStudents.toString()}');
                          bool checked = enrolledStudents.contains(studentName);
                          return CheckboxListTile(
                            title: Text(studentName),
                            value: checked,
                            onChanged: (value) {
                              setState(() {
                                if (value != null) {
                                  if (value) {
                                    enrolledStudents.add(studentName);
                                    print(
                                        'enrolled Students is = ${enrolledStudents}');
                                  } else {
                                    enrolledStudents.remove(studentName);
                                  }
                                }
                              });
                            },
                          );
                        }).toList();

                        // Fetch the students for the selected subject from the database
                        // QuerySnapshot studentSnapshot = await FirebaseFirestore
                        //     .instance
                        //     .collection('subject_allocations')
                        //     .where('_selectedStudents',
                        //         arrayContains: subjectNamesList)
                        //     .get();

                        // Update the selected students lists
                        // setState(() {
                        //   _selectedStudents.clear();
                        //   _selectedStudentNames.clear();
                        //   studentSnapshot.docs.forEach((doc) {
                        //     Map<String, dynamic> data =
                        //         doc.data() as Map<String, dynamic>;
                        //     String studentId = doc.id;
                        //     String studentName = data['studentName'];
                        //     _selectedStudents.add(studentId);
                        //     _selectedStudentNames[studentId] = studentName;
                        //   });
                        // });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a subject';
                        }
                        return null;
                      },
                    );

                    // return DropdownButtonFormField<String>(
                    //   value: _selectedSubject,
                    //   items: snapshot.data!.docs.map((doc) {
                    //     Map<String, dynamic> data =
                    //         doc.data() as Map<String, dynamic>;
                    //     return DropdownMenuItem<String>(
                    //       value: doc.id,
                    //       child: Text(data['courseName']),
                    //     );
                    //   }).toList(),
                    //   hint: const Text('Select a subject'),
                    //   onChanged: (value) {
                    //     setState(
                    //       () {
                    //         _selectedSubject = value;
                    //         _selectedSubjectName = (snapshot.data!.docs
                    //             .firstWhere((doc) => doc.id == _selectedSubject)
                    //             .data() as Map<String, dynamic>)['courseName'];
                    //         if (!subjectNamesList
                    //             .contains(_selectedSubjectName)) {
                    //           subjectNamesList.add(_selectedSubjectName!);
                    //         }

                    //         print(
                    //             'The selected subject is = ${_selectedSubjectName.toString()}');
                    //       },
                    //     );
                    //   },
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Please select a subject';
                    //     }
                    //     return null;
                    //   },
                    // );
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
                    }),
                const SizedBox(height: 16),
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
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
                        // print('studentid is = ${studentId}');
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
                              value: _selectedStudents.contains(studentName),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    _selectedStudents = enrolledStudents;
                                    print(
                                        '_selected students = ${_selectedStudents}');

                                    // _selectedStudents
                                    //     .add(enrolledStudents.toString());
                                    _selectedStudents.add(studentName);
                                    print(
                                        'selected student name is ={$_selectedStudents}');
                                    _selectedStudentNames[studentId] =
                                        studentName;
                                  } else {
                                    _selectedStudents.remove(studentName);
                                    _selectedStudentNames.remove(studentId);
                                  }
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
                      onPressed: () {
                        // Get the current enroll students list for the selected subject from Firebase
                        FirebaseFirestore.instance
                            .collection('subject_allocation')
                            .doc(_selectedSubjectName)
                            .get()
                            .then((docSnapshot) {
                          List<String> currentEnrollStudents = [];
                          if (docSnapshot.exists) {
                            currentEnrollStudents = List<String>.from(
                                docSnapshot.data()!['students']);
                            print(
                                'current enrolled students is pakistna = ${currentEnrollStudents}');
                          }
                          // Add the selected students to the enroll students list if they are not already present
                          for (String student in _selectedStudents) {
                            if (!currentEnrollStudents.contains(student)) {
                              currentEnrollStudents.add(student);
                            }
                          }
                          // Save the updated enroll students list to Firebase
                          FirebaseFirestore.instance
                              .collection('subject_allocation')
                              .doc(_selectedSubjectName)
                              .set({
                            'students': currentEnrollStudents,
                            'updated_students ': _selectedStudents
                          });
                          // Clear the selected students list and show a confirmation dialog
                          setState(() {
                            enrolledStudents.clear();
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Subject Allocated'),
                                content: const Text(
                                    'The subject has been allocated to the selected students.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        });
                      },

                      // onPressed: () async {
                      //   await FirebaseFirestore.instance
                      //       .collection('subject_allocation')
                      //       .doc(_selectedSubjectName)
                      //       .set({
                      //     'subjectName': _selectedSubjectName,
                      //     'students': _selectedStudents,
                      //   });
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('Subject allocations saved')),
                      //   );
                      // },
                      child: Text('Save subject allocations'),
                    )
                    // ElevatedButton(
                    //   child: const Text('Allocate Subject'),
                    //   onPressed: () async {
                    //     if (_formKey.currentState!.validate()) {
                    //       allocateSubject(
                    //         _selectedSubject.toString(),
                    //         _selectedSubjectName.toString(),
                    //         // studentName.toString(),
                    //       );
                    //       // Show success message
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         SnackBar(
                    //           content: Text(
                    //               'Subject allocated to ${_selectedStudents.length} students'),
                    //         ),
                    //       );

                    //       _formKey.currentState!.reset();

                    //       _selectedStudents = [];
                    //     }
                    //   },
                    // ),
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
