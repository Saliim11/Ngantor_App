import 'package:flutter/widgets.dart';
import 'package:ngantor/services/api/crud/auth/auth_services.dart';
import 'package:ngantor/services/shared_preferences/prefs_handler.dart';
import 'package:ngantor/utils/widgets/loading_dialog.dart';
import 'package:ngantor/utils/widgets/snackbar.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _responseReg = {};

  bool get isLoading => _isLoading;
  Map<String, dynamic> get responseReg => _responseReg;
  
  Map<String, dynamic> _responseLog = {};
  Map<String, dynamic> get responseLog => _responseLog;

  Future<void> registerUser(BuildContext context, {required String name, required String email, required String password}) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _responseReg = await AuthServices().register(name, email, password);

      if (_responseReg["success"] == true) {
        showSnackBar(context, _responseReg['data']['message']);
        hideLoadingDialog(context);
        Navigator.pushReplacementNamed(context, "/login");
        
      } else {
        hideLoadingDialog(context);
        showSnackBar(context, _responseReg['message']);
      }
      
    } catch (e) {
      print("error saat register: $e");
      hideLoadingDialog(context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser(BuildContext context, {required String email, required String password}) async{
    _isLoading = true;
    notifyListeners();
    
    try {
      _responseLog = await AuthServices().login(email, password);

      if (_responseLog["success"] == true) {
        PrefsHandler.saveToken(_responseLog['data']['data']['token']);
        showSnackBar(context, _responseLog['data']['message']);
        hideLoadingDialog(context);
        Navigator.pushReplacementNamed(context, "/main");
        
      } else {
        hideLoadingDialog(context);
        showSnackBar(context, _responseLog['message']);
      }
      
    } catch (e) {
      print("error saat login: $e");
      hideLoadingDialog(context);

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}