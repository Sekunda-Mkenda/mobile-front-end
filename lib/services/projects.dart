import 'dart:convert';

import 'package:login/constants/api/api.dart';
import 'package:login/constants/api/api_response.dart';
import 'package:login/models/projects.dart';
import 'package:login/models/user.dart';

import '../models/project.dart';
import '../models/task.dart';

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

Future<ApiResponse> login(String mobile, String password) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.post(
        'auth/login',
        {
          'mobile': '255$mobile',
          'password': password,
        },
        isAuthenticated: false);
    print(response.body);

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

Future<ApiResponse> createTaskItemApi(dynamic payload) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.post('tasks/items', payload);

    switch (response.statusCode) {
      case 200:
      case 201:
        apiResponse.data = 'Success';
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

Future<ApiResponse> getProjects(String resourceUrl) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    //print(loginUrl);
    var response = await http.get(resourceUrl);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = projectListFromJson(response.body);
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

Future<ApiResponse> getProjectById(String projectId) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.get('projects/$projectId');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = projectFromJson(response.body);
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

Future<ApiResponse> getTaskById(String taskId) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.get('tasks/$taskId');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = taskFromJson(response.body);
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

Future<ApiResponse> updateTaskStatus(String taskId, String status) async {
  ApiResponse apiResponse = ApiResponse();
  ApiHelper http = ApiHelper();

  try {
    var response = await http.patch('tasks/$taskId/$status', {});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = taskFromJson(response.body);
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
