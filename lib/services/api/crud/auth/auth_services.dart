import 'dart:convert';

import 'package:ngantor/services/api/repo/repo_login_register.dart';
class AuthServices {
  
  Future<Map<String, dynamic>> register(String name, String email, String password) async{
    final response = await registerUserAPI(name, email, password);

    if (response.statusCode == 200) {
      return {
          'success': true,
          'data': jsonDecode(response.body),
        };
    }else{
      return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Terjadi kesalahan',
        };
    }
  }
  
}
