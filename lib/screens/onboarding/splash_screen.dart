import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:login/constants/utils.dart';
import 'package:login/models/projects.dart';
import 'package:login/screens/authentication/sign_in_screen.dart';
import 'package:login/screens/projects/_list.dart';
import 'package:login/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  splashTimer() async {
    Timer(const Duration(seconds: 3), () => _initialRouter());
  }

  Future<void> _initialRouter() async {
    String? token = await getAccessToken();
    print("the token value is :");
    print(token);
    if (token == '') {
      Get.to(() => const LoginScreen());
    } else {
      print("herer should be the token");
      print(token);
      Get.offAll(() => const ProjectsScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: myPrimaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Collaborative Project Management',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      )),
    );
  }
}
