import 'package:attendance_app/Drawer_bar/drawerBody.dart';
import 'package:attendance_app/Drawer_bar/drawerHeading.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/admin/add_course.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/splash.dart';
import 'package:attendance_app/static_values.dart';
import 'package:attendance_app/student/controller/student_controller.dart';
import 'package:attendance_app/student/updat_blueId.dart';
import 'package:attendance_app/testing/test1.dart';
import 'package:attendance_app/student/course_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String blueId = '';
  String? _displayName;
  // flutterBlue flutterBlue = FlutterBlue.instance;
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                // auth.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.getKeys();
                await prefs.clear();
                //Staticdata.id = null;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _loadBluetoothId();
    Get.put(StudentController());
    super.initState();
    //_getCurrentUserName();
  }

  //

  /// Load Bluetooth ID for current student from Firebase database
  Future<void> _loadBluetoothId() async {
    DocumentSnapshot<Object?> studentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(StaticValues.uid)
        .get();
    if (studentSnapshot.exists) {
      Map<String, dynamic>? studentData =
          studentSnapshot.data() as Map<String, dynamic>?;
      if (studentData != null) {
        setState(() {
          blueId = studentData['blueID'];
          print('user bluetooth is equal to =${blueId.toString()}');

          if (blueId == null || blueId.isEmpty) {
            showAlertDialog(context);
          }
        });
      }
    } else
      (print('snapshot is equal to ${studentSnapshot.exists}'));
  }

  void showAlertDialog(BuildContext context) {
    String blueId = '';
    // Create a text controller to handle the user input
    TextEditingController _textController = TextEditingController();

    // Show the dialog box
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Bluetooth ID'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Please update your Bluetooth ID to continue:'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Bluetooth ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () async {
                String bluetoothId = _textController.text;
                if (bluetoothId.isNotEmpty) {
                  // Update the user's Bluetooth ID in Firebase database

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(StaticValues.uid)
                      .update({
                    'blueID': bluetoothId,
                  });
                  setState(
                    () {
                      blueId = bluetoothId;
                    },
                  );

                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showBluetoothDialog() async {
    // String? selectedId;
    showAlertDialog(BuildContext context) {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Alert"),
        content: const Text("This is an alert message!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // Scan for available Bluetooth devices

    // List<ScanResult> scanResults =
    //     await flutterBlue.scan(timeout: Duration(seconds: 10)).toList();

    // Build list of available Bluetooth devices
    // List<Widget> deviceList = [];
    // for (ScanResult result in scanResults) {
    //   BluetoothDevice device = result.device;
    //   deviceList.add(ListTile(
    //     title: Text(device.name.isEmpty ? 'Unknown device' : device.name),
    //     subtitle: Text(device.id.toString()),
    //     onTap: () {
    //       selectedId = device.id.toString();
    //       Navigator.pop(context);
    //     },
    //   ));
    // }

    // Show dialog box with list of devices
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Update Bluetooth ID'),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: deviceList,
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Cancel'),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //         TextButton(
    //           child: Text('Update'),
    //           onPressed: () async {
    //             if (selectedId != null) {
    //               // Store selected Bluetooth ID in Firebase database
    //               User? user = FirebaseAuth.instance.currentUser;
    //               if (user != null) {
    //                 await FirebaseFirestore.instance
    //                     .collection('users')
    //                     .doc(user.email)
    //                     .update({
    //                   'blueId': selectedId,
    //                 });
    //                 setState(() {
    //                   blueId = selectedId!;
    //                 });
    //               }
    //               Navigator.pop(context);
    //             }
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  StreamBuilder<DocumentSnapshot> getCurrentUserName() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final displayName = data['name'] ?? 'Name';

        return Text(
          displayName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        title: const Text('Student Dashboard'),
        centerTitle: true,

        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back,
        //       color: Color.fromARGB(255, 236, 236, 236)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: Icon(
              Icons.logout,
              size: width * 0.065,
            ),
          ),
          SizedBox(
            width: width * 0.01,
          )
        ],
      ),
      drawer: Drawer(
        width: width * 0.7,
        child: Column(children: [
          drawerHeader(context),
          UpdateBluetoothIdTile(),
          listTileRecord(context),
          listTileAbout(context),
          listTilePrivacyPolicy(context),
          listTileTerms(context),
        ]),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                height: height * 0.35,
                decoration: const BoxDecoration(
                  // color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage('images/attendance2.png')),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Divider(
                thickness: 1,
                color: Color.fromARGB(255, 216, 216, 216),
                endIndent: width * 0.03,
                indent: width * 0.03,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyCoursesPage(
                                name: _displayName.toString(),
                              )));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Container(
                      width: width * 0.12,
                      height: height * 0.09,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('images/enroll courses.png'),
                        // fit: BoxFit.fill,
                      )),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      'Enroll Courses',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.4,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: const Color.fromARGB(255, 7, 132, 235),
                      size: width * 0.07,
                    )
                  ],
                ),
                // child: Padding(
                //   padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                //   child: Padding(
                //     padding: EdgeInsets.all(width * 0.018),
                //     child: const ListTile(
                //       // tileColor: Colors.amber,
                //       trailing: Icon(
                //         Icons.keyboard_arrow_right,
                //         size: 50,
                //       ),
                //       // leading: Icon(Icons.person),
                //       title: Text(
                //         'Enroll Courses',
                //         style:
                //             TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                //         // textAlign: TextAlign.center,
                //       ),
                //       // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                //     ),
                //   ),
                // ),
              ),
              Divider(
                thickness: 1,
                color: Color.fromARGB(255, 216, 216, 216),
                endIndent: width * 0.03,
                indent: width * 0.03,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyCoursesPage()));
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.055,
                    ),
                    Container(
                      width: width * 0.12,
                      height: height * 0.09,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('images/record.png'),
                        // fit: BoxFit.fill,
                      )),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      'Attendance Record',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.32,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Color.fromARGB(255, 7, 132, 235),
                      size: width * 0.07,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                endIndent: width * 0.03,
                indent: width * 0.03,
                color: Color.fromARGB(255, 216, 216, 216),
              ),
              SizedBox(
                height: height * 0.15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
