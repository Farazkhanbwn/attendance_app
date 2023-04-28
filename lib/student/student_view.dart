import 'package:attendance_app/admin/add_course.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/splash.dart';
import 'package:attendance_app/testing/test1.dart';
import 'package:attendance_app/student/course_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
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
              size: width * 0.06,
            ),
          ),
          SizedBox(
            width: width * 0.02,
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
            Container(
              width: width,
              height: height * 0.35,
              decoration: BoxDecoration(
                // color: Colors.amber,
                image: DecorationImage(
                    image: AssetImage('images/attendance2.png')),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCoursesPage()));
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
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 50,
                      ),
                      // leading: Icon(Icons.person),
                      title: Text(
                        'Enroll Courses',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        // textAlign: TextAlign.center,
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
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 50,
                      ),
                      // leading: Icon(Icons.person),
                      title: Text(
                        'Attendance Record',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        // textAlign: TextAlign.center,
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
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 50,
                      ),
                      // leading: Icon(Icons.person),
                      title: Text(
                        'ChatBox',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                        // textAlign: TextAlign.center,
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
