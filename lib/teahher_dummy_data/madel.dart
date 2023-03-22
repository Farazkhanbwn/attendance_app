import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String id;
  final String name;
  final String email;
  final List<Subject> subjects;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.subjects,
  });

  static Teacher fromFirestore(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // List<dynamic> subjectsData = data['subjects'] ?? [];
    final subjectsData = data['subjects'] ?? [];
    final subjects = subjectsData
        .map((subjectData) => Subject.fromMap(subjectData))
        .toList()
        .cast<Subject>();
    // List<Subject> subjects = subjectsData
    //     .map((subjectData) => Subject.fromMap(subjectData))
    //     .toList();
    return Teacher(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      subjects: subjects,
    );
  }
}

class Subject {
  String subjectId;
  String subjectName;
  List<String> students;

  Subject(
      {required this.subjectId,
      required this.subjectName,
      required this.students});

  factory Subject.fromMap(Map<String, dynamic> map) {
    final studentsData = map['students'] ?? [];
    final students = List<String>.from(studentsData);

    return Subject(
      subjectId: map['subjectId'],
      subjectName: map['subjectName'],
      students: students,
    );
  }
}

// class Subject {
//   final String id;
//   final String name;
//   final String teacherId;
//   final List<String> studentIds;

//   Subject({
//     required this.id,
//     required this.name,
//     required this.teacherId,
//     required this.studentIds,
//   });
// }
