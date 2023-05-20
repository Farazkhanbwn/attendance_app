import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/models/admin/course_class.dart';
import 'package:attendance_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

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
  late List<DropdownMenuItem<UserModel>> teacherdropdownMenuItems;
  @override
  void initState() {
    // AdminController.to.getTeachersListMethod();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AdminController>(initState: (state) {
          AdminController.to.getCourseListMethod();
          AdminController.to.getTeachersListMethod().then((value) {
            teacherdropdownMenuItems =
                AdminController.to.buildTeacherDropdownMenuItems(value);
          });

          teacherdropdownMenuItems = AdminController.to
              .buildTeacherDropdownMenuItems(AdminController.to.allTeachers);
        }, builder: (obj) {
          return SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.05, left: width * 0.06),
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
                            padding: const EdgeInsets.only(),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * 0.00),
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
                                  padding: EdgeInsets.only(left: width * 0.23),
                                  child: Text(
                                    'Add Courses',
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        fontWeight: FontWeight.w800,
                                        color: MyTheme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                  hintStyle:
                                      TextStyle(color: MyTheme.blackColor),
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

                        const SizedBox(height: 16.0),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: width * 0.85,
                            height: height * 0.07,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton(
                                hint: const Text(
                                  'Select Teacher',
                                ),
                                value: obj.selectedTeacher,
                                underline: SizedBox(),
                                style: TextStyle(
                                    fontSize: width * 0.04,
                                    color: Colors.black),
                                iconEnabledColor: MyTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                items: teacherdropdownMenuItems,
                                isExpanded: true,
                                onChanged: obj.onTeacherChangeDropdownItem,
                              ),
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
                                    var uuid = Uuid();
                                    String id = uuid.v4();
                                    Course newCourse = Course(
                                      courseName:
                                          _courseNameController.text.trim(),
                                      courseID: id,
                                      teacherID: obj.teacherID!,
                                      teacherName: obj.teacherName!,
                                    );
                                    obj.addCourcemethod(newCourse, context);
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
                Text(
                  'All Courses',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w800,
                    color: MyTheme.primaryColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Expanded(
                    child: SizedBox(
                        height: height,
                        width: width * 0.9,
                        child: obj.allCources.isEmpty
                            ? const Center(child: Text('Empty'))
                            : ListView.builder(
                                itemCount: obj.allCources.length,
                                // itemCount: stuObj.allStudentList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 5,
                                    shadowColor: MyTheme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: MyTheme.primaryColor,
                                    child: SizedBox(
                                      height: height * 0.14,
                                      width: width,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: height * 0.18,
                                            width: width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(70),
                                                  topLeft: Radius.circular(70),
                                                ),
                                                color: MyTheme.whiteColor),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.02),
                                                  child: SizedBox(
                                                    height: height * 0.06,
                                                    width: width,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Card(
                                                          elevation: 4,
                                                          shadowColor: MyTheme
                                                              .primaryColor,
                                                          child: SizedBox(
                                                            height: height,
                                                            width: width * 0.7,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height:
                                                                      height,
                                                                  width: width *
                                                                      0.1,
                                                                  child: Icon(
                                                                    Icons
                                                                        .menu_book,
                                                                    size: width *
                                                                        0.05,
                                                                    color: MyTheme
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    height:
                                                                        height,
                                                                    width:
                                                                        width,
                                                                    child: Text(
                                                                      obj
                                                                          .allCources[
                                                                              index]
                                                                          .courseName,
                                                                      // 'Faraz khan',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            width *
                                                                                0.035,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.05,
                                                  width: width,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: height,
                                                        width: width * 0.35,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.04,
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: height,
                                                              width:
                                                                  width * 0.1,
                                                              child: Icon(
                                                                Icons
                                                                    .format_list_numbered,
                                                                size: width *
                                                                    0.05,
                                                                color: MyTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                height: height,
                                                                width: width,
                                                                child: Text(
                                                                  'Faraz khan',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.035,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: MyTheme
                                                                          .greycolor),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height,
                                                        width: width * 0.5,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.05,
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: height,
                                                              width:
                                                                  width * 0.1,
                                                              child: Icon(
                                                                Icons
                                                                    .credit_card,
                                                                size: width *
                                                                    0.05,
                                                                color: MyTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              height: height,
                                                              width:
                                                                  width * 0.3,
                                                              child: Text(
                                                                // '${stuObj.allStudentList[index].cnic}',
                                                                ('Mr ${obj.allCources[index].teacherName}'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.035,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: MyTheme
                                                                        .greycolor),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: height * 0.03,
                                                width: width * 0.06,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            MyTheme.blackColor),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Confirm Deletion"),
                                                            content: const Text(
                                                                "Are you sure you want to delete this course?"),
                                                            actions: [
                                                              TextButton(
                                                                child: const Text(
                                                                    "Cancel"),
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                              ),
                                                              TextButton(
                                                                child: const Text(
                                                                    "Delete"),
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'course')
                                                                      .doc(obj
                                                                          .allCources[
                                                                              index]
                                                                          .courseID)
                                                                      .delete();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  showFlushbar(
                                                                      context,
                                                                      'Course Deleted Successfully');
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.clear_rounded,
                                                      color: MyTheme.blackColor,
                                                      size: width * 0.045,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ))),
              ],
            ),
          );
        }),
      ),
    );
  }
}
