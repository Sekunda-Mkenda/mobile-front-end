import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:login/constants/utils.dart';
import '../urls.dart' as url;

class ApiHelper {
  final String baseUrl;

  // Default constructor with a default value for baseUrl
  ApiHelper({this.baseUrl = url.baseUrl});

  Future<http.Response> get(String endpoint) async {
    final String url = '$baseUrl$endpoint';
    final String? accessToken = await getAccessToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Token $accessToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body,
      {bool isAuthenticated = true}) async {
    final String url = '$baseUrl$endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          if (isAuthenticated)
            'Authorization': 'Token ${await getAccessToken()}',
          'Accept': 'application/json',
        },
        body: body,
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<http.Response> update(String endpoint, dynamic body) async {
    final String url = '$baseUrl$endpoint';
    final String? accessToken = await getAccessToken();

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Token $accessToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<http.Response> patch(String endpoint, dynamic body) async {
    final String url = '$baseUrl$endpoint';
    final String? accessToken = await getAccessToken();

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Token $accessToken',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(body),
      );
      return response;
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
