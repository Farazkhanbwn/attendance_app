import 'package:attendance_app/models/admin/course_allocate.dart';
import 'package:attendance_app/models/admin/course_class.dart';
import 'package:attendance_app/static_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class StudentController extends GetxController {
  static StudentController get to => Get.find();
  List<Course> AllCourseList = [];

  List<CourseAllocate> myAllCorces = [];

/////////////////////////get All cources////////////////////
  Future<List<Course>> getCourseListMethod() async {
    AllCourseList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("course").get();

    querySnapshot.docs.forEach((doc) {
      AllCourseList.add(Course.fromMap(doc.data() as Map<String, dynamic>));
    });
    update();

    return AllCourseList;
  }

/////////////////////////get My cources////////////////////
  Future<List<CourseAllocate>> getMyCourseListMethod(List<Course> list) async {
    myAllCorces.clear();
    for (int i = 0; i < list.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("subject_allocations")
          .doc(list[i].courseName)
          .collection(list[i].courseID)
          .where("studentid", isEqualTo: StaticValues.uid)
          .get();
      CourseAllocate model = CourseAllocate.fromMap(
          querySnapshot.docs[0].data() as Map<String, dynamic>);

      if (model.allocatestatus == true) {
        myAllCorces.add(model);
      }
    }

    update();

    return myAllCorces;
  }
}
