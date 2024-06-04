import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login/screens/authentication/sign_in_screen.dart';
//import 'package:login/screens/appscreen/project_list_screen.dart';
//import 'package:login/screens/appscreen/project_list_screen.dart';
//import 'package:login/screens/appscreen/tasks_screen.dart';
// ignore: unused_import
import 'package:login/screens/authentication/sign_up_screen.dart';
import 'package:login/utils/colors.dart';
//import 'package:login/authentication/create_password.dart';
//import 'package:login/authentication/sign_up_screen.dart';
//import 'package:login/authentication/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Project Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: myPrimaryColor),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
