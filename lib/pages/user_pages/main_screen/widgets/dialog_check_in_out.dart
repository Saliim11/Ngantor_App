import 'package:flutter/material.dart';
import 'package:ngantor/services/providers/attendance_provider.dart';
import 'package:ngantor/services/shared_preferences/prefs_handler.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/styles/app_btn_style.dart';

Future<dynamic> dialog_check_in_out(BuildContext context, String _currentAddress2, AttendanceProvider attendProv, double _currentLat, double _currentLong, String _currentAddress) {
    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text("Check in Kantor"),
          content: Text("Anda akan melakukan checkin di\n$_currentAddress2\n"),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: (){}, 
              child: Text("Izin", style: TextStyle(color: AppColors.textPrimary))
            ),

            ElevatedButton(
              onPressed: () async{
                String token = await PrefsHandler.getToken();
                print("isi token: $token");
                await attendProv.checkInUser(context, lat: _currentLat, long: _currentLong, address: _currentAddress, token: token);
              }, 
              style: AppBtnStyle.normal,
              child: Text("Check in")
            ),
          ],
        );
      },
    );
  }