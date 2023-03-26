import 'package:flutter/material.dart';

// Define the model classes for Course and Student
class Course {
  final String id;
  final String name;

  const Course({
    required this.id,
    required this.name,
  });
}

class Student {
  final String name;
  final int age;
  final Course course;

  const Student({
    required this.name,
    required this.age,
    required this.course,
  });
}

// Define the data for courses and students
final List<Course> _courses = [
  Course(id: '1', name: 'Mathematics'),
  Course(id: '2', name: 'Science'),
  Course(id: '3', name: 'History'),
];

final List<Student> _students = [
  Student(name: 'John', age: 20, course: _courses[0]),
  Student(name: 'Jane', age: 21, course: _courses[1]),
  Student(name: 'Bob', age: 22, course: _courses[2]),
];

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  Course? _selectedCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<Course>(
            value: _selectedCourse,
            items: _courses.map((course) {
              return DropdownMenuItem<Course>(
                value: course, // make sure each value is unique
                child: Text(course.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCourse = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Select a course',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                if (_selectedCourse != null &&
                    _selectedCourse!.id != student.course.id) {
                  return Container();
                }
                return ListTile(
                  title: Text(student.name),
                  subtitle: Text('Age: ${student.age}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
