import 'package:flutter/widgets.dart';
import 'package:ngantor/services/api/crud/auth/auth_services.dart';
import 'package:ngantor/utils/widgets/snackbar.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _responseReg = {};

  bool get isLoading => _isLoading;
  Map<String, dynamic> get responseReg => _responseReg;
  
  Map<String, dynamic> _responseLog = {};
  Map<String, dynamic> get responseLog => _responseLog;

  void registerUser(BuildContext context, {required String name, required String email, required String password}) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _responseReg = await AuthServices().register(name, email, password);

      if (_responseReg["success"] == true) {
        showSnackBar(context, _responseReg['data']['message']);
        Navigator.pushReplacementNamed(context, "/login");
        
      } else {
        showSnackBar(context, _responseReg['message']);
      }
      
    } catch (e) {
      print("error saat register: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void loginUser(BuildContext context, {required String email, required String password}) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _responseLog = await AuthServices().login(email, password);

      if (_responseLog["success"] == true) {
        showSnackBar(context, _responseLog['data']['message']);
        Navigator.pushReplacementNamed(context, "/main");
        
      } else {
        showSnackBar(context, _responseLog['message']);
      }
      
    } catch (e) {
      print("error saat login: $e");

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}