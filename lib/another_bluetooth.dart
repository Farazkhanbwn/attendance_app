import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<ScanResult> scanResults = [];

  FlutterBlue flutterBlue = FlutterBlue.instance;

  void startScanningForDevices() async {
    try {
      // Start scanning for nearby devices
      await flutterBlue.startScan(timeout: Duration(seconds: 5));
    } catch (e) {
      print('Error starting scan: $e');
    }
  }

  void stopScanningForDevices() async {
    try {
      // Stop scanning for nearby devices
      await flutterBlue.stopScan();
    } catch (e) {
      print('Error stopping scan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: startScanningForDevices,
            child: Text('Scan for nearby devices'),
          ),
          ElevatedButton(
            onPressed: stopScanningForDevices,
            child: Text('Stop scanning'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: scanResults.length,
              itemBuilder: (BuildContext context, int index) {
                ScanResult scanResult = scanResults[index];
                return ListTile(
                  title: Text(scanResult.device.name ?? 'Unknown Device'),
                  subtitle: Text(scanResult.device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Do something with the selected device
                      print('Selected device: ${scanResult.device.name}');
                    },
                    child: Text('Connect'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
