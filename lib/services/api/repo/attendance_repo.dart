import 'package:http/http.dart' as http;
import 'package:ngantor/services/api/endpoint.dart';

Future<http.Response> checkInUserAPI(double lat, double long, String address, String token) {
  return http.post(
    Uri.parse("${Endpoint.baseUrl}/api/absen/check-in"),
    headers: {'Accept': 'application/json', 'Authorization': "Bearer $token"},
    body: ({
      "check_in_lat":"$lat",
      "check_in_lng":"$long",
      "check_in_address": address,
      "status": "masuk"
    })
  );
}
Future<http.Response> checkInIzinUserAPI(double lat, double long, String address, String token, String alasan_izin) {
  return http.post(
    Uri.parse("${Endpoint.baseUrl}/api/absen/check-in"),
    headers: {'Accept': 'application/json', 'Authorization': token},
    body: ({
      "check_in_lat":lat,
      "check_in_lng":long,
      "check_in_address": address,
      "status": "izin",
      "alasan_izin" :alasan_izin
    })
  );
}