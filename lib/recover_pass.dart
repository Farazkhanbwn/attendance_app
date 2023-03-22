import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'utils/header.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Header(
              height: height * 0.4,
              width: width,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.65,
                width: width,
                decoration: BoxDecoration(
                  color: MyTheme.background,
                  // color: Color.fromARGB(255, 241, 241, 241),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height * 0.07,
                      width: width,
                      child: Text(
                        'Recover Password',
                        style: TextStyle(
                          fontSize: width * 0.07,
                          // color: MyTheme.lightblue,
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.1,
                      width: width * 0.7,
                      child: Text(
                        ' Plese Enter Your Password Twise So We Can Verify You Typed It Correctly',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: width * 0.03,
                            color: MyTheme.greycolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.85,
                            height: height * 0.065,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              // color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.08),
                                  blurRadius: 15,
                                  offset: Offset(0, 13), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: TextFormField(
                                // controller: emailController,
                                // maxLength: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'New Password',
                                  // labelText: 'Enter Email',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * 0.04,
                                      color: const Color.fromRGBO(34, 34, 34,
                                          0.5)), /*labelText: 'Enter your email'*/
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width * 0.85,
                            height: height * 0.065,
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
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: TextFormField(
                                // controller: emailController,
                                // maxLength: 10,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Confirm Password',
                                  // labelText: 'Enter Email',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * 0.04,
                                      color: const Color.fromRGBO(34, 34, 34,
                                          0.5)), /*labelText: 'Enter your email'*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    MyButton(text: 'Recover', onPressed: () {}),
                    // Card(
                    //   color: MyTheme.lightblue,
                    //   elevation: 15,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30)),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => RecoverPassword(),
                    //           ));
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       height: height * 0.07,
                    //       width: width * 0.5,
                    //       child: Text(
                    //         'Recover',
                    //         style: TextStyle(
                    //             fontSize: width * 0.045,
                    //             color: MyTheme.whiteColor,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
