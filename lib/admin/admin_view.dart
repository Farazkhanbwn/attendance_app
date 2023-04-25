import 'package:attendance_app/Drawer_bar/drawerMain.dart';
import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/admin/add_user.dart';
import 'package:attendance_app/admin/add_course.dart';
import 'package:attendance_app/admin/allocation_subject_student.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
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
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyTheme.background,
      appBar: AppBar(
        backgroundColor: MyTheme.background,
        shadowColor: Colors.grey,
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (() {
              _logout();
            }),
            icon: Icon(
              Icons.logout,
              size: width * 0.06,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: width * 0.04,
          )
        ],
        iconTheme: const IconThemeData(color: Colors.blue),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back,
        //       color: Color.fromARGB(255, 236, 236, 236)),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      drawer: navigationDrawer(context),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dummy()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.018),
                    child: const ListTile(
                      // leading: Icon(Icons.person),
                      title: Text(
                        'Add New User',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CourseScreen()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.018),
                    child: const ListTile(
                      // leading: Icon(Icons.person),
                      title: Text(
                        'Create Course',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(context,
            //     //       MaterialPageRoute(builder: (context) => const Dummy()));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            //     child: Card(
            //       elevation: 5,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       // margin: EdgeInsets.all(20),
            //       child: Padding(
            //         padding: EdgeInsets.all(width * 0.018),
            //         child: const ListTile(
            //           // leading: Icon(Icons.person),
            //           title: Text(
            //             'Allocate Course to Teacher',
            //             style: TextStyle(
            //                 fontSize: 22, fontWeight: FontWeight.w500),
            //             textAlign: TextAlign.center,
            //           ),
            //           // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectToStudents()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.018),
                    child: const ListTile(
                      // leading: Icon(Icons.person),
                      title: Text(
                        'Allocate Course To Student',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
