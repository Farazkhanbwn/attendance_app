// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectAllocation {
  final String? userEmail;
  final String? subjectId;
  final String? subjectName;
  SubjectAllocation({
    this.userEmail,
    this.subjectId,
    this.subjectName,
  });

  SubjectAllocation copyWith({
    String? userEmail,
    String? subjectId,
    String? subjectName,
  }) {
    return SubjectAllocation(
      userEmail: userEmail ?? this.userEmail,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userEmail': userEmail,
      'subjectId': subjectId,
      'subjectName': subjectName,
    };
  }

  factory SubjectAllocation.fromMap(Map<String, dynamic> map) {
    return SubjectAllocation(
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      subjectId: map['subjectId'] != null ? map['subjectId'] as String : null,
      subjectName:
          map['subjectName'] != null ? map['subjectName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectAllocation.fromJson(String source) =>
      SubjectAllocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubjectAllocation(userEmail: $userEmail, subjectId: $subjectId, subjectName: $subjectName)';

  @override
  bool operator ==(covariant SubjectAllocation other) {
    if (identical(this, other)) return true;

    return other.userEmail == userEmail &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName;
  }

  @override
  int get hashCode =>
      userEmail.hashCode ^ subjectId.hashCode ^ subjectName.hashCode;
}
