import 'package:flutter/widgets.dart';
import 'package:ngantor/services/api/crud/auth/auth_services.dart';
import 'package:ngantor/utils/widgets/snackbar.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _response = {};

  bool get isLoading => _isLoading;
  Map<String, dynamic> get response => _response;

  void registerUser(BuildContext context, {required String name, required String email, required String password}) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _response = await AuthServices().register(name, email, password);

      if (_response["success"] == true) {
        showSnackBar(context, _response['data']['message']);
        Navigator.pushReplacementNamed(context, "/login");
        
      } else {
        showSnackBar(context, _response['message']);
      }
      
    } catch (e) {
      print("ada error pas register: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }

  }
}