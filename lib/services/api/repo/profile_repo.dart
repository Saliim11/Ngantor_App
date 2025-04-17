import 'package:http/http.dart' as http;
import 'package:ngantor/services/api/endpoint.dart';

Future<http.Response> getProfileAPI(String token) {
  return http.get(
    Uri.parse("${Endpoint.baseUrl}/api/profile"),
    headers: {'Accept': 'application/json', 'Authorization': "Bearer $token"}
  );
}