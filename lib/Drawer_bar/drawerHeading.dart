import 'package:attendance_app/Theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../constants/constantString.dart';
// import 'Responsive.dart';
// import 'profileSection/provider.dart';

drawerHeader(context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.only(bottom: 20, top: 10),
    width: double.infinity,
    // color: const Color(0xff1F456E),
    color: MyTheme.primaryColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [userImage(), userName(context), userEmail(context)],
    ),
  );
}

userEmail(context) {
  return Container(
      alignment: Alignment.center,
      child: Text(
        "${FirebaseAuth.instance.currentUser?.email}",
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
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;
      final displayName = data['name'] ?? 'Name';

      return Container(
        margin: const EdgeInsets.only(bottom: 5, top: 10),
        alignment: Alignment.center,
        child: Text(
          displayName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: MyTheme.whiteColor,
          ),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
    },
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
    child: imgUrl == "null"
        ? const Text('Hello we Are Learning')
        // Image.asset(
        //     appLogo,
        //     height: 130,
        //     width: 150,
        //   )
        : Image.asset(
            imgUrl!,
            height: 130,
            width: 150,
          ),
  );
}
