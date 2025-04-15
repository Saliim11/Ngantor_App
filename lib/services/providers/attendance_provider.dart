import 'package:flutter/material.dart';
import 'package:ngantor/services/api/crud/attendance/attendance_services.dart';
import 'package:ngantor/utils/widgets/dialog.dart';

class AttendanceProvider with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkInUser(BuildContext context, {required double lat, required double long, required String address, required String token}) async{
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> _responseReg = await AttendanceServices().checkIn(lat, long, address, token);

      if (_responseReg["success"] == true) {
        CustomDialog().hide(context);
        CustomDialog().message(context, pesan: _responseReg['data']['message']);
        
      } else {
        CustomDialog().hide(context);
        CustomDialog().message(context, pesan: _responseReg['message']);
      }
      
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "error saat Check in: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkInIzinUser(BuildContext context, {required double lat, required double long, required String address, required String token, required String alasan}) async{
    try {
      Map<String, dynamic> _responseReg = await AttendanceServices().checkInIzin(lat, long, address, token, alasan);

      if (_responseReg["success"] == true) {
        CustomDialog().hide(context);
        CustomDialog().message(context, pesan: _responseReg['data']['message']);
        
      } else {
        CustomDialog().hide(context);
        CustomDialog().message(context, pesan: _responseReg['message']);
      }
      
    } catch (e) {
      CustomDialog().hide(context);
      CustomDialog().message(context, pesan: "error saat Izin: $e");
    } 
  }
}