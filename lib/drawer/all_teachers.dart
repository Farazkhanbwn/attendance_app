import 'package:attendance_app/Drawer_bar/drawerHeading.dart';
import 'package:attendance_app/flutsh&toast.dart/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({Key? key}) : super(key: key);

  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  late Stream<QuerySnapshot> _teachersStream;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _teachersStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Teacher')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _teachersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Center(child: Text('Empty')));
          }
          final teachers = snapshot.data!.docs;
          return AnimatedList(
            key: _listKey,
            initialItemCount: teachers.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              if (index < teachers.length) {
                final teacherData =
                    teachers[index].data() as Map<String, dynamic>;
                return SizeTransition(
                  sizeFactor: animation,
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(teacherData['name']),
                      subtitle: Text(teacherData['email']),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this user?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('CANCEL'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                      Navigator.of(context).pop();
                                      showFlushbar(
                                          context, 'User Deleted Successfully');
                                    },
                                    child: const Text('DELETE'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Text('');
              }
            },
          );
        },
      ),
    );
  }
}
