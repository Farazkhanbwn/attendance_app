import 'package:attendance_app/forget_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class keyboardVisibility extends StatefulWidget {
  const keyboardVisibility({super.key});

  @override
  State<keyboardVisibility> createState() => _keyboardVisibilityState();
}

class _keyboardVisibilityState extends State<keyboardVisibility> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keyboard Visibility Example'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPassword(),
                      ),
                    );
                  },
                  child: const Text('Provider Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPassword(),
                      ),
                    );
                  },
                  child: const Text('KeyboardDismiss Demo'),
                ),
                const Spacer(),
                const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Input box for keyboard test',
                  ),
                ),
                Container(height: 60.0),
                KeyboardVisibilityBuilder(builder: (context, visible) {
                  return Text(
                    'The keyboard is: ${visible ? 'VISIBLE' : 'NOT VISIBLE'}',
                  );
                }),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
