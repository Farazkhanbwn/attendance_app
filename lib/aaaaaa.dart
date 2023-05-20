import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Card1 extends StatefulWidget {
  const Card1({super.key});

  @override
  State<Card1> createState() => _CardState();
}

class _CardState extends State<Card1> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Center(
            child: Container(
              width: width * 0.9,
              height: height * 0.3,
              // color: Colors.amber,
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      title: Text(
                        'Moaz',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      trailing: Text('pending'),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      title: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.email),
                      ),
                      trailing: Text('pending'),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      title: Text(
                        'Phone No',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.call),
                      ),
                      trailing: Text('pending'),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      title: Text(
                        'Catergoru',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.category),
                      ),
                      trailing: Text('pending'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
        ],
      ),
    );
  }
}
