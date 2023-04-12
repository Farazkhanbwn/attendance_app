import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blue/flutter_blue.dart';

class EnrollStudents extends StatefulWidget {
  final String subjectName;

  EnrollStudents({required this.subjectName});

  @override
  _EnrolledStudentsScreenState createState() => _EnrolledStudentsScreenState();
}

class _EnrolledStudentsScreenState extends State<EnrollStudents> {
  late Stream<QuerySnapshot> _enrolledStudentsStream;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  // Create a list to hold nearby devices
  List<ScanResult> nearbyDevices = [];
  // Callback function to handle scan results
  void handleScanResult(ScanResult scanResult) {
    setState(() {
      nearbyDevices.add(scanResult);
    });
  }

// Function to start scanning for nearby devices
  void startScanningForDevices() {
    flutterBlue.scan().listen(handleScanResult);
  }

  @override
  void initState() {
    super.initState();
    Stream<List<dynamic>> _enrolledStudentsStream = FirebaseFirestore.instance
        .collection('subject_allocation')
        .doc(widget.subjectName)
        .snapshots()
        .map((docSnapshot) => docSnapshot.data()?['students'] ?? []);
    // .collection('subject_allocations')
    // .where('subjectNamesList', arrayContains: widget.subjectName)
    // .snapshots();
    print('_enrolledstudentStream is =${_enrolledStudentsStream}');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName + ' Students'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _enrolledStudentsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                  // return Center(
                  //   child: ShimmerEffect(
                  //     child: Container(
                  //       width: 200,
                  //       height: 50,
                  //       color: Colors.blueGrey,
                  //     ),
                  //     duration: Duration(seconds: 2),
                  //     baseColor: Colors.grey[300]!,
                  //     highlightColor: Colors.grey[100]!,
                  //     width: 200,
                  //     height: 50,
                  //   ),
                  // );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('None of the students are enrolled'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String userEmail =
                        snapshot.data!.docs[index]['studentName'];

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.002),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(userEmail),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: startScanningForDevices,
          //   child: const Text('Scan for nearby devices'),
          // ),
        ],
      ),
    );
  }
}
