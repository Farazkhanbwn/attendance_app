import 'package:attendance_app/drawer/about.dart';
import 'package:attendance_app/drawer/all_admins.dart';
import 'package:attendance_app/drawer/all_students.dart';
import 'package:attendance_app/drawer/all_teachers.dart';
import 'package:attendance_app/drawer/privacy_policy.dart';
import 'package:attendance_app/drawer/termCondition.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher_string.dart';

// import '../../aboutPage/mainPage.dart';
// import '../../constants/constantString.dart';
// import '../../reusableWidgets/Responsive.dart';
// import '../../reusableWidgets/profileSection/getProfileInfo.dart';
// import '../../reusableWidgets/profileSection/mainPage.dart';
// import '../../reusableWidgets/profileSection/provider.dart';
// import '../Students Result/mainPage.dart';
// import '../createQuiz/mainScreen.dart';

ListTile listTileAllTeachers(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 20),
    leading:
        const Icon(FontAwesomeIcons.receipt, size: 20, color: Colors.black),
    title: Text(
      "Teacher's",
      style: TextStyle(
        // fontSize: setSize(context, 18),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TeachersScreen()));
    },
  );
}

Widget listTileStudents(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.arrowRightFromBracket,
        size: 20, color: Colors.black),
    title: const Text(
      "Student's",
      style: TextStyle(
        // fontSize: setSize(context, 18),
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    ),
    onTap: () async {
      Navigator.pop(context);
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentsScreen(),
          ),
        );
      }
    },
  );
}

Widget listTileProfile(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.userPen, size: 20, color: Colors.black),
    title: Text(
      "My Profile",
      style: TextStyle(
          // fontSize: setSize(context, 18),
          fontSize: 18,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const ProfilePage()));
    },
  );
}

ListTile listTileAbout(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.circleInfo, size: 20, color: Colors.black),
    title: const Text(
      "About Us",
      style: TextStyle(
          // fontSize: setSize(context, 18),
          fontSize: 18,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AboutPage()));
    },
  );
}

listTilePrivacyPolicy(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading:
        const Icon(FontAwesomeIcons.userShield, size: 20, color: Colors.black),
    title: const Text(
      "Privacy Policy",
      style: TextStyle(
          // fontSize: setSize(context, 17),
          fontSize: 18,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
      // launchUrlString(privacyPolicyURL);
    },
  );
}

listTileTerms(context) {
  return ListTile(
    style: ListTileStyle.drawer,
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.bookOpenReader,
        size: 20, color: Colors.black),
    title: const Text(
      "Terms and Conditions",
      style: TextStyle(
          // fontSize: setSize(context, 17),
          fontSize: 17,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      // launchUrlString(termsConditionsURL,
      //     webOnlyWindowName: "Terms And Conditions");
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TermsAndConditions()));
    },
  );
}

ListTile listTileAdmins(context) {
  return ListTile(
    contentPadding: const EdgeInsets.only(top: 15, left: 20),
    leading: const Icon(FontAwesomeIcons.squarePollVertical,
        size: 20, color: Colors.black),
    title: Text(
      "Admin's",
      style: TextStyle(
          // fontSize: setSize(context, 18),
          fontSize: 18,
          fontWeight: FontWeight.w400),
    ),
    onTap: () {
      Navigator.pop(context);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminsScreen()));
    },
  );
}
