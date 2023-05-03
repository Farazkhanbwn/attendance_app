import 'package:attendance_app/Drawer_bar/drawerHeading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateBluetoothIdTile extends StatefulWidget {
  @override
  _UpdateBluetoothIdTileState createState() => _UpdateBluetoothIdTileState();
}

class _UpdateBluetoothIdTileState extends State<UpdateBluetoothIdTile> {
  final _formKey = GlobalKey<FormState>();
  late String _bluetoothId;
  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  void initState() {
    super.initState();

    // Get the user's document from Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((userDoc) {
      // Get the Bluetooth ID from the document
      setState(() {
        _bluetoothId = userDoc.get('blueId') ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      contentPadding: const EdgeInsets.only(top: 15, left: 20),
      leading: const Icon(Icons.bluetooth, size: 20, color: Colors.black),
      title: Text(
        'Update Bluetooth ID',
        style: TextStyle(
            // fontSize: setSize(context, 17),
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w400),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Update Bluetooth ID'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  initialValue: _bluetoothId,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bluetooth ID is required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _bluetoothId = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Bluetooth ID',
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text('Update'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Get the current user's email
                      final currentUserEmail =
                          FirebaseAuth.instance.currentUser!.email;
                      // Update the Bluetooth ID for the current student in Firestore
                      FirebaseFirestore.instance
                          .collection('users')
                          .where('email', isEqualTo: email)
                          .where('role', isEqualTo: 'Student')
                          .get()
                          .then((querySnapshot) {
                        if (querySnapshot.docs.length > 0) {
                          final studentDoc = querySnapshot.docs[0];
                          studentDoc.reference
                              .update({'blueId': _bluetoothId}).then((_) {
                            setState(() {
                              _bluetoothId = _bluetoothId;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Bluetooth ID updated successfully')));
                            Navigator.pop(context);
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Failed to update Bluetooth ID')));
                            Navigator.pop(context);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Failed to find current student')));
                          Navigator.pop(context);
                        }
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to update Bluetooth ID')));
                        Navigator.pop(context);
                      });
                    }
                  },
                ),

                // ElevatedButton(
                //   child: Text('Update'),
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       // Update the Bluetooth ID in Firestore
                //       FirebaseFirestore.instance
                //           .collection('users')
                //           .doc()
                //           .update({'blueId': _bluetoothId}).then((_) {
                //         setState(() {
                //           _bluetoothId = _bluetoothId;
                //         });
                //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //             content:
                //                 Text('Bluetooth ID updated successfully')));
                //         Navigator.pop(context);
                //       }).catchError((error) {
                //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //             content: Text('Failed to update Bluetooth ID')));
                //         Navigator.pop(context);
                //       });
                //     }
                //   },
                // ),
              ],
            );
          },
        );
      },
    );
  }
}
