import 'package:attendance_app/Theme.dart';
import 'package:flutter/material.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  var height, width;
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usercontroller = TextEditingController();
  TextEditingController subjectcontroller = TextEditingController();
  // late List<DropdownMenuItem<AddSUbjectReq>> subjectdropdownMenuItems;
  final _formKey = GlobalKey<FormState>();
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
                                      'Add Teachers',
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
                                  controller: usercontroller,
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
                                    child: Center(
                                        // child: DropdownButton(
                                        //   hint: const Text(
                                        //     'Select Subject',
                                        //   ),
                                        //   // value: teacherObj.selectedSubject,
                                        //   underline: SizedBox(),
                                        //   style: TextStyle(
                                        //       fontSize: width * 0.03,
                                        //       color: Colors.black),
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   // items: subjectdropdownMenuItems,
                                        //   isExpanded: false,
                                        //   // onChanged: teacherObj
                                        //       // .onSubjectChangeDropdownItem,
                                        // ),
                                        ),
                                  ),
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
                                    if (_formKey.currentState!.validate()) {
                                      // teacherObj.changeLoadingStatus(true);
                                      // AddTeacherReq model = AddTeacherReq(
                                      //     cnic: cniccontroller.text,
                                      //     fullName: usercontroller.text,
                                      //     password: passwordcontroller.text,
                                      //     rollId: 2,
                                      //     subject: teacherObj.subjectId);
                                      // teacherObj
                                      //     .addTeachermethod(model)
                                      //     .then((value) {
                                      //   if (value.responseMessge ==
                                      //       "Sign UP Successfully") {
                                      //     teacherObj.changeLoadingStatus(false);
                                      //     MyFlushBar.showSimpleFlushBar(
                                      //         'Teacher Added',
                                      //         context,
                                      //         MyTheme.primaryColor,
                                      //         MyTheme.whiteColor);
                                      //     teacherObj.getTeacherListMethod();
                                      //   } else if (value.responseMessge ==
                                      //       "Cnic Already Exsis") {
                                      //     teacherObj.changeLoadingStatus(false);
                                      //     MyFlushBar.showSimpleFlushBar(
                                      //         'Cnic Already Exsis',
                                      //         context,
                                      //         MyTheme.redColor,
                                      //         MyTheme.whiteColor);
                                      //   } else {
                                      //     teacherObj.changeLoadingStatus(false);
                                      //     MyFlushBar.showSimpleFlushBar(
                                      //         'Admin Added Failed',
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
                                    width: width * 0.3,
                                    child: Text(
                                      'Add Teacher',
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
                    'All Teachers',
                    style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w800,
                        color: MyTheme.primaryColor),
                  ),
                  Expanded(
                    child: Container(
                      height: height,
                      width: width * 0.9,
                      // child: teacherObj.allTeacherList.isEmpty
                      //     ? Center(child: const Text('Empty'))
                      // : ListView.builder(
                      child: ListView.builder(
                        // itemCount: teacherObj.allTeacherList.length,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shadowColor: MyTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: MyTheme.primaryColor,
                            child: SizedBox(
                              height: height * 0.12,
                              width: width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: height * 0.12,
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
                                              top: height * 0.01),
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
                                                              // '${teacherObj.allTeacherList[index].fullName}',
                                                              'Usama Mujahid teacher',
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
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: width * 0.07),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: height,
                                                  width: width * 0.3,
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
                                                            // '${teacherObj.allTeacherList[index].subject}',
                                                            'Web Development',
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
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: height,
                                                        width: width * 0.3,
                                                        child: Text(
                                                          // '${teacherObj.allTeacherList[index].cnic}',
                                                          '31101-0451947',
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
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
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
                                              //     .deleteTeacherMethod(
                                              //         teacherObj
                                              //             .allTeacherList[index]
                                              //             .userId!)
                                              //     .then((value) {
                                              //   if (value.responseMessge ==
                                              //       "User Delete Successfuly") {
                                              //     MyFlushBar.showSimpleFlushBar(
                                              //         'Department Delete Successfuly',
                                              //         context,
                                              //         MyTheme.primaryColor,
                                              //         MyTheme.whiteColor);

                                              //     AdminDrawerController.to
                                              //         .getTeacherListMethod();
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
            // teacherObj.isLoading == true
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
