import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/admin/add_user.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/testing/test1.dart';
import 'package:attendance_app/testing/test6.dart';
import 'package:attendance_app/teacher/course_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherView extends StatefulWidget {
  const TeacherView({super.key});

  @override
  State<TeacherView> createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> {
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
        title: const Text('Teacher Dashboard'),
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 236, 236, 236)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: Icon(
                Icons.logout,
                size: width * 0.05,
              )),
          SizedBox(
            width: width * 0.03,
          )
        ],
      ),
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
                    MaterialPageRoute(builder: (context) => CourseDisplay()));
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
                        'Enroll Courses',
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Dummy()));
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
                        'Attendance Record',
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
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Dummy()));
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
                        'ChatBox',
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
              height: height * 0.15,
            )
          ],
        ),
      ),
    );
  }
}
