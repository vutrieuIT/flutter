import 'dart:convert';
import 'dart:js_util';

import 'package:app/Constant.dart';
import 'package:http/http.dart' as http;

class RemoteAuthService {
  var client = http.Client();

  Future<dynamic> login(
      {required String email, required String password}) async {
    var body = {"username": email, "email": email, "password": password};

    var response = await client.post(
      Uri.parse('$baseUrl/api/auth/local/register'),
      headers: {"Content-type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile(
      {required String fullName, required String token}) async {
    var body = {
      "fullName": fullName,
    };

    var response = await client.post(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
