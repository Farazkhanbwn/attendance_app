// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseAllocate {
  final String? subjectname;
  final String? studentName;
  final String? studentid;
  final String? subjectblueId;
  CourseAllocate({
    this.subjectname,
    this.studentName,
    this.studentid,
    this.subjectblueId,
  });

  CourseAllocate copyWith({
    String? subjectname,
    String? studentName,
    String? studentid,
    String? subjectblueId,
  }) {
    return CourseAllocate(
      subjectname: subjectname ?? this.subjectname,
      studentName: studentName ?? this.studentName,
      studentid: studentid ?? this.studentid,
      subjectblueId: subjectblueId ?? this.subjectblueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectname': subjectname,
      'studentName': studentName,
      'studentid': studentid,
      'subjectblueId': subjectblueId,
    };
  }

  factory CourseAllocate.fromMap(Map<String, dynamic> map) {
    return CourseAllocate(
      subjectname:
          map['subjectname'] != null ? map['subjectname'] as String : null,
      studentName:
          map['studentName'] != null ? map['studentName'] as String : null,
      studentid: map['studentid'] != null ? map['studentid'] as String : null,
      subjectblueId:
          map['subjectblueId'] != null ? map['subjectblueId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAllocate.fromJson(String source) =>
      CourseAllocate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseAllocate(subjectname: $subjectname, studentName: $studentName, studentid: $studentid, subjectblueId: $subjectblueId)';
  }

  @override
  bool operator ==(covariant CourseAllocate other) {
    if (identical(this, other)) return true;

    return other.subjectname == subjectname &&
        other.studentName == studentName &&
        other.studentid == studentid &&
        other.subjectblueId == subjectblueId;
  }

  @override
  int get hashCode {
    return subjectname.hashCode ^
        studentName.hashCode ^
        studentid.hashCode ^
        subjectblueId.hashCode;
  }
}
