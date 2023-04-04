import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothPage extends StatefulWidget {
  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    startScanningForDevices();
  }

  Future<void> startScanningForDevices() async {
    devices.clear();
    flutterBlue.startScan(timeout: Duration(seconds: 10));
    flutterBlue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic c in service.characteristics) {
        if (c.uuid.toString() == 'your_characteristic_uuid_here') {
          await c.write([0x01]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: startScanningForDevices,
            child: Text('Scan for nearby devices'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index].name ?? 'Unknown'),
                  subtitle: Text(devices[index].id.toString()),
                  onTap: () => connectToDevice(devices[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
