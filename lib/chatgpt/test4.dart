import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyScreens extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreens> {
  late String _selectedSubjectName = 'maths';
  List<String> _selectedStudents = [];
  List<String> enrolledStudents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Screen'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _selectedSubjectName,
            items: [
              DropdownMenuItem(value: 'maths', child: Text('Maths')),
              DropdownMenuItem(value: 'science', child: Text('Science')),
              DropdownMenuItem(value: 'english', child: Text('English')),
            ],
            hint: Text('Select a subject'),
            onChanged: (value) {
              setState(() {
                _selectedSubjectName = value!;
                _selectedStudents = []; // clear the list of selected students
              });
            },
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('role', isEqualTo: 'Student')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CheckboxListTile> studentCheckboxes =
                    snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  String studentEmail = data['email'];
                  String studentName = data['name'];

                  bool checked = _selectedStudents.contains(studentEmail);

                  return CheckboxListTile(
                    title: Text(studentName),
                    subtitle: Text(studentEmail),
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedStudents.add(studentEmail);
                        } else {
                          _selectedStudents.remove(studentEmail);
                        }
                      });
                    },
                  );
                }).toList();

                return Expanded(
                  child: ListView(
                    children: studentCheckboxes,
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_selectedSubjectName.isNotEmpty &&
                  _selectedStudents.isNotEmpty) {
                // Update the database with the allocation data
                await FirebaseFirestore.instance
                    .collection('subject_allocation')
                    .doc(_selectedSubjectName)
                    .set({'students': _selectedStudents});

                // Show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Subject allocated successfully')),
                );

                // Clear the selected subject and students
                setState(() {
                  _selectedSubjectName = '';
                  _selectedStudents = [];
                });
              } else {
                // Show an error message if the form is not filled out completely
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Please select a subject and at least one student')),
                );
              }
            },
            child: Text('Allocate'),
          ),
        ],
      ),
    );
  }
}
