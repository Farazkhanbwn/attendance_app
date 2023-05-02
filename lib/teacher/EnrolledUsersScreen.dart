import 'package:attendance_app/Theme.dart';
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
  List<String> deviceList = [];

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
    //   _enrolledStudentsStream = FirebaseFirestore.instance
    //       .collection('subject_allocations')
    //       .doc(widget.subjectName)
    //       .snapshots()
    //       .map((snapshot) => snapshot.get('students').cast<String>());
    //   // getStudentIds();
  }

// Define a function to start and stop scanning
  void scan() {
    // Start scanning
    flutterBlue.startScan(
      timeout: const Duration(seconds: 4),
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

        print("devices ${deviceList.length}");
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
      body: Container(
        height: height,
        width: width,
        child: ListView.builder(
          itemCount: deviceList.length,
          itemBuilder: (context, index) {
            return Text(deviceList[index]);
          },
        ),
      ),
      // body: StreamBuilder<List<String>>(
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
      //           trailing: const Text('pending'),
      //         ));
      //       },
      //     );
      //   },
      // ),
    );
  }
}
