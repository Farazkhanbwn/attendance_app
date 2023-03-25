import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubjectAllocationList extends StatefulWidget {
  @override
  _SubjectAllocationListState createState() => _SubjectAllocationListState();
}

class _SubjectAllocationListState extends State<SubjectAllocationList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final User _user;
  final userEmail = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subject Allocation'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('subject_allocations')
            .where('docId', isEqualTo: 'Hk7WWmmTGU2gkBv4s442')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final allocationDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: allocationDocs.length,
            itemBuilder: (context, index) {
              final allocation = allocationDocs[index].data();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text((allocation
                              as Map<String, dynamic>)['subject_name'] ??
                          ''),
                      // subtitle: Text((allocation as Map<String, dynamic>)['courseID']),
                      // subtitle: Text(allocation['courseID']),
                    ),
                  ),
                  // child: Text(allocation!['courseName'] ?? ''),
                  // child: ListTile(
                  //   title: Text(allocation?['courseName'] ?? 'N/A'),
                  //   subtitle: Text(allocation?['teacherName'] ?? 'N/A'),
                  // ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
