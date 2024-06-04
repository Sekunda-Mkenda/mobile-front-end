import 'package:get/get.dart';
import 'package:login/constants/widgets.dart';
import 'package:login/screens/authentication/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') ?? '';
}

// Future<String> getRefreshToken() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString('refresh_token') ?? '';
// }

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
  prefs.remove('is_otp_verified');
  prefs.remove('refresh_token');
  prefs.remove('cart');

  //redirect user to login screen
  Get.offAll(() => const LoginScreen());

  //display success message
  successToast('Logged out successfully');
}
