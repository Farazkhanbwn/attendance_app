import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllocateSubjectForm extends StatefulWidget {
  @override
  _AllocateSubjectFormState createState() => _AllocateSubjectFormState();
}

class _AllocateSubjectFormState extends State<AllocateSubjectForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSubject;
  String? _selectedSubjectName;
  List<String> _selectedStudents = [];
  CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Drop-down for selecting subject
                FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('courses').get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    return DropdownButtonFormField<String>(
                      value: _selectedSubject,
                      items: snapshot.data!.docs.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return DropdownMenuItem<String>(
                          value: doc.id,
                          child: Text(data['courseName']),
                        );
                      }).toList(),
                      hint: const Text('Select a subject'),
                      onChanged: (value) {
                        setState(() {
                          _selectedSubject = value;
                          _selectedSubjectName = (snapshot.data!.docs
                              .firstWhere((doc) => doc.id == _selectedSubject)
                              .data() as Map<String, dynamic>)['courseName'];
                          print(
                              'The selected subject is = ${_selectedSubjectName.toString()}');
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a subject';
                        }
                        return null;
                      },
                    );
                  },
                ),
                // Container(
                //   child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                //     stream:
                //         usersRef.where('role', isEqualTo: 'Student').snapshots(),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                //             snapshot) {
                //       if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       }

                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Text('Loading...');
                //       }

                //       List<DropdownMenuItem<String>> items = [];

                //       // Loop through the documents in the snapshot and add each user to the dropdown list
                //       for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
                //           in snapshot.data!.docs) {
                //         String userEmail = docSnapshot.id;
                //         String role = docSnapshot.get('role');
                //         String userName = docSnapshot.get('name');
                //         String userFullName = '$userName ($userEmail)';

                //         items.add(DropdownMenuItem<String>(
                //           value: userEmail,
                //           child: Text(userFullName),
                //         ));
                //       }
                //       return DropdownButton<String>(
                //         items: items,
                //         onChanged: (String? value) {
                //           // Do something with the selected value, such as update a variable or call a function
                //         },
                //         hint: const Text('Select a user'),
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    child: const Text('Allocate Subject'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Allocate subject to selected students
                        CollectionReference allocationsRef = FirebaseFirestore
                            .instance
                            .collection('subject_allocations');
                        _selectedStudents.forEach((studentId) {
                          allocationsRef.add({
                            'student_id': studentId,
                            'subject_id': _selectedSubject!,
                            'subject_name': _selectedSubjectName,
                          });
                        });
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Subject allocated to ${_selectedStudents.length} students'),
                          ),
                        );
                        // Reset form
                        _formKey.currentState!.reset();
                        _selectedSubject = null;
                        _selectedSubjectName = null;
                        _selectedStudents = [];
                      }
                    },
                  ),
                ),
                // Checkbox list for selecting students
                FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc('2')
                      .collection('Student')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data!.docs.map((doc) {
                        String studentId = doc.id;
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        String studentName = data['name'];
                        // String studentName = data['name'];
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Card(
                            elevation: 5,
                            // shape: ,
                            child: CheckboxListTile(
                              title: Text(studentName),
                              subtitle: Text(data['email']),
                              value: _selectedStudents.contains(studentId),
                              //  && _selectedStudents.contains(studentName),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    _selectedStudents.add(studentId);
                                    // _selectedStudents.add(studentName);
                                  } else {
                                    _selectedStudents.remove(studentId);
                                  }
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Button for submitting the form
              ],
            ),
          ),
        ),
      ),
    );
  }
}
