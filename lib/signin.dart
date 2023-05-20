import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/admin/add_user.dart';
import 'package:attendance_app/admin/add_admin.dart';
import 'package:attendance_app/admin/admin_view.dart';
import 'package:attendance_app/button.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/flutsh&toast.dart/handleExceptonError.dart';
import 'package:attendance_app/models/userModel.dart';
import 'package:attendance_app/showAlert.dart';
import 'package:attendance_app/static_values.dart';
import 'package:attendance_app/testing/test1.dart';
import 'package:attendance_app/forget_pass.dart';
import 'package:attendance_app/recover_pass.dart';
import 'package:attendance_app/splash.dart';
import 'package:attendance_app/student/course_view.dart';
import 'package:attendance_app/student/student_view.dart';
import 'package:attendance_app/teacher/course_display.dart';
import 'package:attendance_app/teacher/teacher_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'painter/painter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // ignore: prefer_typing_uninitialized_variables
  bool _obscureText = true;
  var width, height;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  void signIn(String email, String pass) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .where("password", isEqualTo: pass)
        .get();
    UserModel model =
        UserModel.fromMap(querySnapshot.docs[0].data() as Map<String, dynamic>);
    saveDataToSharedPref(model.userId!, model.userRoll!);
    // ignore: use_build_context_synchronously

    if (model.userRoll == "Admin") {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AdminView()),
          (Route<dynamic> route) => false,
        );
        showFlushbar(context, "Login successfully");
      });
    }
    if (model.userRoll == "Student") {
      Future.delayed(const Duration(seconds: 2), () {
        // Staticdata.id = user!.uid;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StudentView()),
          (Route<dynamic> route) => false,
        );
        showFlushbar(context, "Login successfully");
      });
    }
    if (model.userRoll == "Teacher") {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TeacherView()),
          (Route<dynamic> route) => false,
        );
        showFlushbar(context, "Login successfully");
      });
    }
    print(model);
    // try {
    //   showAlertDialog(context);

    //   UserCredential credential = await auth.signInWithEmailAndPassword(
    //       email: emailController.text, password: passwordController.text);
    //   if (credential.user != null) {
    //     Staticdata.id = credential.user!.uid;
    //     print(' your user id is = ${credential.user!.uid}');
    //     route();

    //     // postdatatoSP();

    //   }
    // } on FirebaseAuthException catch (error) {
    //   Navigator.pop(context);
    //   handleFirebaseAuthException(context, error);
    // }
  }

  // Future postdatatoSP() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   sharedprefrence.setString('UserID', Staticdata.id
  //       // key     value
  //       );
  // }
  saveDataToSharedPref(String userId, String userRoll) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UserId", userId);
    prefs.setString("userRoll", userRoll);
    StaticValues.uid = userId;
    StaticValues.roll = userRoll;
  }

  // void route() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var kk = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(emailController.text.trim())
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) async {
  //     if (documentSnapshot.exists) {
  //       print('document exist at this moment');

  //       if (documentSnapshot.get('role') == "Teacher") {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => TeacherView()),
  //           (Route<dynamic> route) => false,
  //         );
  //         // Store role in shared preferences
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('role', 'Teacher');
  //         // showFlushbar(context, 'Login Successfull');
  //       } else if (documentSnapshot.get('role') == 'Student') {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => const StudentView()),
  //           (Route<dynamic> route) => false,
  //         );
  //         // Store role in shared preferences
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('role', 'Student');
  //         // showFlushbar(context, 'Login Successfull');
  //       } else {
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => AdminView()),
  //           (Route<dynamic> route) => false,
  //         );
  //         // Store role in shared preferences
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('role', 'Admin');
  //         // showFlushbar(context, 'Login Successfull');
  //       }
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Column(children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.4,
                    width: width,
                    child: CustomPaint(
                      painter: Painter(),
                    ),
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         colors: <Color>[MyTheme.blackColor, MyTheme.background])),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.07, left: width * 0.6),
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.15,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage('images/complain.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.3, left: width * 0.03),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: width * 0.075,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          // fontFamily: GoogleFonts.sanchez().fontFamily,
                          color: Color.fromARGB(255, 224, 224, 224)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: width * 0.65),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w500,
                      color: MyTheme.text),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Expanded(
                child: Container(
                  width: width,
                  height: height,
                  color: const Color(0xffF8F8F8),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            controller: emailController,
                            // maxLength: 10,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 10.0, 16.0),
                              border: InputBorder.none,
                              hintText: 'E-mail',
                              suffixIcon: const Icon(Icons.email),
                              // labelText: 'Enter Email',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04,
                                color: const Color.fromRGBO(34, 34, 34, 0.5),
                              ), /*labelText: 'Enter your email'*/
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Email";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Invalid Format";
                              }
                              return null;
                            },
                          ),
                        ),
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
                            controller: passwordController,
                            obscureText: _obscureText,

                            // maxLength: 10,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            // autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 10.0, 16.0),
                              border: InputBorder.none,
                              hintText: 'Password',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              // labelText: 'Enter Email',
                              hintStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: width * 0.04,
                                color: const Color.fromRGBO(34, 34, 34, 0.5),
                              ), /*labelText: 'Enter your email'*/
                            ),
                            // validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "Enter Your Password";
                            //     } else if (value.length < 8) {
                            //       return 'Write Minimum 8 Character password';
                            //     }
                            //     return null;
                            //   },

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Password";
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Invalid Format";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: width * 0.85,
                        //   height: height * 0.065,
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xffFFFFFF),
                        //     borderRadius: BorderRadius.circular(10),
                        //     boxShadow: const [
                        //       BoxShadow(
                        //         color: Color.fromRGBO(0, 0, 0, 0.08),
                        //         blurRadius: 15,
                        //         offset: Offset(0, 13), // Shadow position
                        //       ),
                        //     ],
                        //   ),
                        //child:
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: width * 0.06, right: width * 0.06),
                        //   child: Card(
                        //     elevation: 07,
                        //     child: TextFormField(
                        //       obscureText: _obscureText,
                        //       keyboardType: TextInputType.text,
                        //       controller: passwordController,
                        //       // autofocus: true,
                        //       // autovalidateMode:
                        //       //     AutovalidateMode.onUserInteraction,
                        //       decoration: InputDecoration(
                        //         suffixIcon: GestureDetector(
                        //           onTap: () {
                        //             setState(() {
                        //               _obscureText = !_obscureText;
                        //             });
                        //           },
                        //           child: Icon(_obscureText
                        //               ? Icons.visibility_off
                        //               : Icons.visibility),
                        //         ),
                        //         border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(20),
                        //           borderSide: const BorderSide(
                        //             width: 0,
                        //             style: BorderStyle.none,
                        //           ),
                        //         ),
                        //         contentPadding: const EdgeInsets.fromLTRB(
                        //             20.0, 17.0, 10.0, 17.0),
                        //         hintText: 'Password',
                        //         hintStyle: TextStyle(
                        //           fontFamily: 'Montserrat',
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: width * 0.04,
                        //           color: const Color.fromRGBO(34, 34, 34, 0.5),
                        //         ), /*labelText: 'Enter your email'*/
                        //       ),
                        //       // validator: (value) {
                        //       //   if (value!.isEmpty) {
                        //       //     return "Enter Your Password";
                        //       //   } else if (value.length < 8) {
                        //       //     return 'Write Minimum 8 Character password';
                        //       //   }
                        //       //   return null;
                        //       // },
                        //       // validator: (value) {
                        //       //   if (value!.isEmpty) {
                        //       //     return "Enter Your Email";
                        //       //   } else if (!RegExp(
                        //       //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //       //       .hasMatch(value)) {
                        //       //     return "Invalid Format";
                        //       //   }
                        //       //   return null;
                        //       // },
                        //       //     ),
                        //     ),
                        //   ),
                        // ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: width * 0.08),
                            child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword(),
                                  ),
                                );
                              }),
                              child: const Text(
                                'Forget Password?',
                              ),
                            ),
                          ),
                        ),
                        MyButton(
                            text: 'SignIn',
                            onPressed: (() {
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Plz Fill all Fields',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                signIn(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                              // signIn();
                            })),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: width * 0.85,
                        //   height: height * 0.065,
                        //   decoration: BoxDecoration(
                        //       color: Colors.blue,
                        //       borderRadius: BorderRadius.circular(05)),
                        //   child: Text(
                        //     'SIGN IN',
                        //     style: TextStyle(
                        //       fontSize: width * 0.045,
                        //       fontWeight: FontWeight.w500,
                        //       color: const Color(0xffF8F8F8),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: width,
                          height: height * 0.15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class Staticdata {
  static String? id;
}
