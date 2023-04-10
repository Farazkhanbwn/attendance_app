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

  Future<void> _updateEnrolledStudents() async {
    // retrieve the list of enrolled students for the selected subject
    DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection('subject_allocation')
        .doc(_selectedSubjectName)
        .get();
    if (studentSnapshot.exists) {
      enrolledStudents = List<String>.from(
          (studentSnapshot.data() as Map<String, dynamic>)['students']);
    }
    print('enrolled students are following ${enrolledStudents}');
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
                            _selectedSubject = value;
                            _selectedSubjectName = (snapshot.data!.docs
                                .firstWhere((doc) => doc.id == _selectedSubject)
                                .data() as Map<String, dynamic>)['courseName'];
                            // print(
                            //     'The selected subject is = ${_selectedSubjectName.toString()}');
                          },
                        );

                        if (_selectedSubject == null ||
                            _selectedSubject is! String) {
                          // handle the error, such as displaying an error message or returning null
                          return null;
                        }

                        // build the list of checkboxes for all students, marking those already enrolled as checked
                        //   List<CheckboxListTile> studentCheckboxes =
                        //       snapshot.data!.docs.map((doc) {
                        //     Map<String, dynamic> data =
                        //         doc.data() as Map<String, dynamic>;
                        //     String studentId = doc.id;
                        //     print('student id =${studentId}');

                        //     bool checked = enrolledStudents.contains(studentId);

                        //     return CheckboxListTile(
                        //       title: Text(data['name'] ?? ''),
                        //       value: checked,
                        //       onChanged: (value) {
                        //         setState(
                        //           () {
                        //             if (value != null) {
                        //               if (value) {
                        //                 enrolledStudents.add(studentId);
                        //                 print(
                        //                     'enrolled students is = ${enrolledStudents}');
                        //               } else {
                        //                 enrolledStudents.remove(studentId);
                        //               }
                        //             }
                        //           },
                        //         );
                        //       },
                        //     );
                        //   }).toList();
                        // },
                        List<CheckboxListTile> buildStudentCheckboxes() {
                          // build the list of checkboxes for all students, marking those already enrolled as checked
                          return snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            String studentId = doc.id;

                            bool checked = enrolledStudents.contains(studentId);

                            return CheckboxListTile(
                              title: Text(data['name'] ?? ''),
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    if (value) {
                                      enrolledStudents.add(studentId);
                                      print(
                                          'enrolled students is = ${enrolledStudents}');
                                    } else {
                                      enrolledStudents.remove(studentId);
                                    }
                                  }
                                });
                              },
                            );
                          }).toList();
                        }
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
                              //  && _selectedStudents.contains(studentName),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    // _selectedStudents.add(studentName);
                                    _selectedStudents.add(studentName);
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
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('subject_allocation')
                            .doc(_selectedSubjectName)
                            .set({
                          'subjectName': _selectedSubjectName,
                          'students': _selectedStudents,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Subject allocations saved')),
                        );
                      },
                      child: Text('Allocate Subject'),
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
