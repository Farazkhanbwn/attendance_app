import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/button.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/recover_pass.dart';
import 'package:attendance_app/utils/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController newpasscontroller = TextEditingController();
  TextEditingController newpassconfirmcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool passwordvisible = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Password reset email sent");
      showFlushbar(context, 'Password reset email send');
    } catch (error) {
      print("Error sending password reset email: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${error}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Stack(children: [
            Header(
              height: height * 0.4,
              width: width,
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.05, left: width * 0.05),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: width * 0.07,
                  color: Colors.white,
                ),
              ),
            )
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Form(
              key: _formKey,
              child: Container(
                height: height * 0.65,
                width: width,
                decoration: const BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height * 0.1,
                      width: width,
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                            fontSize: width * 0.07,
                            color: MyTheme.text,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width,
                      child: Text(
                        'Enter Your E-mail To Recover Pasword',
                        style: TextStyle(
                            fontSize: width * 0.03,
                            color: MyTheme.greycolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    SizedBox(
                      height: height * 0.07,
                      width: width * 0.85,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.85,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.08),
                                  blurRadius: 15,
                                  offset: Offset(0, 13), // Shadow position
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: emailcontroller,
                              // maxLength: 10,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 10.0, 16.0),
                                border: InputBorder.none,
                                hintText: 'E-mail',
                                // labelText: 'Enter Email',
                                hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: width * 0.04,
                                    color: const Color.fromRGBO(34, 34, 34,
                                        0.5)), /*labelText: 'Enter your email'*/
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Invalid Credentials';
                                }
                                return null;
                              },
                              // controller: usernamecontroller,
                            ),
                          ),
                          // Container(
                          //   height: height * 0.05,
                          //   width: width * 0.8,
                          //   color: Colors.white,
                          //   child: TextFormField(
                          //     // controller: emailController,
                          //     // maxLength: 10,
                          //     decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       hintText: 'E-mail',
                          //       // labelText: 'Enter Email',
                          //       hintStyle: TextStyle(
                          //           fontFamily: 'Montserrat',
                          //           fontWeight: FontWeight.w400,
                          //           fontSize: width * 0.04,
                          //           color: const Color.fromRGBO(34, 34, 34,
                          //               0.5)), /*labelText: 'Enter your email'*/
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'Invalid Credentials';
                          //       }
                          //       return null;
                          //     },
                          //     controller: usernamecontroller,
                          //     // decoration:
                          //     //     const InputDecoration(hintText: 'CNIC'),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // Card(
                    //   color: MyTheme.lightblue,
                    //   elevation: 0,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: InkWell(
                    //     onTap: () {
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //       builder: (context) => RecoverPassword(),
                    //       //     ));
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       height: height * 0.07,
                    //       width: width * 0.5,
                    //       child: Text(
                    //         'Verify',
                    //         style: TextStyle(
                    //             fontSize: width * 0.045,
                    //             color: MyTheme.whiteColor,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    MyButton(
                      text: 'Reset',
                      onPressed: () {
                        resetPassword(emailcontroller.text);
                        // auth.sendPasswordResetEmail(
                        //     email: emailcontroller.text);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const RecoverPassword()));

                        // Handle button press event here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
