import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/models/add_student.dart';
import 'package:attendance_app/models/static_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  var height, width;
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();
  TextEditingController rollNocontroller = TextEditingController();
  TextEditingController semestercontroller = TextEditingController();
  TextEditingController departmentcontroller = TextEditingController();

  // late List<DropdownMenuItem<GetDepartModel>> departdropdownMenuItems;
  final _formKey = GlobalKey<FormState>();

  Addstudent() async {
    String id = Uuid().v4();
    print(id);
    AddStudent Addmodel = AddStudent(
      cnic: cniccontroller.text,
      name: namecontroller.text,
      password: passwordcontroller.text,
      semester: semestercontroller.text,
      rollno: rollNocontroller.text,
      department: departmentcontroller.text,

      // senderid: Staticdata.loginuser!.uid,
      // sendername: Staticdata.loginuser!.name,
      // status: 'pending',
      // time: DateFormat.jm().format(DateTime.now()));
      // rollId: id,
    );
    // Sender
    await FirebaseFirestore.instance
        .collection("Students")
        .doc()
        .collection("student List")
        .doc(id)
        .set(Addmodel.toMap());
    print('Hello world dummy flushbar');
    Flushbar(
      maxWidth: width * 0.9,
      backgroundColor: Colors.black,
      flushbarPosition: FlushbarPosition.TOP,
      margin: EdgeInsets.all(3),
      message: 'Add Student Successfully',
      icon: const Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: Colors.black54,
      ),
      duration: Duration(seconds: 2),
      leftBarIndicatorColor: Colors.grey,
    ).show(context);
    // checkUserStatus(receiverId);
    // Is Clicked
    // await FirebaseFirestore.instance
    //     .collection("friendlist")
    //     .doc(clickid)
    //     .collection("friends")
    //     .doc(id)
    //     .set(model.toMap());
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
                      height: height * 0.53,
                      width: width,
                      child: Column(
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
                                        EdgeInsets.only(left: width * 0.25),
                                    child: Text(
                                      'Add Students',
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
                                  keyboardType: TextInputType.number,
                                  controller: namecontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Invalid Credential';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Student Name',
                                      suffixIcon: Icon(
                                        Icons.person,
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
                              width: width * 0.85,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.only(left: width * 0.02),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: cniccontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Invalid Credential';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'CNIC',
                                      suffixIcon: Icon(
                                        Icons.card_membership,
                                        color: MyTheme.primaryColor,
                                        size: width * 0.05,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.08,
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.02),
                                      child: TextFormField(
                                        controller: rollNocontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Invalid Credential';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Roll No',
                                            suffixIcon: Icon(
                                              Icons.format_list_numbered,
                                              color: MyTheme.primaryColor,
                                              size: width * 0.05,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  width: width,
                                )),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.02),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: semestercontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Invalid Credential';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Smester',
                                            suffixIcon: Icon(
                                              // FontAwesomeIcons.book,
                                              Icons.book,
                                              color: MyTheme.primaryColor,
                                              size: width * 0.05,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.08,
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.02),
                                      child: TextFormField(
                                        controller: passwordcontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Invalid Credential';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            suffixIcon: Icon(
                                              Icons.lock,
                                              color: MyTheme.primaryColor,
                                              size: width * 0.05,
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  width: width,
                                )),
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    height: height * 0.07,
                                    width: width * 0.4,
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.02),
                                      child: TextFormField(
                                        controller: departmentcontroller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Invalid Credential';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Select department',
                                            suffixIcon: Icon(
                                              Icons
                                                  .local_fire_department_outlined,
                                              color: MyTheme.primaryColor,
                                              size: width * 0.05,
                                            )),
                                      ),
                                    ),
                                  ),
                                  // child: Container(
                                  //   height: height * 0.07,
                                  //   width: width * 0.4,
                                  //   color: Colors.transparent,
                                  //   child: Center(
                                  //     child: Text(
                                  //       'Select Department',
                                  //       style:
                                  //           TextStyle(fontSize: width * 0.03),
                                  //     ),
                                  //     // child: textButton(
                                  //     //   hint: const Text(
                                  //     //     'Select Depart',
                                  //     //   ),
                                  //     // value: stuObj.selectedDeaprt,
                                  //     //   underline: SizedBox(),
                                  //     //   style: TextStyle(
                                  //     //       fontSize: width * 0.03,
                                  //     //       color: Colors.black),
                                  //     //   borderRadius:
                                  //     //       BorderRadius.circular(10),
                                  //     //   // items: departdropdownMenuItems,
                                  //     //   isExpanded: false,
                                  //     //   // onChanged:
                                  //     //   //     stuObj.onDepartChangeDropdownItem,
                                  //     // ),
                                  //   ),
                                  // ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
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
                                    Addstudent();
                                    // if (_formKey.currentState!.validate()) {
                                    // stuObj.changeLoadingStatus(true);
                                    // // AddStudentReq model = AddStudentReq(
                                    //     cnic: cniccontroller.text,
                                    //     fullName: usercontroller.text,
                                    //     password: passwordcontroller.text,
                                    //     // department: stuObj.departId,
                                    //     rollnumber: rollNocontroller.text,
                                    //     semester: smestercontroller.text,
                                    //     rollId: 3;
                                    //     // );
                                    // stuObj
                                    //     .addStudentmethod(model)
                                    //     .then((value) {
                                    //   stuObj.changeLoadingStatus(true);
                                    //   if (value.responseMessge ==
                                    //       "Sign UP Successfully") {
                                    //     stuObj.changeLoadingStatus(false);
                                    //     MyFlushBar.showSimpleFlushBar(
                                    //         'Admin Added',
                                    //         context,
                                    //         MyTheme.primaryColor,
                                    //         MyTheme.whiteColor);
                                    //     stuObj.getStudentListMethod();
                                    //   } else if (value.responseMessge ==
                                    //       "Cnic Already Exsis") {
                                    //     stuObj.changeLoadingStatus(false);
                                    //     MyFlushBar.showSimpleFlushBar(
                                    //         'Cnic Already Exsis',
                                    //         context,
                                    //         MyTheme.redColor,
                                    //         MyTheme.whiteColor);
                                    //   } else {
                                    //     stuObj.changeLoadingStatus(false);
                                    //     MyFlushBar.showSimpleFlushBar(
                                    //         'Admin Added Failed',
                                    //         context,
                                    //         MyTheme.redColor,
                                    //         MyTheme.whiteColor);
                                    //   }
                                    // });
                                    // }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: height * 0.06,
                                    width: width * 0.3,
                                    child: Text(
                                      'Add Student',
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
                    'All Students',
                    style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w800,
                        color: MyTheme.primaryColor),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height,
                      width: width * 0.9,
                      // child: stuObj.allStudentList.isEmpty
                      // ? const Center(child: Text('Empty'))
                      child: ListView.builder(
                        itemCount: 5,
                        // itemCount: stuObj.allStudentList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shadowColor: MyTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: MyTheme.primaryColor,
                            child: SizedBox(
                              height: height * 0.18,
                              width: width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: height * 0.18,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(70),
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                Card(
                                                  elevation: 4,
                                                  shadowColor:
                                                      MyTheme.primaryColor,
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
                                                              Alignment.center,
                                                          height: height,
                                                          width: width * 0.1,
                                                          child: Icon(
                                                            Icons.person,
                                                            size: width * 0.05,
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
                                                              // '${stuObj.allStudentList[index].fullName}',
                                                              'Farz Liaquat',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.035,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: height,
                                                width: width * 0.35,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height,
                                                      width: width * 0.1,
                                                      child: Icon(
                                                        Icons
                                                            .format_list_numbered,
                                                        size: width * 0.05,
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
                                                          // '${stuObj.allStudentList[index].rollNo}',
                                                          'Abudllah FAM2BA009',

                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
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
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height,
                                                      width: width * 0.1,
                                                      child: Icon(
                                                        Icons.credit_card,
                                                        size: width * 0.05,
                                                        color: MyTheme
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: height,
                                                      width: width * 0.3,
                                                      child: Text(
                                                        // '${stuObj.allStudentList[index].cnic}',
                                                        '31101101419452',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.035,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                        SizedBox(
                                          height: height * 0.05,
                                          width: width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: height,
                                                width: width * 0.35,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height,
                                                      width: width * 0.1,
                                                      child: Icon(
                                                        Icons.menu_book,
                                                        size: width * 0.05,
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
                                                          // '${stuObj.allStudentList[index].semester}',
                                                          '8th Semester M2',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  width * 0.035,
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
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: height,
                                                      width: width * 0.1,
                                                      // child: Fa
                                                      child: Icon(
                                                        // FontAwesomeIcons
                                                        Icons.school,
                                                        size: width * 0.05,
                                                        color: MyTheme
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: height,
                                                      width: width * 0.3,
                                                      child: Text(
                                                        // '${stuObj.allStudentList[index].departmentName}',
                                                        'Department of Computer science',
                                                        style: TextStyle(
                                                            fontSize:
                                                                width * 0.035,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: height * 0.03,
                                        width: width * 0.06,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyTheme.blackColor),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              // DeleteController.to
                                              //     .deleteStudentMethod(
                                              //         stuObj
                                              //             .allStudentList[
                                              //                 index]
                                              //             .userId!)
                                              //     .then((value) {
                                              //   if (value
                                              //           .responseMessge ==
                                              //       "User Delete Successfuly") {
                                              //     MyFlushBar.showSimpleFlushBar(
                                              //         'Student Delete Successfuly',
                                              //         context,
                                              //         MyTheme
                                              //             .primaryColor,
                                              //         MyTheme
                                              //             .whiteColor);

                                              //     AdminDrawerController
                                              //         .to
                                              //         .getStudentListMethod();
                                              //   }
                                              // });
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
                      ),
                    ),
                  )
                ],
              ),
            ),
            // stuObj.isLoading == true
            // ?
            // Container(
            //   height: height,
            //   width: width,
            //   color: MyTheme.primaryColor.withOpacity(0.2),
            //   // child: SpinKit.loadSpinkit,
            // )
            // : const SizedBox()
          ],
        ),
      ),
    );
  }
}
