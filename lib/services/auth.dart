import 'dart:convert';

import 'package:cpm/constants/api/api.dart';
import 'package:cpm/constants/api/api_response.dart';
import 'package:cpm/constants/utils.dart';
import 'package:cpm/models/user.dart';
import 'package:cpm/models/user_profile.dart';

Future<ApiResponse> register(
    String firstName,
    String middleName,
    String lastName,
    String gender,
    String email,
    String mobile,
    String password) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.post(
        'auth/clients/registration',
        {
          "first_name": firstName,
          "middle_name": middleName,
          "last_name": lastName,
          "email": email,
          "mobile": mobile,
          "profile": "",
          "gender": gender,
          "password": password
        },
        isAuthenticated: false);

    switch (response.statusCode) {
      case 200:
      case 201:
        apiResponse.data = userFromJson(response.body);
        break;
      case 400:
        final errors = jsonDecode(response.body);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.error = "Server Error";
    }
  } catch (e) {
    apiResponse.error = "No internet connection";
  }

  return apiResponse;
}

Future<ApiResponse> login(
    String mobile, String password, String? deviceId) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.post('auth/login',
        {'mobile': '255$mobile', 'password': password, 'device_id': deviceId},
        isAuthenticated: false);

    switch (response.statusCode) {
      case 200:
      case 201:
        apiResponse.data = userFromJson(response.body);
        break;
      case 400:
        final errors = jsonDecode(response.body);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)["error"];
        break;
      default:
        apiResponse.error = "Server Error";
    }
  } catch (e) {
    apiResponse.error = "No internet connection";
    print(e);
  }

  return apiResponse;
}

Future<ApiResponse> getProfile() async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();
  var userId = await getUserId();

  try {
    var response = await http.get('user/$userId/profile');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = userProfileFromJson(response.body);
        break;
      case 404:
        apiResponse.error = "Request resource was not found.";
        break;
      case 401:
      case 403:
        apiResponse.error = jsonDecode(response.body)["error"];
        break;
      default:
        apiResponse.error = "Server Error";
    }
  } catch (e) {
    apiResponse.error = "Something went wrong, try again later";
    print(e);
  }

  return apiResponse;
}

Future<ApiResponse> verifyOtp(String otp) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.post('auth/verify-otp', {'otp': otp});

    switch (response.statusCode) {
      case 200:
        // apiResponse.data = jsonDecode(response.body);
        apiResponse.data = userFromJson(response.body);
        break;
      case 400:
        // print(response.body['error']);
        final errors = jsonDecode(response.body);
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)["message"];
        break;
      default:
        apiResponse.error = "Server Error";
    }
  } catch (e) {
    apiResponse.error = "No internet connection";
  }

  return apiResponse;
}

Future<ApiResponse> resendOtp() async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    //print(loginUrl);
    var response = await http.post('auth/resend-otp', {});

    print(response.body);

    switch (response.statusCode) {
      case 200:
        // apiResponse.data = jsonDecode(response.body);
        apiResponse.data = userFromJson(response.body);
        break;
      case 400:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)["error"];
        break;
      default:
        apiResponse.error = "Server Error";
    }
  } catch (e) {
    apiResponse.error = "No internet connection";
    print(e);
  }

  return apiResponse;
}
