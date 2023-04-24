import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About Auto Attendance',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our auto attendance system uses Bluetooth technology to streamline the attendance-taking process. With this system, students and employees can simply turn on Bluetooth on their devices and the system will automatically detect their presence in the classroom or office.\n\nWe have integrated Firebase as our database to store attendance records securely and reliably. This allows for easy retrieval and analysis of attendance data, making it easier for educators and administrators to monitor attendance patterns and identify areas for improvement.\n\nWe are committed to providing a reliable and user-friendly attendance system that helps educators and administrators save time and improve their operations.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Developer:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Faraz Liaquat',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Email: farazkhanaa2555@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              'Phone: +923013309056',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
