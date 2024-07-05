// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cpm/utils/colors.dart';
import 'package:cpm/widgets/buttons.dart';

BottomNavigationBarItem myBottomNavItem(
    IconData icon, String itemLabel, int index) {
  return BottomNavigationBarItem(icon: Icon(icon, size: 18), label: itemLabel);
}

SnackbarController errorToast(message) {
  return Get.snackbar('', '',
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 30.0,
      ),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      titleText: Container(),
      messageText: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.red),
          child: Text(
            message.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          )),
      margin: const EdgeInsets.all(20));
}

SnackbarController successToast(message) {
  return Get.snackbar('', '',
      icon: const Icon(
        Icons.check,
        color: Colors.white,
        size: 30.0,
      ),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      titleText: Container(),
      messageText: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.green),
          child: Text(
            message.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          )),
      margin: const EdgeInsets.all(20));
}

Stack progressIndicator({String? loadingText}) {
  loadingText ??= 'Loading';
  return Stack(
    alignment: Alignment.center,
    children: [
      myElevatedButton("", () => null),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$loadingText...",
            style: const TextStyle(color: Colors.white, fontSize: 17.0),
          ),
          const SizedBox(width: 10.0),
          const CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      )
    ],
  );
}

Row progressIndicator2() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Loading...",
        style: TextStyle(color: myPrimaryColor, fontSize: 17.0),
      ),
      SizedBox(width: 10.0),
      CircularProgressIndicator(
        color: mySecondColor,
      )
    ],
  );
}
