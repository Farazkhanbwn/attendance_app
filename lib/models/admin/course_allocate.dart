// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseAllocate {
  final List<String>? students;
  final String? subjectname;
  CourseAllocate({
    this.students,
    this.subjectname,
  });

  CourseAllocate copyWith({
    List<String>? students,
    String? subjectname,
  }) {
    return CourseAllocate(
      students: students ?? this.students,
      subjectname: subjectname ?? this.subjectname,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'students': students,
      'subjectname': subjectname,
    };
  }

  factory CourseAllocate.fromMap(Map<String, dynamic> map) {
    return CourseAllocate(
      students: map['students'] != null
          ? List<String>.from((map['students'] as List<String>))
          : null,
      subjectname:
          map['subjectname'] != null ? map['subjectname'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAllocate.fromJson(String source) =>
      CourseAllocate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CourseAllocate(students: $students, subjectname: $subjectname)';

  @override
  bool operator ==(covariant CourseAllocate other) {
    if (identical(this, other)) return true;

    return listEquals(other.students, students) &&
        other.subjectname == subjectname;
  }

  @override
  int get hashCode => students.hashCode ^ subjectname.hashCode;
}
