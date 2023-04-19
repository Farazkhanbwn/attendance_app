import 'dart:ffi';

import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/allocation_subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectToStudents extends StatefulWidget {
  @override
  _AllocateSubjectFormState createState() => _AllocateSubjectFormState();
}

class _AllocateSubjectFormState extends State<SubjectToStudents> {
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore instance = FirebaseFirestore.instance;

  String? _selectedSubject;
  String? _selectedSubjectName;
  List<String> _selectedStudents = [];
  bool _selectAll = false;
  List<String> enrolledStudents = [];
  List<String> _checkedItems = [];
  // Map<String, String> _selectedStudentNames = {};

  AllocateSubject() async {
    CourseAllocate model = CourseAllocate(
      students: _selectedStudents,
      subjectname: _selectedSubjectName,
    );
    await instance
        .collection('subject_allocations')
        .doc(_selectedSubjectName)
        .set(model.toMap());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Drop-down for selecting subject
                Container(
                  alignment: Alignment.bottomRight,
                  width: width,
                  height: height * 0.13,
                  // color: Colors.blue,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: width,
                      height: height * 0.07,
                      color: Color.fromARGB(255, 93, 200, 250),
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('courses')
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.02, top: height * 0.018),
                            child: DropdownButtonFormField<String>(
                              decoration:
                                  InputDecoration.collapsed(hintText: ''),
                              iconEnabledColor: Colors.white,
                              // iconDisabledColor: Colors.red,
                              value: _selectedSubject,
                              items: snapshot.data!.docs.map((doc) {
                                Map<String, dynamic> data =
                                    doc.data() as Map<String, dynamic>;
                                return DropdownMenuItem<String>(
                                  value: doc.id,
                                  child: Text(
                                    data['courseName'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }).toList(),
                              dropdownColor: Color.fromARGB(255, 99, 201, 248),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hint: const Text(
                                'Select a subject',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 254, 254),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (value) async {
                                setState(
                                  () {
                                    // _selectedStudents = enrolledStudents;
                                    print(
                                        'pakistan zindabad ${_selectedStudents}');
                                    print(
                                        'enrolled students is = {$enrolledStudents}');
                                    _selectedSubject = value;
                                    _selectedSubjectName = (snapshot.data!.docs
                                            .firstWhere((doc) =>
                                                doc.id == _selectedSubject)
                                            .data()
                                        as Map<String, dynamic>)['courseName'];
                                    print(
                                        'The selected subject is = ${_selectedSubjectName.toString()}');
                                  },
                                );
                                // _selectedStudents = enrolledStudents;
                                if (_selectedSubject == null ||
                                    _selectedSubject is! String) {
                                  // handle the error, such as displaying an error message or returning null
                                  return null;
                                }
                                DocumentSnapshot studentSnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('subject_allocations')
                                        .doc(_selectedSubjectName)
                                        .get();
                                if (studentSnapshot.exists) {
                                  enrolledStudents = List<String>.from(
                                      (studentSnapshot.data()
                                          as Map<String, dynamic>)['students']);
                                } else {
                                  enrolledStudents = [];
                                }
                                // build the list of checkboxes for all students, marking those already enrolled as checked
                                List<CheckboxListTile> studentCheckboxes =
                                    snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  String studentName = data['name'] ?? '';
                                  _selectedStudents = enrolledStudents;
                                  print(
                                      'Enrolled Students is = ${enrolledStudents.toString()}');
                                  bool checked =
                                      enrolledStudents.contains(studentName);
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
                                            enrolledStudents
                                                .remove(studentName);
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
                                  return 'Please select a subject ';
                                }
                                return null;
                              },
                            ),
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
                    ),
                  ),
                ),
                CheckboxListTile(
                    title: const Text('Select All'),
                    value: _selectAll,
                    onChanged: (bool? value) {
                      setState(() {
                        _selectAll = value!;
                        if (_selectAll) {
                          _checkedItems = List.from(_selectedStudents);
                        } else {
                          _checkedItems.clear();
                        }
                      });
                    }),
                const SizedBox(height: 16),
                Container(
                  width: width,
                  height: height * 0.5,
                  color: Color.fromARGB(255, 76, 193, 247),
                  child: SingleChildScrollView(
                    child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where('role', isEqualTo: 'Student')
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                                  value:
                                      _selectedStudents.contains(studentName),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        // _selectedStudents = enrolledStudents;
                                        print(
                                            '_selected students = ${_selectedStudents}');

                                        // _selectedStudents
                                        //     .add(enrolledStudents.toString());
                                        _selectedStudents.add(studentName);
                                        print(
                                            'selected student name is ={$_selectedStudents}');
                                        // _selectedStudentNames[studentId] =
                                        //     studentName;
                                      } else {
                                        _selectedStudents.remove(studentName);
                                        // _selectedStudentNames.remove(studentId);
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
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AllocateSubject();
                          setState(() {
                            enrolledStudents.clear();
                            _selectedSubject = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Subject allocation Changes Successfully')),
                          );
                        }
                      },
                      child: const Text(
                        'Save subject allocations',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
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
