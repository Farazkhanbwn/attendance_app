import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/admin/course_class.dart';
import 'package:attendance_app/static_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TeacherController extends GetxController {
  static TeacherController get to => Get.find();
  List<Course> allTeacherCources = [];
  List<CourseAllocate> allocateStudenList = [];
  /////////////////////////////get teacher corses/////////
  Future<List<Course>> getCourseListMethod() async {
    allTeacherCources.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("course")
        .where("teacherID", isEqualTo: StaticValues.uid)
        .get();

    querySnapshot.docs.forEach((doc) {
      allTeacherCources.add(Course.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allTeacherCources;
  }

  /////////////////////////get course allocated student List///////////
  Future<List<CourseAllocate>> getAllocateListMethod(
      String? courseName, String courseId) async {
    allocateStudenList.clear();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("subject_allocations")
        .doc(courseName)
        .collection(courseId)
        .where("allocatestatus", isEqualTo: true)
        .get();
    querySnapshot.docs.forEach((doc) {
      allocateStudenList
          .add(CourseAllocate.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return allocateStudenList;
  }
}
