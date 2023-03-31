import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SubjectAllocation {
  final String? userEmail;
  final String? subjectId;
  final String? subjectName;
  final List<String>? subjectNamesList;
  final String? studentName;
  SubjectAllocation({
    this.userEmail,
    this.subjectId,
    this.subjectName,
    this.subjectNamesList,
    this.studentName,
  });

  SubjectAllocation copyWith({
    String? userEmail,
    String? subjectId,
    String? subjectName,
    List<String>? subjectNamesList,
    String? studentName,
  }) {
    return SubjectAllocation(
      userEmail: userEmail ?? this.userEmail,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      subjectNamesList: subjectNamesList ?? this.subjectNamesList,
      studentName: studentName ?? this.studentName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'subjectNamesList': subjectNamesList,
      'studentName': studentName,
    };
  }

  factory SubjectAllocation.fromMap(Map<String, dynamic> map) {
    return SubjectAllocation(
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      subjectId: map['subjectId'] != null ? map['subjectId'] as String : null,
      subjectName:
          map['subjectName'] != null ? map['subjectName'] as String : null,
      subjectNamesList: map['subjectNamesList'] != null
          ? List<String>.from((map['subjectNamesList'] as List<String>))
          : null,
      studentName:
          map['studentName'] != null ? map['studentName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectAllocation.fromJson(String source) =>
      SubjectAllocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubjectAllocation(userEmail: $userEmail, subjectId: $subjectId, subjectName: $subjectName, subjectNamesList: $subjectNamesList, studentName: $studentName)';
  }

  @override
  bool operator ==(covariant SubjectAllocation other) {
    if (identical(this, other)) return true;

    return other.userEmail == userEmail &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName &&
        listEquals(other.subjectNamesList, subjectNamesList) &&
        other.studentName == studentName;
  }

  @override
  int get hashCode {
    return userEmail.hashCode ^
        subjectId.hashCode ^
        subjectName.hashCode ^
        subjectNamesList.hashCode ^
        studentName.hashCode;
  }
}
