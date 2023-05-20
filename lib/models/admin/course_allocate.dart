// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseAllocate {
  String? corseID;
  String? allocateId;
  String? subjectname;
  String? subjectTeacher;
  String? studentName;
  String? studentid;
  String? studentblueId;
  bool? allocatestatus;
  CourseAllocate({
    this.corseID,
    this.allocateId,
    this.subjectname,
    this.subjectTeacher,
    this.studentName,
    this.studentid,
    this.studentblueId,
    this.allocatestatus,
  });

  CourseAllocate copyWith({
    String? corseID,
    String? allocateId,
    String? subjectname,
    String? subjectTeacher,
    String? studentName,
    String? studentid,
    String? studentblueId,
    bool? allocatestatus,
  }) {
    return CourseAllocate(
      corseID: corseID ?? this.corseID,
      allocateId: allocateId ?? this.allocateId,
      subjectname: subjectname ?? this.subjectname,
      subjectTeacher: subjectTeacher ?? this.subjectTeacher,
      studentName: studentName ?? this.studentName,
      studentid: studentid ?? this.studentid,
      studentblueId: studentblueId ?? this.studentblueId,
      allocatestatus: allocatestatus ?? this.allocatestatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'corseID': corseID,
      'allocateId': allocateId,
      'subjectname': subjectname,
      'subjectTeacher': subjectTeacher,
      'studentName': studentName,
      'studentid': studentid,
      'studentblueId': studentblueId,
      'allocatestatus': allocatestatus,
    };
  }

  factory CourseAllocate.fromMap(Map<String, dynamic> map) {
    return CourseAllocate(
      corseID: map['corseID'] != null ? map['corseID'] as String : null,
      allocateId:
          map['allocateId'] != null ? map['allocateId'] as String : null,
      subjectname:
          map['subjectname'] != null ? map['subjectname'] as String : null,
      subjectTeacher: map['subjectTeacher'] != null
          ? map['subjectTeacher'] as String
          : null,
      studentName:
          map['studentName'] != null ? map['studentName'] as String : null,
      studentid: map['studentid'] != null ? map['studentid'] as String : null,
      studentblueId:
          map['studentblueId'] != null ? map['studentblueId'] as String : null,
      allocatestatus:
          map['allocatestatus'] != null ? map['allocatestatus'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAllocate.fromJson(String source) =>
      CourseAllocate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseAllocate(corseID: $corseID, allocateId: $allocateId, subjectname: $subjectname, subjectTeacher: $subjectTeacher, studentName: $studentName, studentid: $studentid, studentblueId: $studentblueId, allocatestatus: $allocatestatus)';
  }

  @override
  bool operator ==(covariant CourseAllocate other) {
    if (identical(this, other)) return true;

    return other.corseID == corseID &&
        other.allocateId == allocateId &&
        other.subjectname == subjectname &&
        other.subjectTeacher == subjectTeacher &&
        other.studentName == studentName &&
        other.studentid == studentid &&
        other.studentblueId == studentblueId &&
        other.allocatestatus == allocatestatus;
  }

  @override
  int get hashCode {
    return corseID.hashCode ^
        allocateId.hashCode ^
        subjectname.hashCode ^
        subjectTeacher.hashCode ^
        studentName.hashCode ^
        studentid.hashCode ^
        studentblueId.hashCode ^
        allocatestatus.hashCode;
  }
}
