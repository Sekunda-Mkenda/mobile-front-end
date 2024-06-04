import 'package:flutter/material.dart';
import 'package:login/utils/colors.dart';

AppBar myAppbar(String upperText) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: textColour,
          size: 30,
        ),
        Text(
          upperText,
          style: const TextStyle(
            color: textColour,
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: Image.asset('assets/heroSection.jpeg'),
        )
      ],
    ),
  );
}
