import 'dart:ffi';

import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/button.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/admin/subject_allocation.dart';
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
  String? studentName;
  String? stdId;
  String? studentBlueId;
  String? _selectedSubject;
  String? _selectedSubjectName;
  List<CourseAllocate> _selectedStudents = [];
  bool _selectAll = false;
  List<String> enrolledStudents = [];
  List<String> _checkedItems = [];
  // Map<String, String> _selectedStudentNames = {};
  DataToModelClass() {
    CourseAllocation Allocate =
        CourseAllocation(name: 'faraz', blueId: '1', rollno: 4);
  }

  // AllocateSubject() async {
  //   CourseAllocate model = CourseAllocate(
  //     students: _selectedStudents,
  //     subjectname: _selectedSubjectName,
  //   );
  //   await instance
  //       .collection('subject_allocations')
  //       .doc(_selectedSubjectName)
  //       .set(model.toMap());
  // }
  AllocateSubject() async {
    for (int i = 0; i < _selectedStudents.length; i++) {
      await instance
          .collection('subject_allocations')
          .doc(_selectedSubjectName!)
          .collection('${_selectedStudents[i].studentid}')
          .add(_selectedStudents[i].toMap());
    }
    setState(() {
      _selectedStudents.clear();
    });
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
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.07,
                  width: width,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: MyTheme.primaryColor,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.2),
                        child: Text(
                          'Subject Allocation',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w800,
                            color: MyTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Drop-down for selecting subject
                Container(
                  alignment: Alignment.center,
                  width: width,
                  height: height * 0.13,
                  // color: Colors.blue,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: width * 0.93,
                      height: height * 0.07,
                      // color: Color.fromARGB(255, 93, 200, 250),
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
                                  const InputDecoration.collapsed(hintText: ''),
                              // iconEnabledColor: Colors.white,
                              iconEnabledColor: MyTheme.primaryColor,
                              iconDisabledColor: Colors.red,
                              value: _selectedSubject,
                              items: snapshot.data!.docs.map((doc) {
                                Map<String, dynamic> data =
                                    doc.data() as Map<String, dynamic>;
                                return DropdownMenuItem<String>(
                                  value: doc.id,
                                  child: Text(
                                    data['courseName'],
                                    style: TextStyle(
                                      // color: Colors.white,
                                      color: MyTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }).toList(),
                              dropdownColor: MyTheme.whiteColor,
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                              hint: Text(
                                'Select a subject',
                                style: TextStyle(
                                  // color: Color.fromARGB(255, 255, 254, 254),
                                  color: MyTheme.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) async {
                                setState(
                                  () {
                                    // _selectedStudents = enrolledStudents;
                                    print(
                                        'pakistan zindabad ${_selectedStudents}');
                                    print(
                                      'enrolled students is = {$enrolledStudents}',
                                    );
                                    _selectedSubject = value;
                                    _selectedSubjectName = (snapshot.data!.docs
                                            .firstWhere((doc) =>
                                                doc.id == _selectedSubject)
                                            .data()
                                        as Map<String, dynamic>)['courseName'];
                                    print(
                                      'The selected subject is = ${_selectedSubjectName.toString()}',
                                    );
                                  },
                                );
                                // _selectedStudents = enrolledStudents;
                                if (_selectedSubject == null ||
                                    _selectedSubject!.isNotEmpty) {
                                  // handle the error, such as displaying an error message or returning null
                                  return null;
                                }
                                DocumentSnapshot studentSnapshot =
                                    await FirebaseFirestore.instance
                                        .collection('subject_allocations')
                                        .doc(_selectedSubjectName)
                                        .collection('')
                                        .doc()
                                        .get();
                                if (studentSnapshot.exists) {
                                  enrolledStudents = List<String>.from(
                                      (studentSnapshot.data() as Map<String,
                                          dynamic>)['studentName']);
                                  print('snapshots for students = ${snapshot}');
                                } else {
                                  enrolledStudents = [];
                                }
                                // build the list of checkboxes for all students, marking those already enrolled as checked
                                List<CheckboxListTile> studentCheckboxes =
                                    snapshot.data!.docs.map(
                                  (doc) {
                                    Map<String, dynamic> data =
                                        doc.data() as Map<String, dynamic>;
                                    String studentName = data['name'] ?? '';

                                    // _selectedStudents = enrolledStudents;
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
                                  },
                                ).toList();
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a subject ';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // CheckboxListTile(
                //     title: const Text('Select All'),
                //     value: _selectAll,
                //     onChanged: (bool? value) {
                //       setState(() {
                //         _selectAll = value!;
                //         if (_selectAll) {
                //           _checkedItems = List.from(_selectedStudents);
                //         } else {
                //           _checkedItems.clear();
                //         }
                //       });
                //     }),
                const SizedBox(height: 16),
                // Container(
                //   width: width,
                //   height: height * 0.5,
                //   color: Color.fromARGB(255, 76, 193, 247),
                //   child: SingleChildScrollView(
                //     child: FutureBuilder<QuerySnapshot>(
                //       future: FirebaseFirestore.instance
                //           .collection('users')
                //           .where('role', isEqualTo: 'Student')
                //           .get(),
                //       builder: (context, snapshot) {
                //         if (!snapshot.hasData) {
                //           return const Center(
                //               child: CircularProgressIndicator());
                //         }
                //         return Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: snapshot.data!.docs.map((doc) {
                //             String studentId = doc.id;
                //             // print('studentid is = ${studentId}');
                //             Map<String, dynamic> data =
                //                 doc.data() as Map<String, dynamic>;
                //             String studentName = data['name'];
                //             // print('Student Name is = ${studentName}');
                //             // String studentName = data['name'];
                //             return Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 3),
                //               child: Card(
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 elevation: 5,
                //                 child: CheckboxListTile(
                //                   contentPadding: const EdgeInsets.symmetric(
                //                     horizontal: 15,
                //                   ),
                //                   title: Text(studentName),
                //                   subtitle: Text(data['email']),
                //                   value:
                //                       _selectedStudents.contains(studentName),
                //                   onChanged: (value) {
                //                     setState(() {
                //                       if (value!) {
                //                         // _selectedStudents = enrolledStudents;
                //                         print(
                //                             '_selected students = ${_selectedStudents}');

                //                         // _selectedStudents
                //                         //     .add(enrolledStudents.toString());
                //                         _selectedStudents.add(studentName);
                //                         print(
                //                             'selected student name is ={$_selectedStudents}');
                //                         // _selectedStudentNames[studentId] =
                //                         //     studentName;
                //                       } else {
                //                         _selectedStudents.remove(studentName);
                //                         // _selectedStudentNames.remove(studentId);
                //                       }
                //                     });
                //                   },
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: width,
                  height: height * 0.5,
                  // color: Colors.blue[300],
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
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            studentName = data['name'];
                            studentId = data['email'];
                            studentBlueId = data['blueId'];
                            String studentEmail = data['email'];
                            CourseAllocate model = CourseAllocate(
                                studentName: studentName,
                                studentid: studentId,
                                subjectblueId: studentBlueId,
                                subjectname: _selectedSubjectName);
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
                                  title: Text(
                                    studentName!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: Colors.blue[900],
                                        color: MyTheme.primaryColor),
                                  ),
                                  subtitle: Text(
                                    // studentEmail,
                                    'Student',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue[700],
                                    ),
                                  ),
                                  value: _selectedStudents.contains(model),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        _selectedStudents.add(model);
                                      } else {
                                        _selectedStudents.remove(model);
                                      }
                                    });
                                  },
                                  activeColor: Colors.blue[800],
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
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
                    child: MyButton(
                      text: 'Save Changes',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AllocateSubject();
                          setState(() {
                            enrolledStudents.clear();
                            // _selectedStudents.clear();
                            _selectedSubject = null;
                          });
                          // showFlushbar(
                          //     context, 'Allocation Changes Successfully');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Subject allocation Changes Successfully')),
                          );
                        }
                      },
                      // child: const Text(
                      //   'Save subject allocations',
                      //   style: TextStyle(
                      //       fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
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
