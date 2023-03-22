// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddStudent {
  String? name;
  String? cnic;
  String? rollno;
  String? semester;
  String? password;
  String? department;
  AddStudent({
    this.name,
    this.cnic,
    this.rollno,
    this.semester,
    this.password,
    this.department,
  });

  AddStudent copyWith({
    String? name,
    String? cnic,
    String? rollno,
    String? semester,
    String? password,
    String? department,
  }) {
    return AddStudent(
      name: name ?? this.name,
      cnic: cnic ?? this.cnic,
      rollno: rollno ?? this.rollno,
      semester: semester ?? this.semester,
      password: password ?? this.password,
      department: department ?? this.department,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cnic': cnic,
      'rollno': rollno,
      'semester': semester,
      'password': password,
      'department': department,
    };
  }

  factory AddStudent.fromMap(Map<String, dynamic> map) {
    return AddStudent(
      name: map['name'] != null ? map['name'] as String : null,
      cnic: map['cnic'] != null ? map['cnic'] as String : null,
      rollno: map['rollno'] != null ? map['rollno'] as String : null,
      semester: map['semester'] != null ? map['semester'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      department:
          map['department'] != null ? map['department'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStudent.fromJson(String source) =>
      AddStudent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddStudent(name: $name, cnic: $cnic, rollno: $rollno, semester: $semester, password: $password, department: $department)';
  }

  @override
  bool operator ==(covariant AddStudent other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.cnic == cnic &&
        other.rollno == rollno &&
        other.semester == semester &&
        other.password == password &&
        other.department == department;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cnic.hashCode ^
        rollno.hashCode ^
        semester.hashCode ^
        password.hashCode ^
        department.hashCode;
  }
}
