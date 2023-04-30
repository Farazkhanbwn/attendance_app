import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/flutsh&toast.dart/handleExceptonError.dart';
import 'package:attendance_app/models/add_admin_model.dart';
import 'package:attendance_app/models/student/user_model.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/string_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
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
        showFlushbar(context, 'Signup Succcessfully');
        postDataToFB();
        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        rool = null;
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(context, e);
      // postDataToFB();

    }
  }

  // FirebaseFirestore instance = FirebaseFirestore.instance;
  postDataToFB() async {
    User? user = auth.currentUser;
    var id = user!.uid;
    UserModel model = UserModel(
        name: namecontroller.text
            .split(' ')
            .map((word) => word.capitalize())
            .join(' '),
        email: emailcontroller.text,
        password: passwordcontroller.text,
        role: rool,
        uid: id,
        adminId: adminIdcontroller.text);

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
            Form(
              key: _formKey,
              child: SizedBox(
                height: height * 0.6,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.07,
                      width: width,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.05),
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
                            padding: EdgeInsets.only(left: width * 0.25),
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                  fontSize: width * 0.05,
                                  fontWeight: FontWeight.w800,
                                  color: MyTheme.primaryColor),
                            ),
                          ),
                        ],
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
                              hintStyle: TextStyle(color: MyTheme.blackColor),
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
                              hintStyle: TextStyle(color: MyTheme.blackColor),
                              suffixIcon: Icon(
                                Icons.email,
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
                              hintStyle: TextStyle(color: MyTheme.blackColor),
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
                                  hintStyle:
                                      TextStyle(color: MyTheme.blackColor),
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
                                  hint: Text(
                                    'Select Role',
                                    style: TextStyle(color: MyTheme.blackColor),
                                  ),
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
              'All Users',
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w800,
                color: MyTheme.primaryColor,
              ),
            ),
            Expanded(
                child: SizedBox(
              height: height,
              width: width * 0.9,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Center(child: Text('Empty')));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        // itemCount: stuObj.allStudentList.length,
                        itemBuilder: (context, index) {
                          final userData = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
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
                                                              (userData[
                                                                  'name']),
                                                              // 'Faraz khan',
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
                                                          (userData['adminId']),
                                                          // 'Faraz khan',
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
                                                        (userData['role']),
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
                                                          (userData['email']),
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
                                                      child: FaIcon(
                                                        FontAwesomeIcons.school,
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
                                                        'Computer Science',
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
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Confirm Deletion'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this user?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('CANCEL'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id)
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop();
                                                          showFlushbar(context,
                                                              'User Deleted Successfully');
                                                        },
                                                        child: const Text(
                                                            'DELETE'),
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
                      );
                    }
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
