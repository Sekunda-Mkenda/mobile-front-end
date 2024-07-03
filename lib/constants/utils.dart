import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cpm/constants/widgets.dart';
import 'package:cpm/screens/authentication/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') ?? '';
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_id') ?? '';
}

Future<String?> getStringValue(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(value) ?? '';
}

void logoutHander() async {
  final prefs = await SharedPreferences.getInstance();

  prefs.remove('user_id');
  prefs.remove('access_token');

  //redirect user to login screen
  Get.offAll(() => const LoginScreen());

  //display success message
  successToast('Logged out successfully');
}

String formatDate(DateTime? date) {
  if (date == null) return '';
  final formatter = DateFormat('d MMMM yyyy');
  return formatter.format(date);
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
