import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Teacher_display.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/add_user.dart';
import 'package:attendance_app/admin/add_admin.dart';
import 'package:attendance_app/admin/admin_view.dart';
import 'package:attendance_app/button.dart';
import 'package:attendance_app/chatgpt/test1.dart';
import 'package:attendance_app/forget_pass.dart';
import 'package:attendance_app/recover_pass.dart';
import 'package:attendance_app/splash.dart';
import 'package:attendance_app/student/course_view.dart';
import 'package:attendance_app/student/student_view.dart';
import 'package:attendance_app/student_display.dart';
import 'package:attendance_app/teacher/course_display.dart';
import 'package:attendance_app/teacher/teacher_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'painter/painter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // ignore: prefer_typing_uninitialized_variables
  var width, height;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String errorMessage;
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  void signIn() async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (credential.user != null) {
        Staticdata.id = credential.user!.uid;
        print('${credential.user!.uid}');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubjectAllocationList()));
        // context,
        // MaterialPageRoute(builder: (context) => AddAdmin()));
        Flushbar(
          maxWidth: width * 0.8,
          backgroundColor: Colors.black,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(3),
          message: 'Login Succesfull',
          icon: const Icon(
            Icons.check_circle_outline,
            size: 28.0,
            color: Colors.black54,
          ),
          duration: const Duration(seconds: 2),
          leftBarIndicatorColor: Colors.grey,
        ).show(context);
        // postdatatoSP();
        route();
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "invalid-email";
          break;
        case "wrong-password":
          errorMessage = "wrong-password";
          break;
        case "user-not-found":
          errorMessage = "user-not-found";
          break;
        case "user-disabled":
          errorMessage = "user-disabled";
          break;
        case "too-many-requests":
          errorMessage = "too-many-requests";
          break;
        case "operation-not-allowed":
          errorMessage = "operation-not-allowed";
          break;
        default:
          errorMessage = "An error occured";
      }
      Flushbar(
        maxWidth: width * 0.9,
        backgroundColor: Colors.black,
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(3),
        message: errorMessage,
        icon: const Icon(
          Icons.check_circle_outline,
          size: 28.0,
          color: Colors.black54,
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.grey,
      ).show(context);
    }
  }

  // Future postdatatoSP() async {
  //   SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
  //   sharedprefrence.setString('UserID', Staticdata.id
  //       // key     value
  //       );
  // }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(emailController.text.trim())
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('document exist at this moment');
        if (documentSnapshot.get('role') == "Teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDisplay(),
              // builder: (context) => const TeacherDisplay(),
            ),
          );
        } else if (documentSnapshot.get('role') == 'Student') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDisplay(),
              // builder: (context) => StudentDisplay(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAdmin(),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  // void signIn(String email, String password) async {
  //   if (_formkey.currentState!.validate()) {
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text,
  //         password: passwordController.text,
  //       );
  //       route();
  //     } on FirebaseAuthException catch (error) {
  //       switch (error.code) {
  //         case "invalid-email":
  //           errorMessage = "invalid-email";
  //           break;
  //         case "wrong-password":
  //           errorMessage = "wrong-password";
  //           break;
  //         case "user-not-found":
  //           errorMessage = "user-not-found";
  //           break;
  //         case "user-disabled":
  //           errorMessage = "user-disabled";
  //           break;
  //         case "too-many-requests":
  //           errorMessage = "too-many-requests";
  //           break;
  //         case "operation-not-allowed":
  //           errorMessage = "operation-not-allowed";
  //           break;
  //         default:
  //           errorMessage = "An error occured";
  //       }
  //       Flushbar(
  //         maxWidth: width * 0.9,
  //         backgroundColor: Colors.black,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         margin: EdgeInsets.all(3),
  //         message: errorMessage,
  //         icon: Icon(
  //           Icons.check_circle_outline,
  //           size: 28.0,
  //           color: Colors.black54,
  //         ),
  //         duration: Duration(seconds: 2),
  //         leftBarIndicatorColor: Colors.grey,
  //       ).show(context);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
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
                padding: EdgeInsets.only(top: height * 0.07, left: width * 0.6),
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
              color: Color(0xffF8F8F8),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                          controller: emailController,
                          // maxLength: 10,
                          decoration: InputDecoration(
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
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width * 0.85,
                      height: height * 0.065,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
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
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: width * 0.08),
                        child: InkWell(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
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
                                // emailController.text,
                                // passwordController.text,
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
    );
  }
}

class Staticdata {
  static String? id;
}
