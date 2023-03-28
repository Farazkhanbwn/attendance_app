import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/models/add_admin_model.dart';
import 'package:attendance_app/models/student/user_model.dart';
import 'package:attendance_app/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  // Map<String, TextEditingController> _controllers = {
  //   'namecontroller': TextEditingController(),
  //   'emailcontroller': TextEditingController(),
  //   'passwordcontroller': TextEditingController(),
  //   // add more controllers as needed
  // };

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController adminIdcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;

  // for dispose
  bool _emptyboxmail = false;
  bool _emptyboxpass = false;
  bool _emptyboxname = false;
  // for dispose
  bool _isObscure = true;
  bool _isObscure2 = true;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var width, height;
  final _formKey = GlobalKey<FormState>();

  final List<String> items = [
    'Teacher',
    'Student',
    'Admin',
  ];
  String? selectedValue;
  // var _currentItemSelected = "Admin";
  var _currentItemSelected;
  // var rool = "Admin";
  var rool;
  late String errorMessage;
  bool hasError = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

  // void signUp(String email, String password, String rool) async {
  //   CircularProgressIndicator();
  //   if (_formKey.currentState!.validate()) {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((value) => {postDetailsToFirestore(email, rool)})
  //         .catchError((e) {});
  //   }
  // }

  // postDetailsToFirestore(String email, String rool) async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   var user = _auth.currentUser;
  //   CollectionReference ref = FirebaseFirestore.instance.collection('users');
  //   ref.doc(user!.uid).set({'email': emailcontroller.text, 'rool': rool});
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => SignIn()));
  // }

  Future adduser() async {
    // if (namecontroller.text.isEmpty ||
    //     emailcontroller.text.isEmpty ||
    //     passwordcontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: 'All Fields Required',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0,
    //   );
    //   return;
    // }
    // for (var controller in _controllers) {
    //   if (controller.text.isEmpty) {
    //     setState(() {
    //       controller.clear();
    //       controller.text = '';
    //       controller.selection =
    //           TextSelection.fromPosition(TextPosition(offset: 0));
    //       hasError = true;
    //     });
    //   }
    // }
    // if (hasError) {
    //   Flushbar(
    //     title: 'Error',
    //     message: 'Please fill in all fields',
    //     duration: Duration(seconds: 3),
    //   ).show(context);
    // } else {
    //   // perform signup logic
    // }

    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      if (credential.user != null) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => SignIn(),
        //     ));
        Flushbar(
          maxWidth: width * 0.9,
          backgroundColor: Colors.black,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.all(3),
          message: 'SignUp Successfully',
          icon: const Icon(
            Icons.check_circle_outline,
            size: 28.0,
            color: Colors.black54,
          ),
          duration: Duration(seconds: 2),
          leftBarIndicatorColor: Colors.grey,
        ).show(context);

        postDataToFB();
        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        rool = null;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errorMessage = "invalid-email";
          break;
        case "wrong-password":
          errorMessage = "weak-password";
          break;
        case "email-already-in-use":
          errorMessage = "Email-already-in-use";
          break;
        case "user-disabled":
          errorMessage = "user-disabled";
          break;
        case "too-many-requests":
          errorMessage = "too-many-requests";
          break;
        case "operation-not-allowed":
          errorMessage = "operation-not-alloweda";
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
      // postDataToFB();

    }
  }

  // FirebaseFirestore instance = FirebaseFirestore.instance;
  postDataToFB() async {
    User? user = auth.currentUser;
    var id = user!.uid;
    UserModel model = UserModel(
        name: namecontroller.text,
        email: emailcontroller.text,
        password: passwordcontroller.text,
        role: rool,
        uid: id,
        adminId: adminIdcontroller.text);
    // CollectionReference<Map<String, dynamic>> teachersCollection = instance
    //     .collection('users')
    //     .doc(roleId.text.toString())
    //     .collection('teachers');
    // // Create a new teacher document in the subcollection with the teacherId
    // await teachersCollection.doc(id).set(model.toMap());

    // if (rool == 'Teacher') {
    //   await instance
    //       .collection('users')
    //       .doc('1')
    //       .collection('Teacher')
    //       .doc(emailcontroller.text)
    //       .set(model.toMap());
    // } else if (rool == 'Student') {
    //   await instance
    //       .collection('users')
    //       .doc('2')
    //       .collection('Student')
    //       .add(model.toMap());
    // } else {
    //   await instance
    //       .collection('users')
    //       .doc('3')
    //       .collection('Admin')
    //       .add(model.toMap());
    // }
    await instance
        .collection('users')
        .doc(emailcontroller.text.trim())
        .set(model.toMap());
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: MyTheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.8),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
            ),
            Form(
              key: _formKey,
              child: SizedBox(
                height: height * 0.6,
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
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.25),
                              child: Text(
                                'Register Now',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: namecontroller,
                            validator: (username) {
                              if (username!.isEmpty) {
                                return 'Plz Enter a Name';
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              // errorText: _emptyboxname
                              //     ? 'field cannot be empty'
                              //     : null,
                              border: InputBorder.none,
                              hintText: 'Name',
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            controller: emailcontroller,
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // errorText: _emptyboxmail
                              //     ? 'Email field cannot be empty'
                              //     : null,
                              hintText: 'Email',
                              suffixIcon: Icon(
                                Icons.card_membership,
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
                            obscureText: _isObscure,
                            controller: passwordcontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Password";
                              } else if (value.length < 8) {
                                return 'Write Minimum 8 Character password';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              // errorText: _emptyboxpass
                              //     ? 'password field cannot be empty'
                              //     : null,
                              border: InputBorder.none,
                              hintText: 'Password',
                              // focusedBorder: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //       color: Colors.deepPurple, width: 2.0),
                              //   borderRadius: BorderRadius.circular(10.0),
                              // ),
                              suffixIcon: IconButton(
                                  color: MyTheme.primaryColor,
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
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
                            width: width * 0.424,
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.02),
                              child: TextFormField(
                                // obscureText: _isObscure,
                                controller: adminIdcontroller,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Admin ID";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (value) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  // errorText: _emptyboxpass
                                  //     ? 'password field cannot be empty'
                                  //     : null,
                                  border: InputBorder.none,
                                  hintText: 'Admin ID',
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //       color: Colors.deepPurple, width: 2.0),
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                  suffixIcon: IconButton(
                                      color: MyTheme.primaryColor,
                                      icon: Icon(Icons.person),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.08,
                          width: width * 0.425,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // child: InputDecorator(
                            // decoration: InputDecoration(

                            // labelStyle: textStyle,

                            //     borderRadius: BorderRadius.circular(5.0)),
                            // ),
                            // isEmpty: _currentSelectedValue == '',
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.03, right: width * 0.02),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text('Select Role'),
                                  // underline: SizedBox(),

                                  iconEnabledColor: Colors.blue,
                                  iconSize: width * 0.06,
                                  isDense: true,
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    {
                                      print(newValue);
                                      setState(() {
                                        _currentItemSelected = newValue!;
                                        print('new value is ${newValue}');
                                        rool = newValue;
                                        print('new value is ${rool}');
                                        // state.didChange(newValue);
                                      });
                                    }
                                  },
                                  value: _currentItemSelected,
                                  items: items.map(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
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
                              if (emailcontroller.text.isEmpty
                                  ? _emptyboxmail = true
                                  : _emptyboxmail = false ||
                                          namecontroller.text.isEmpty
                                      ? _emptyboxname = true
                                      : _emptyboxname = false ||
                                              passwordcontroller.text.isEmpty ||
                                              rool == null
                                          ? _emptyboxpass = true
                                          : _emptyboxpass = false) {
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
                                adduser();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.06,
                              width: width * 0.3,
                              child: Text(
                                'Add User',
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
              'Faraz Khan',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w800,
                color: MyTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
