import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:cpm/constants/api/api_response.dart';
import 'package:cpm/constants/validators.dart';
import 'package:cpm/constants/widgets.dart';
import 'package:cpm/models/user.dart';
import 'package:cpm/screens/projects/_list.dart';
import 'package:cpm/services/auth.dart';
import 'package:cpm/utils/colors.dart';
import 'package:cpm/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isPasswordObscured = true;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoginLoading = false;
  String? deviceId;

  void getRegistrationId() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      deviceId = token;
    });
  }

  userLogin() async {
    //Request device unique id for FCM Notifications
    String? uniqueDeviceId = await FirebaseMessaging.instance.getToken();
    ApiResponse response = await login(
        _mobileController.text, _passwordController.text, uniqueDeviceId);
    if (response.error == null) {
      User user;
      user = response.data as User;
      //Setting required values into shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', user.token ?? '');
      await prefs.setString('user_mobile', _mobileController.text);

      //Navigating to the home screen
      Get.off(() => const ProjectsScreen());
      successToast("Logged successfully, Welcome");
    } else {
      setState(() {
        isLoginLoading = !isLoginLoading;
      });

      errorToast(response.error.toString());
    }
  }

  loginHandler() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoginLoading = !isLoginLoading;
      });
      userLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 120),
                    const Text(
                      "Login",
                      style: TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 10),
                    const Text("Welcome!"),
                    const SizedBox(height: 20),
                    // const Text("Phone Number"),
                    FormBuilderTextField(
                      name: 'mobile',
                      controller: _mobileController,
                      validator: phoneValidator,
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      decoration: const InputDecoration(
                          prefix: Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: Text(
                              '+255',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          label: Text('Mobile'),
                          hintText: '762878075',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: myPrimaryColor),
                          ),
                          suffixIcon: Icon(Icons.phone)),
                      onChanged: (value) =>
                          formKey.currentState!.fields['mobile']?.validate(),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'password',
                      controller: _passwordController,
                      validator: passwordValidator,
                      obscureText: isPasswordObscured,
                      // keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        hintText: '',
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordObscured = !isPasswordObscured;
                            });
                          },
                          icon: !isPasswordObscured
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.remove_red_eye),
                        ),
                      ),
                      onChanged: (value) =>
                          formKey.currentState!.fields['password']?.validate(),
                    ),
                    const SizedBox(height: 20),
                    // const Text("Password"),

                    const SizedBox(height: 20),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Forgot Password?',
                    //       style: TextStyle(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 50,
                    ),

                    // myElevatedButton('Login', loginHandler),
                    isLoginLoading
                        ? progressIndicator(loadingText: "Logging in")
                        : myElevatedButton("Login", loginHandler),

                    const SizedBox(height: 20),
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have an account?",
                    //       style: TextStyle(color: Colors.black),
                    //     ),

                    //   ],
                    // ),

                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
