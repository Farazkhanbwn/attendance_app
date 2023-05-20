import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/admin/course_class.dart';
import 'package:attendance_app/models/userModel.dart';
import 'package:attendance_app/static_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AdminController extends GetxController {
  static AdminController get to => Get.find();
  List<UserModel> allUsers = [];
  List<Course> allCources = [];
  List<UserModel> allTeachers = [];
  List<UserModel> allStudents = [];
  List<CourseAllocate> allocateStudenList = [];

  bool isDropdown = false;

  String? teacherName;
  String? teacherID;
  UserModel? selectedTeacher;

  String? courseName;
  String? courseID;
  Course? selectedCourse;

  FirebaseFirestore instance = FirebaseFirestore.instance;

  changeValue(bool v) {
    isDropdown = v;
    update();
  }

/////////////////////////////get profile /////////////////
  getProfileMethod() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: StaticValues.uid)
        .get();
    UserModel model =
        UserModel.fromMap(querySnapshot.docs[0].data() as Map<String, dynamic>);
    StaticValues.model = model;
    print(model);
    update();
  }

////////////////////////add user////////////////////////////
  addUsermethod(UserModel model, BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("users")
        .doc(model.userId)
        .set(model.toMap());
    showFlushbar(context, 'Inserted Successfully');
    getUserListMethod();
  }

/////////////////////////get All Users////////////////////
  Future<List<UserModel>> getUserListMethod() async {
    allUsers.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("users").get();

    querySnapshot.docs.forEach((doc) {
      allUsers.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allUsers;
  }

////////////////////////add user////////////////////////////
  addCourcemethod(Course model, BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore
        .collection("course")
        .doc(model.courseID)
        .set(model.toMap());
    showFlushbar(context, 'Inserted Successfully');
    getCourseListMethod();
  }

/////////////////////////get All cources////////////////////
  Future<List<Course>> getCourseListMethod() async {
    allCources.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("course").get();

    querySnapshot.docs.forEach((doc) {
      allCources.add(Course.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allCources;
  }

  ///////////////////////get All Teachers//////////////////////
  Future<List<UserModel>> getTeachersListMethod() async {
    allTeachers.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("userRoll", isEqualTo: "Teacher")
        .get();
    querySnapshot.docs.forEach((doc) {
      allTeachers.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allTeachers;
  }

  ///////////////////////get All Allocate Students//////////////////////
  Future<List<CourseAllocate>> getAllocateListMethod(
      String? courseName, String courseId) async {
    changeValue(true);
    allocateStudenList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("subject_allocations")
        .doc(courseName)
        .collection(courseId)
        .get();
    querySnapshot.docs.forEach((doc) {
      allocateStudenList
          .add(CourseAllocate.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allocateStudenList;
  }

  ///////////////////////update Allocate status//////////////////////
  updateAllocateStatusMethod(String? courseName, String courseId,
      String studentId, bool status, int index) async {
    await FirebaseFirestore.instance
        .collection("subject_allocations")
        .doc(courseName)
        .collection(courseId)
        .doc(studentId)
        .update({"allocatestatus": status});

    allocateStudenList[index].allocatestatus = status;
    update();

  }

  ///////////////////////get All Students//////////////////////
  Future<List<UserModel>> getStudentListMethod() async {
    allStudents.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("userRoll", isEqualTo: "Student")
        .get();
    querySnapshot.docs.forEach((doc) {
      allStudents.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allStudents;
  }

///////////////////////////////////////////Create Collections for SUbjects///////////////
  createCollection(List<Course> courseList, List<UserModel> studList) async {
    for (int i = 0; i < courseList.length; i++) {
      for (int j = 0; j < studList.length; j++) {
        var uuid = Uuid();
        String id = uuid.v4();
        CourseAllocate model = CourseAllocate(
          corseID: courseList[i].courseID,
          allocateId: id,
          allocatestatus: false,
          studentName: studList[j].userName,
          studentblueId: studList[j].blueID,
          studentid: studList[j].userId,
          subjectTeacher: courseList[i].teacherName,
          subjectname: courseList[i].courseName,
        );

        await instance
            .collection('subject_allocations')
            .doc(courseList[i].courseName)
            .collection(courseList[i].courseID)
            .doc(studList[j].userId)
            .set(model.toMap());
      }
    }
  }

///////////////////////////////////////////teacher Dropdown///////////////////
  List<DropdownMenuItem<UserModel>> buildTeacherDropdownMenuItems(
      List<UserModel> myTeacherList) {
    List<DropdownMenuItem<UserModel>> items = [];
    for (UserModel teacher in myTeacherList) {
      items.add(
        DropdownMenuItem(
          value: teacher,
          child: Text(teacher.userName!),
        ),
      );
    }
    return items;
  }

  onTeacherChangeDropdownItem(UserModel? mySelectedTeacher) {
    selectedTeacher = mySelectedTeacher;
    teacherName = mySelectedTeacher!.userName;
    teacherID = mySelectedTeacher.userId;
    print(teacherName);
    update();
  }

///////////////////////////////////////////Course Dropdown///////////////////
  List<DropdownMenuItem<Course>> buildCourseDropdownMenuItems(
      List<Course> myCourseList) {
    List<DropdownMenuItem<Course>> items = [];
    for (Course course in myCourseList) {
      items.add(
        DropdownMenuItem(
          value: course,
          child: Text(course.courseName),
        ),
      );
    }
    return items;
  }

  onCourseChangeDropdownItem(Course? mySelectedCourse) {
    selectedCourse = mySelectedCourse;
    courseName = mySelectedCourse!.courseName;
    courseID = mySelectedCourse.courseID;
    print(teacherName);
    getAllocateListMethod(
        mySelectedCourse.courseName, mySelectedCourse.courseID);
    update();
  }
}
