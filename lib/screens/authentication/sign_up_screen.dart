import 'package:cpm/widgets/buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void _loginHandler() {
    if (kDebugMode) {
      print("hellloooo");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 150),
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 10),
            const Text("Do you have an account?"),
            const SizedBox(height: 20),
            const Text("Full Name"),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Sekunda Mkenda',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Your Phone Number"),
            const TextField(
              decoration: InputDecoration(
                hintText: '0762878075',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Row(
            //   children: [
            //     Checkbox(value: false, onChanged: (value) {}),
            //     RichText(
            //       text: TextSpan(
            //         children: [
            //           const TextSpan(
            //             text: 'I accept the ',
            //             style: TextStyle(color: Colors.black),
            //           ),
            //           TextSpan(
            //             text: 'Terms and Conditions',
            //             style: const TextStyle(
            //               color: Colors.orange,
            //               decoration: TextDecoration.underline,
            //             ),
            //             recognizer: TapGestureRecognizer()
            //               ..onTap = () {
            //                 // Handle the link action, such as navigating to Terms and Conditions page
            //                 if (kDebugMode) {
            //                   print("Terms and Conditions clicked");
            //                 }
            //               },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            myElevatedButton('sign up', _loginHandler),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Log In',
                    style: const TextStyle(
                      color: Colors.orange,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle the link action, such as navigating to login page
                        if (kDebugMode) {
                          print("Logging In");
                        }
                      },
                  ),
                ],
              ),
            ),
          ], // children of Column
        ),
      ),
    );
  }
}
