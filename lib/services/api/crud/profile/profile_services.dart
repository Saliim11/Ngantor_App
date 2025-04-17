import 'dart:convert';

import 'package:ngantor/models/user_model.dart';
import 'package:ngantor/services/api/repo/profile_repo.dart';

class ProfileServices {
  Future<UserModel> getProfile(String token) async{
    // dapatkan response dari API
    final response = await getProfileAPI(token);
    final json = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      return UserModel.fromJson(json as Map<String, dynamic>);
    }else{
      throw Exception('Failed to load Profile');
    }
  }

}