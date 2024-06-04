import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

String? phoneValidator(value) {
  final RegExp phoneNumberRegExp = RegExp(r'^\+?\d{9}$');
  if (value.isEmpty) {
    return "Phone field is required";
  } else if (!phoneNumberRegExp.hasMatch(value)) {
    return "Mobile number must be 9 digits";
  } else {
    return null;
  }
}

String? emailValidator(value) {
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  // if (value.isEmpty) {
  //   return "Email address is required";
  // }
  if (!emailRegExp.hasMatch(value) && !value.isEmpty) {
    return "Provide valid email address";
  } else {
    return null;
  }
}

String? passwordValidator(value) {
  if (value.isEmpty) {
    return "Password field is required";
  } else if (value.length < 5) {
    return "Password should be at least 5 characters long";
  } else {
    return null;
  }
}

String? nameValidator(value) {
  if (value.isEmpty) {
    return "This field Required";
  } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
    return "Enter valid name";
  } else if (value.length < 3) {
    return "Name too short";
  } else {
    return null;
  }
}
