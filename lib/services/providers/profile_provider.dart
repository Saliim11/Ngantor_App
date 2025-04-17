import 'package:flutter/material.dart';
import 'package:ngantor/models/user_model.dart';
import 'package:ngantor/services/api/crud/profile/profile_services.dart';
import 'package:ngantor/services/shared_preferences/prefs_handler.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Data _dataProfile = new Data();
  Data get dataProfile => _dataProfile;

  Future<void> getdataProfile() async{
    _isLoading = true;
    notifyListeners();
    String token = await PrefsHandler.getToken();
    try {
      UserModel dataP = await ProfileServices().getProfile(token);
      _dataProfile = dataP.data!;
    } catch (e) {
      throw Exception("Failed to load data profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}