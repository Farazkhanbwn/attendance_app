// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddSubject {
  String teachername;
  String subjectname;
  String coursecode;
  String adminId;
  AddSubject({
    required this.teachername,
    required this.subjectname,
    required this.coursecode,
    required this.adminId,
  });

  AddSubject copyWith({
    String? teachername,
    String? subjectname,
    String? coursecode,
    String? adminId,
  }) {
    return AddSubject(
      teachername: teachername ?? this.teachername,
      subjectname: subjectname ?? this.subjectname,
      coursecode: coursecode ?? this.coursecode,
      adminId: adminId ?? this.adminId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'teachername': teachername,
      'subjectname': subjectname,
      'coursecode': coursecode,
      'adminId': adminId,
    };
  }

  factory AddSubject.fromMap(Map<String, dynamic> map) {
    return AddSubject(
      teachername: map['teachername'] as String,
      subjectname: map['subjectname'] as String,
      coursecode: map['coursecode'] as String,
      adminId: map['adminId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddSubject.fromJson(String source) =>
      AddSubject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddSubject(teachername: $teachername, subjectname: $subjectname, coursecode: $coursecode, adminId: $adminId)';
  }

  @override
  bool operator ==(covariant AddSubject other) {
    if (identical(this, other)) return true;

    return other.teachername == teachername &&
        other.subjectname == subjectname &&
        other.coursecode == coursecode &&
        other.adminId == adminId;
  }

  @override
  int get hashCode {
    return teachername.hashCode ^
        subjectname.hashCode ^
        coursecode.hashCode ^
        adminId.hashCode;
  }
}
