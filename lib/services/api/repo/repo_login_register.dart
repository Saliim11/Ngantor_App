import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ngantor/services/api/endpoint.dart';

Future<http.Response> registerUserAPI(String name, String email, String password) {
  return http.post(
    Uri.parse("${Endpoint.baseUrl}/api/register"),
    body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
  );
}

Future<http.Response> loginUserAPI() {
  return http.post(Uri.parse("${Endpoint.baseUrl}/api/login"));
}
