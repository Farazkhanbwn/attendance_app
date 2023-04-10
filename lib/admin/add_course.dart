import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/models/courses/course_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _courseNameController = TextEditingController();
  final _courseIdController = TextEditingController();
  final _adminIdController = TextEditingController();
  String _selectedTeacher = '';
  List<String> _teachers = [];
  String? _selectedSubject;
  String? _selectedSubjectName;

  @override
  void initState() {
    super.initState();
    _fetchTeachers();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // Call the function to get teacher names from database
  //   getTeacherNames();
  // }

  // Future<void> getTeacherNames() async {
  //   final teachers = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('1')
  //       .collection('Teacher')
  //       .get();
  //   List<String> names = [];
  //   teachers.docs.forEach((doc) {
  //     names.add(doc.data()['name']);
  //   });
  //   // List<String> names = snapshot.docs
  //   //   .map((doc) => doc.data()['name'].toString())
  //   //   .toList();
  //   if (names.toSet().toList().length != names.length) {
  //     // Handle duplicates
  //   }
  // }

  Future<void> _fetchTeachers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            // .collection('users')
            // .doc('1')
            // .collection('Teacher')
            // .get();
            .collection('users')
            .where('role', isEqualTo: 'Teacher')
            .get();
    print('the list are give ${snapshot.docs}');

    setState(() {
      _teachers =
          snapshot.docs.map((doc) => doc.data()['name'].toString()).toList();
      print('The teacher name are ${_teachers}');
      if (_teachers.isNotEmpty) {
        _selectedTeacher = _teachers[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Add Course'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.2, left: width * 0.06),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: height * 0.07,
                width: width,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.25),
                        child: Text(
                          'Add Courses',
                          style: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w800,
                              color: MyTheme.lightblue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height * 0.07,
                  width: width * 0.85,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _courseNameController,
                      validator: (username) {
                        if (username!.isEmpty) {
                          return 'Plz Enter Course Name';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // labelText: 'Course Name',
                        // labelStyle: TextStyle(color: MyTheme.greycolor),
                        hintText: 'Course Name',
                        hintStyle: TextStyle(color: MyTheme.greycolor),
                        suffixIcon: Icon(
                          Icons.person,
                          color: MyTheme.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height * 0.07,
                  width: width * 0.85,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _courseIdController,
                      validator: (username) {
                        if (username!.isEmpty) {
                          return 'Plz Enter Course ID';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // labelText: 'Course Name',
                        // labelStyle: TextStyle(color: MyTheme.greycolor),
                        hintText: 'Course ID',
                        hintStyle: TextStyle(color: MyTheme.greycolor),
                        suffixIcon: Icon(
                          Icons.accessibility,
                          color: MyTheme.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: height * 0.07,
                  width: width * 0.85,
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _adminIdController,
                      validator: (username) {
                        if (username!.isEmpty) {
                          return 'Plz Enter Admin ID';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // labelText: 'Course Name',
                        // labelStyle: TextStyle(color: MyTheme.greycolor),
                        hintText: 'Admin ID',
                        hintStyle: TextStyle(color: MyTheme.greycolor),
                        suffixIcon: Icon(
                          Icons.add_road,
                          color: MyTheme.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: width * 0.85,
                  height: height * 0.07,
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        // .collection('users')
                        // .doc('1')
                        // .collection('Teacher')
                        // .get(),
                        .collection('users')
                        .where('role', isEqualTo: 'Teacher')
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      return Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.018),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration.collapsed(hintText: ''),

                          // decoration: const InputDecoration(
                          //   enabledBorder: InputBorder.none,

                          // // isCollapsed: true,
                          // ),
                          value: _selectedSubject,
                          items: snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> data =
                                doc.data() as Map<String, dynamic>;
                            return DropdownMenuItem<String>(
                              value: doc.id,
                              child: Text(data['name']),
                            );
                          }).toList(),
                          hint: const Text(
                            'Select a Teacher',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedSubject = value;
                              _selectedSubjectName = (snapshot.data!.docs
                                      .firstWhere(
                                          (doc) => doc.id == _selectedSubject)
                                      .data()
                                  as Map<String, dynamic>)['courseName'];
                              print(
                                  'The selected teacjer is = ${_selectedSubjectName.toString()}');
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a subject';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Card(
              //   elevation: 5,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Container(
              //     height: height * 0.07,
              //     width: width * 0.85,
              //     child: DropdownButton<String>(
              //       hint: const Text('Select'),
              //       value: _selectedTeacher,
              //       items: _teachers
              //           .map(
              //             (teacher) => DropdownMenuItem<String>(
              //                 value: teacher, child: Text(teacher)),
              //           )
              //           .toList(),
              //       onChanged: (value) {
              //         setState(
              //           () {
              //             _selectedTeacher = value!;
              //           },
              //         );
              //       },
              //     ),
              //   ),
              //   // child: Container(
              //   //   height: height * 0.07,
              //   //   width: width * 0.85,
              //   //   color: Colors.transparent,
              //   //   child: Padding(
              //   //     padding: EdgeInsets.only(left: width * 0.02),
              //   //     child: TextFormField(
              //   //       autovalidateMode: AutovalidateMode.onUserInteraction,
              //   //       controller: _adminIdController,
              //   //       validator: (username) {
              //   //         if (username!.isEmpty) {
              //   //           return 'Plz Enter Admin ID';
              //   //         } else
              //   //           return null;
              //   //       },
              //   //       decoration: InputDecoration(
              //   //           border: InputBorder.none,
              //   //           // labelText: 'Course Name',
              //   //           // labelStyle: TextStyle(color: MyTheme.greycolor),
              //   //           hintText: 'Admin ID',
              //   //           hintStyle: TextStyle(color: MyTheme.greycolor)),
              //   //     ),
              //   //   ),
              //   // ),
              // ),
              // Container(
              //   child: DropdownButton<String>(
              //     hint: const Text('Select'),
              //     value: _selectedTeacher,
              //     items: _teachers
              //         .map(
              //           (teacher) => DropdownMenuItem<String>(
              //               value: teacher, child: Text(teacher)),
              //         )
              //         .toList(),
              //     onChanged: (value) {
              //       setState(() {
              //         _selectedTeacher = value!;
              //       });
              //     },
              //   ),
              // ),
              // DropdownButtonFormField<String>(
              //   decoration: InputDecoration(labelText: 'Teacher'),
              //   value: _selectedTeacher,
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedTeacher = value.toString();
              //       // print('select teahcer is = ${_selectedTeacher}');
              //     });
              //   },
              //   items: _teacherNames.map((teacher) {
              //     return DropdownMenuItem(
              //       value: teacher,
              //       child: Text(teacher),
              //     );
              //   }).toList(),
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.05),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    color: MyTheme.primaryColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Add new course to Firestore
                          Course newCourse = Course(
                            courseName: _courseNameController.text.trim(),
                            courseID: _courseIdController.text.trim(),
                            adminID: _adminIdController.text.trim(),
                            teacherName: _selectedTeacher,
                          );
                          FirebaseFirestore.instance
                              .collection('courses')
                              .doc()
                              .set(newCourse.toMap())
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Course Added Successfully')),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())),
                            );
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.06,
                        width: width * 0.3,
                        child: Text(
                          'Add Course',
                          style: TextStyle(
                              fontSize: width * 0.045,
                              color: MyTheme.whiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
