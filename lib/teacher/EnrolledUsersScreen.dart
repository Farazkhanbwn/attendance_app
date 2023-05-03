import 'package:attendance_app/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class EnrolledStudentsScreen extends StatefulWidget {
  final String subjectName;

  const EnrolledStudentsScreen({required this.subjectName});

  @override
  _EnrolledStudentsScreenState createState() => _EnrolledStudentsScreenState();
}

class _EnrolledStudentsScreenState extends State<EnrolledStudentsScreen> {
  Stream<List<String>>? _enrolledStudentsStream = Stream.empty();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isScanning = false;
  List<String> blueIds = [];
  List<String> deviceList = [];
  List<String> matchingIds = [];

  addDeviceToList(String device) {
    if (deviceList.contains(device)) {
      print("mama hegi wa me pehle");
    } else {
      setState(() {
        deviceList.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentBlueIds();
    _enrolledStudentsStream = FirebaseFirestore.instance
        .collection('subject_allocations')
        .doc(widget.subjectName)
        .snapshots()
        .map((snapshot) => snapshot.get('students').cast<String>());
    // getStudentIds();
  }

// Define a function to start and stop scanning
  void scan() {
    // Start scanning
    flutterBlue.startScan(
      timeout: const Duration(seconds: 3),
      scanMode: ScanMode.lowLatency,
      allowDuplicates: false,
    );

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        setState(() {
          addDeviceToList(r.device.id.toString());
          // deviceList.add(r.device);
          //print("device ids ${r.device.id}");
        });

        print("devices Length is = ${deviceList.length}");
      }
    });

// Stop scanning
    //   flutterBlue.stopScan();

    // Set scanning status to true
    // isScanning = true;

    // else {
    //   // Stop scanning
    //   flutterBlue.stopScan();

    //   // Cancel subscription if it's not null

    //   // Set scanning status to false
    //   isScanning = false;
    // }
  }

  Future<void> fetchStudentBlueIds() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('role', isEqualTo: 'Student')
        .get();
    snapshot.docs.forEach((doc) {
      String blueId = doc.get('blueId');

      if (blueId != null && blueId.isNotEmpty) {
        blueIds.add(blueId);
        print('bluetooth idss is equal to ${blueIds}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.primaryColor,
        title: const Text('Enrolled Students'),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                scan();
              },
              child: SizedBox(
                width: width * 0.1,
                height: height * 0.02,
                child: const Text(
                  'scan',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       height: height * 0.7,
      //       width: width,
      //       child: ListView.builder(
      //         itemCount: deviceList.length,
      //         itemBuilder: (context, index) {
      //           return Text(deviceList[index]);
      //         },
      //       ),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         // Compare the two lists and show output
      //         List<String> matchingIds = [];
      //         for (String id in deviceList) {
      //           if (blueIds.contains(id)) {
      //             matchingIds.add(id);
      //           }
      //         }
      //         print('Matching IDs: $matchingIds');
      //       },
      //       child: Text('Compare Lists'),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              SizedBox(
                  width: width,
                  height: height * 0.42,
                  child: ListView.builder(
                    itemCount: matchingIds.length,
                    itemBuilder: (context, index) {
                      final studentId = matchingIds[index];
                      final isPresent = deviceList.contains(studentId);
                      final statusText = isPresent ? 'present' : 'pending';
                      return ListTile(
                        title: Text('Student $studentId'),
                        subtitle: Text(statusText),
                      );
                    },
                  )
                  // StreamBuilder<List<String>>(
                  //   stream: _enrolledStudentsStream,
                  //   builder: (context, snapshot) {
                  //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return const Center(
                  //         child: Text('None of the students are enrolled'),
                  //       );
                  //     }

                  //     return ListView.builder(
                  //       itemCount: snapshot.data!.length,
                  //       itemBuilder: (context, index) {
                  //         final studentname = snapshot.data![index];
                  //         return Card(
                  //             child: ListTile(
                  //           title: Text(studentname),
                  //           trailing: deviceList.contains(snapshot.data![index])
                  //               ? const Text('present')
                  //               : const Text('pending'),
                  //         ));
                  //       },
                  //     );
                  //   },
                  // ),
                  ),
              ElevatedButton(
                onPressed: () {
                  // Compare the two lists and show output
                  for (String id in deviceList) {
                    print('deviceList is = ${deviceList.toList()}');
                    if (blueIds.contains(id)) {
                      matchingIds.add(id);
                      matchingIds = matchingIds.toSet().toList();
                    }
                  }
                  print('Matching IDs: $matchingIds');
                },
                child: const Text('Compare Lists'),
              ),
              // SizedBox(
              //   width: width,
              //   height: height * 0.42,
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('users')
              //         .where('role', isEqualTo: 'Student')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return const Center(child: CircularProgressIndicator());
              //       }

              //       // Get the list of student documents
              //       final studentDocs = snapshot.data!.docs;

              //       // Check each student document for a matching ID and update the "present" field
              //       for (final doc in studentDocs) {
              //         final studentId = doc.id;
              //         final blueId = doc.get('blueId');

              //         if (blueId == matchingIds) {
              //           doc.reference.update({'present': true});
              //         }
              //       }

              //       // Build the UI with the updated list of student documents
              //       return ListView.builder(
              //         itemCount: studentDocs.length,
              //         itemBuilder: (context, index) {
              //           final studentDoc = studentDocs[index];
              //           final studentName = studentDoc.get('name');
              //           // final isPresent = studentDoc.get('present') ?? false;

              //           return Card(
              //             child: ListTile(
              //                 title: Text(studentName),
              //                 trailing: Text('hello')),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
