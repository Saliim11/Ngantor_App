import 'dart:convert';

import 'package:ngantor/services/api/repo/attendance_repo.dart';

class AttendanceServices {
  Future<Map<String, dynamic>> checkIn(double lat, double long, String address, String token) async{
    // dapatkan response dari API
    final response = await checkInUserAPI(lat, long, address, token);
    final json = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return {
          'success': true,
          'data': json,
        };
    }else{
      return {
          'success': false,
          'message': json['message'] ?? 'Terjadi kesalahan saat checkin',
        };
    }
  }

  Future<Map<String, dynamic>> checkInIzin(double lat, double long, String address, String token, String alasan_izin) async{
    // dapatkan response dari API
    final response = await checkInIzinUserAPI(lat, long, address, token, alasan_izin);
    final json = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return {
          'success': true,
          'data': json,
        };
    }else{
      return {
          'success': false,
          'message': json['message'] ?? 'Terjadi kesalahan saat checkin',
        };
    }
  }
}