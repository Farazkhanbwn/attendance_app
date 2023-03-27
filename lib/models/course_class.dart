// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Course {
  String courseName;
  String courseID;
  String adminID;
  String teacherName;
  Course({
    required this.courseName,
    required this.courseID,
    required this.adminID,
    required this.teacherName,
  });

  Course copyWith({
    String? courseName,
    String? courseID,
    String? adminID,
    String? teacherName,
  }) {
    return Course(
      courseName: courseName ?? this.courseName,
      courseID: courseID ?? this.courseID,
      adminID: adminID ?? this.adminID,
      teacherName: teacherName ?? this.teacherName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseName': courseName,
      'courseID': courseID,
      'adminID': adminID,
      'teacherName': teacherName,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      courseName: map['courseName'] as String,
      courseID: map['courseID'] as String,
      adminID: map['adminID'] as String,
      teacherName: map['teacherName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(courseName: $courseName, courseID: $courseID, adminID: $adminID, teacherName: $teacherName)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.courseName == courseName &&
        other.courseID == courseID &&
        other.adminID == adminID &&
        other.teacherName == teacherName;
  }

  @override
  int get hashCode {
    return courseName.hashCode ^
        courseID.hashCode ^
        adminID.hashCode ^
        teacherName.hashCode;
  }
}
