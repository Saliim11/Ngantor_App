import 'package:flutter/widgets.dart';
import 'package:ngantor/services/api/crud/auth/auth_services.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _response = {};

  bool get isLoading => _isLoading;
  Map<String, dynamic> get response => _response;

  void registerUser(String name, String email, String password) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _response = await AuthServices().register(name, email, password);
      
    } catch (e) {
      print("ada error pas register: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }
}