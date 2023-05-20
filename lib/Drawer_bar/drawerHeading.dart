import 'package:attendance_app/Theme.dart';
import 'package:attendance_app/static_values.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../constants/constantString.dart';
// import 'Responsive.dart';
// import 'profileSection/provider.dart';

drawerHeader(context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  return Container(
    margin: EdgeInsets.only(bottom: height * 0.02),
    padding: EdgeInsets.only(bottom: height * 0.02),
    width: double.infinity,
    // color: const Color(0xff1F456E),
    color: MyTheme.primaryColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        userImage(),
        //  userName(context), userEmail(context)
      ],
    ),
  );
}

userEmail(context) {
  return Container(
      alignment: Alignment.center,
      child: Text(
        StaticValues.model!.userEmail == null
            ? "xxxxxxxxxxx@gmail.com"
            : StaticValues.model!.userEmail!,
        style: TextStyle(
            // fontSize: setSize(context, 17),
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: MyTheme.whiteColor),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ));
}

Widget userName(BuildContext context) {
  // final user = FirebaseAuth.instance.currentUser;
  // final displayName = user?.displayName ?? "Anonymous";
  return Container(
    margin: const EdgeInsets.only(bottom: 5, top: 10),
    alignment: Alignment.center,
    child: Text(
      StaticValues.model!.userName == null
          ? "UserName"
          : StaticValues.model!.userName!,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: MyTheme.whiteColor,
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    ),
  );
}

userImage() {
  String? imgUrl = FirebaseAuth.instance.currentUser?.photoURL.toString();
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.7)),
    margin: const EdgeInsets.only(top: 40, bottom: 10),
    child: Image.asset(
      'images/complain.png',
      height: 130,
      width: 150,
    ),
  );
}
