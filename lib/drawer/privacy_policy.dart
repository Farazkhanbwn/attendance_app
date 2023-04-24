import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Our company, Auto Attendance System, respects and protects the privacy of our users. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By accessing or using our services, you agree to the terms and conditions of this Privacy Policy.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Information We Collect',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'We collect personal information such as your name, email address, and phone number when you sign up for our services. We may also collect information about your usage of our services, such as the date and time of your visits and the pages you accessed.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'How We Use Your Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'We use the information we collect to provide and improve our services, to communicate with you, and to personalize your experience. We may also use your information to send you promotional materials and other information that may be of interest to you.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Information Sharing and Disclosure',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'We do not share or disclose your personal information with third parties, except as necessary to provide and improve our services, comply with legal obligations, or protect our rights and property.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Security',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'We take reasonable measures to protect your personal information from unauthorized access, use, and disclosure. However, no security measure is 100% effective, and we cannot guarantee the security of your information.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Changes to This Privacy Policy',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'We reserve the right to modify or update this Privacy Policy at any time without prior notice. Your continued use of our services after any such changes constitutes your acceptance of the new Privacy Policy.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'If you have any questions or concerns about this Privacy Policy or our services, please contact us at @farazkhanaa2555@gmail.com.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ));
  }
}
