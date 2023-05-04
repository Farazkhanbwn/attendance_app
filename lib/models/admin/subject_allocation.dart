// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseAllocation {
  final String name;
  final int rollno;
  final String blueId;
  CourseAllocation({
    required this.name,
    required this.rollno,
    required this.blueId,
  });

  CourseAllocation copyWith({
    String? name,
    int? rollno,
    String? blueId,
  }) {
    return CourseAllocation(
      name: name ?? this.name,
      rollno: rollno ?? this.rollno,
      blueId: blueId ?? this.blueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rollno': rollno,
      'blueId': blueId,
    };
  }

  factory CourseAllocation.fromMap(Map<String, dynamic> map) {
    return CourseAllocation(
      name: map['name'] as String,
      rollno: map['rollno'] as int,
      blueId: map['blueId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseAllocation.fromJson(String source) =>
      CourseAllocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CourseAllocation(name: $name, rollno: $rollno, blueId: $blueId)';

  @override
  bool operator ==(covariant CourseAllocation other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.rollno == rollno &&
        other.blueId == blueId;
  }

  @override
  int get hashCode => name.hashCode ^ rollno.hashCode ^ blueId.hashCode;
}
