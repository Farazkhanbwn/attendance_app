import 'package:attendance_app/admin/add_user.dart';
import 'package:attendance_app/admin/add_admin.dart';
import 'package:attendance_app/admin/add_course.dart';
import 'package:attendance_app/admin/admin_view.dart';
import 'package:attendance_app/admin/allocation_subject_student.dart';
import 'package:attendance_app/admin/student_page.dart';
import 'package:attendance_app/testing/test1.dart';
import 'package:attendance_app/testing/test6.dart';
import 'package:attendance_app/forget_pass.dart';
import 'package:attendance_app/recover_pass.dart';
import 'package:attendance_app/signin.dart';
import 'package:attendance_app/signin1.dart';
import 'package:attendance_app/signup1.dart';
import 'package:attendance_app/splash.dart';
import 'package:attendance_app/student_display.dart';
import 'package:attendance_app/teacher/EnrollStudents.dart';
import 'package:attendance_app/teacher/course_display.dart';
import 'package:attendance_app/teacher/teacher_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // void _showAddSubjectScreen() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddSubjectScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          // Splash(),
          const SignIn(),
          // SignIn1(),
          // ForgetPassword(),
          // RecoverPassword(),
          // AddAdmin(),
          // StudentPage(),
          // TeacherPage(),
          // AdminView(),
          // CourseScreen(),
          // AllocateSubjectForm(),
          SubjectToStudents(),
          CoursesShow7(),
          // MyScreens(),
          // CheckboxListScreen(),
          // MyScreen(),
          // SubjectPage(),
          // CoursesShow1(),
          // CoursesShow6(),
          // StudentDisplay(),
          // DummyTeacherScreen(),
          // AllocateSubjectFormN(),
          const Dummy(),
          // const TeacherView(),
          // const Dummy1(),
          // Not Used this page // TeacherDropdown2(),
          CourseScreen(),
          // const keyboardVisibility(),
          // CoursesShow6(),
          // AllocateSubjectForm()
          // SubjectPage(),
          //  Erro //AddSubjectScreen(),
          // Not Used This Page //Register(),
          // const StudentDisplay(),
        ],
      ),
    );
  }
}
