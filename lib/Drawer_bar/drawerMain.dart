import 'package:attendance_app/Drawer_bar/drawerHeading.dart';
import 'package:flutter/material.dart';
// import '../../reusableWidgets/Responsive.dart';
// import '../../reusableWidgets/drawerHeading.dart';
import 'drawerBody.dart';

Drawer navigationDrawer(context) {
  var width = MediaQuery.of(context).size.width;
  return Drawer(
    // width: screenWidth(context) / 1.6,
    width: width * 0.6,
    elevation: 20,
    child: SingleChildScrollView(
      child: Column(
        children: [
          drawerHeader(context), // Inside Reusable Widgets Folder
          // Inside drawerMain of navigationDrawer Folder
          listTileAllTeachers(context),
          listTileStudents(context),
          listTileAdmins(context),
          listTileProfile(context),
          listTileAbout(context),
          listTilePrivacyPolicy(context),
          listTileTerms(context),
        ],
      ),
    ),
  );
}
