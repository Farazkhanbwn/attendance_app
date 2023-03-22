import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/models/add_subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List teachers = [];
  var height, width;
  TextEditingController coursecontroller = TextEditingController();
  TextEditingController coursercodecontroller = TextEditingController();
  TextEditingController teachercontroller = TextEditingController();
  TextEditingController adminIdcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // void _AddSubject(String subject, String coursecode, String teacher) {
  //   CollectionReference subject =
  //       FirebaseFirestore.instance.collection('Subject');

  //   subject.add({
  //     'subject': coursecontroller.text,
  //     'coursecode': coursercodecontroller.text,
  //     'Teacher': teachercontroller.text
  //   });
  //   Flushbar(
  //     title: "Subject",
  //     messageColor: Colors.white,
  //     backgroundColor: Colors.grey,
  //     message: "Course Add Successfully",
  //     duration: Duration(seconds: 3),
  //   )..show(context);
  //   coursecontroller.clear();
  //   coursercodecontroller.clear();
  //   teachercontroller.clear();
  // }

  SubjectAdd() async {
    AddSubject model = AddSubject(
      teachername: teachercontroller.text,
      subjectname: coursecontroller.text,
      coursecode: coursercodecontroller.text,
      adminId: adminIdcontroller.text,
    );

    await FirebaseFirestore.instance.collection('Subject').add(model.toMap());
    Flushbar(
      title: "Subject",
      messageColor: Colors.white,
      backgroundColor: Colors.grey,
      message: "Course Add Successfully",
      duration: Duration(seconds: 3),
    )..show(context);
    coursecontroller.clear();
    coursercodecontroller.clear();
    teachercontroller.clear();
    // adminIdcontroller.clear();
    print(teachers.length);
    print(teachers.toString());
    // setState(() {
    //   teachers = querySnapshot.docs.map((doc) => doc['name']).toList();
    //   // teachers = querySnapshot.docs.map((doc) => doc['name']).toList();
    // });
  }

  Future<void> getTeachers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('1')
        .collection('Teacher')
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      teachers = querySnapshot.docs.map((doc) => doc.data()).toList();
    }

    print(teachers.length);
    print(teachers.toString());
    // setState(() {
    //   teachers = querySnapshot.docs.map((doc) => doc['name']).toList();
    //   // teachers = querySnapshot.docs.map((doc) => doc['name']).toList();
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: height * 0.45,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.07,
                            width: width,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: MyTheme.primaryColor,
                                      size: width * 0.06,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.23),
                                    child: Text(
                                      'Add Subject',
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
                            height: height * 0.02,
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
                                  controller: coursecontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Invalid Credential';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Subject Name',
                                      suffixIcon: Icon(
                                        // FontAwesomeIcons.school,
                                        Icons.school,
                                        color: MyTheme.primaryColor,
                                        size: width * 0.05,
                                      )),
                                ),
                              ),
                            ),
                          ),

                          // SizedBox(
                          //   height: height * 0.01,
                          // ),
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
                                  controller: teachercontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Invalid Credential';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Teacher Name',
                                      suffixIcon: Icon(
                                        // FontAwesomeIcons.school,
                                        Icons.abc,
                                        color: MyTheme.primaryColor,
                                        size: width * 0.05,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.42,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.02),
                                    child: TextFormField(
                                      controller: coursercodecontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Invalid Credential';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Subject Code',
                                          suffixIcon: Icon(
                                            // FontAwesomeIcons.school,
                                            Icons.abc,
                                            color: MyTheme.primaryColor,
                                            size: width * 0.05,
                                          )),
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
                                  width: width * 0.42,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.02),
                                    child: TextFormField(
                                      controller: adminIdcontroller,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Invalid Credential';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Admin ID',
                                          suffixIcon: Icon(
                                            // FontAwesomeIcons.school,
                                            Icons.abc,
                                            color: MyTheme.primaryColor,
                                            size: width * 0.05,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                    // if (_formKey.currentState!.validate())
                                    {
                                      SubjectAdd(
                                          // coursecontroller.text,
                                          // coursercodecontroller.text,
                                          // teachercontroller.text,
                                          );
                                      // subObj.changeLoadingStatus(true);

                                      // subObj
                                      //     .addSubjectmethod(subjcontroller.text)
                                      //     .then((value) {
                                      //   subObj.changeLoadingStatus(true);

                                      //   if (value.responseMessge ==
                                      //       "Inserted Successfully") {
                                      //     subObj.changeLoadingStatus(false);
                                      //     subObj.getSubjectListMethod();
                                      //     MyFlushBar.showSimpleFlushBar(
                                      //         'Inserted Successfully',
                                      //         context,
                                      //         MyTheme.primaryColor,
                                      //         MyTheme.whiteColor);
                                      //     // adminObj.getAdminListMethod();
                                      //   } else {
                                      //     subObj.changeLoadingStatus(false);
                                      //     MyFlushBar.showSimpleFlushBar(
                                      //         'Inserted Successfully Failed',
                                      //         context,
                                      //         MyTheme.redColor,
                                      //         MyTheme.whiteColor);
                                      //   }
                                      // });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.06,
                                    width: width * 0.35,
                                    child: Text(
                                      'Add Subject',
                                      style: TextStyle(
                                          fontSize: width * 0.04,
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
                    'All Subjects',
                    style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w800,
                        color: MyTheme.primaryColor),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Subject')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                // return Text(doc['name']);
                                return ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(doc['teachername']),
                                  subtitle: Text(doc['subjectname']),
                                  trailing: Text(doc['coursecode']),
                                );
                              });
                        } else {
                          return Text("No data");
                        }
                      },
                    ),
                    // child: SizedBox(
                    //   height: height,
                    //   width: width * 0.9,
                    //   // child: subObj.allSubjectList.isEmpty
                    //   // ? const Center(child: Text('Empty'))
                    //   // :
                    //   child: ListView.builder(
                    //     // itemCount: subObj.allSubjectList.length,
                    //     itemCount: 4,
                    //     itemBuilder: (context, index) {
                    //       return Card(
                    //         elevation: 5,
                    //         shadowColor: MyTheme.primaryColor,
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         color: MyTheme.primaryColor,
                    //         child: SizedBox(
                    //           height: height * 0.08,
                    //           width: width,
                    //           child: Stack(
                    //             children: [
                    //               Container(
                    //                 height: height,
                    //                 width: width,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: const BorderRadius.only(
                    //                       bottomRight: Radius.circular(70),
                    //                       topLeft: Radius.circular(70),
                    //                     ),
                    //                     color: MyTheme.whiteColor),
                    //                 child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Padding(
                    //                       padding: EdgeInsets.only(
                    //                           top: height * 0.01),
                    //                       child: SizedBox(
                    //                         height: height * 0.06,
                    //                         width: width,
                    //                         child: Row(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.center,
                    //                           children: [
                    //                             Card(
                    //                               elevation: 4,
                    //                               shadowColor:
                    //                                   MyTheme.primaryColor,
                    //                               child: SizedBox(
                    //                                 height: height,
                    //                                 width: width * 0.7,
                    //                                 child: Row(
                    //                                   mainAxisAlignment:
                    //                                       MainAxisAlignment
                    //                                           .start,
                    //                                   children: [
                    //                                     Container(
                    //                                       alignment:
                    //                                           Alignment.center,
                    //                                       height: height,
                    //                                       width: width * 0.1,
                    //                                       child: Icon(
                    //                                         Icons.menu_book,
                    //                                         size: width * 0.05,
                    //                                         color: MyTheme
                    //                                             .primaryColor,
                    //                                       ),
                    //                                     ),
                    //                                     Expanded(
                    //                                       child: Container(
                    //                                         alignment: Alignment
                    //                                             .centerLeft,
                    //                                         height: height,
                    //                                         width: width,
                    //                                         child: Text(
                    //                                           // '${subObj.allSubjectList[index].subjectName}',
                    //                                           'Object Oriented Programming',
                    //                                           style: TextStyle(
                    //                                             fontSize:
                    //                                                 width *
                    //                                                     0.035,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .w500,
                    //                                           ),
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //               Align(
                    //                 alignment: Alignment.topRight,
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: InkWell(
                    //                     onTap: () {
                    //                       // DeleteController.to
                    //                       //     .deleteSubjectMethod(subObj
                    //                       //         .allSubjectList[index]
                    //                       //         .subjectId!)
                    //                       //     .then((value) {
                    //                       //   if (value.responseMessge ==
                    //                       //       'Subject Delete Successfuly') {
                    //                       //     MyFlushBar.showSimpleFlushBar(
                    //                       //         'Subject Delete Successfuly',
                    //                       //         context,
                    //                       //         MyTheme.primaryColor,
                    //                       //         MyTheme.whiteColor);

                    //                       //     AdminDrawerController.to
                    //                       //         .getSubjectListMethod();
                    //                       //   }
                    //                       // });
                    //                     },
                    //                     child: Container(
                    //                       height: height * 0.03,
                    //                       width: width * 0.06,
                    //                       decoration: BoxDecoration(
                    //                           border: Border.all(
                    //                               color: MyTheme.blackColor),
                    //                           shape: BoxShape.circle),
                    //                       child: Center(
                    //                         child: Icon(
                    //                           Icons.clear_rounded,
                    //                           color: MyTheme.blackColor,
                    //                           size: width * 0.045,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            // subObj.isLoading == true
            //     ? Container(
            //         height: height,
            //         width: width,
            //         color: MyTheme.primaryColor.withOpacity(0.2),
            //         child: SpinKit.loadSpinkit,
            //       )
            //     : const SizedBox()
          ],
        ),
      ),
    );
  }
}
