import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngantor/models/absen_model.dart';
import 'package:ngantor/services/providers/attendance_provider.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/widgets/dialog.dart';

Widget buildListAbsensi(List<Datum> absensi, AttendanceProvider provider) {
  return ListView.builder(
    itemCount: absensi.length,
    itemBuilder: (context, index) {
      final absen = absensi[index];
      final formattedDateCheckIn = absen.checkIn != null
          ? DateFormat('dd MMM yyyy – HH:mm').format(absen.checkIn!)
          : 'Tidak diketahui';
      final formattedDateCheckOut = absen.checkOut != null
          ? DateFormat('dd MMM yyyy – HH:mm').format(absen.checkIn!)
          : 'Belum Checkout';

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Text(formattedDateCheckIn,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    absen.status ?? "Status tidak diketahui",
                    style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 10),
                if (absen.checkOut != null)
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "pulang",
                      style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Check-in:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      absen.checkInAddress ?? "-",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),

                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Text(
                      'Waktu Check-out:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      formattedDateCheckOut,
                      style: TextStyle(
                        color: absen.checkOut != null
                            ? AppColors.textSecondary
                            : AppColors.warning,
                        fontStyle: absen.checkOut == null ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                    Text(
                      'Alamat Check-out:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      absen.checkOutAddress ?? "-",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () async{
                          CustomDialog().loading(context);
                          provider.deleteAbsenUser(context, id: absen.id!);
                        }, 
                        icon: Icon(Icons.delete, color: AppColors.warning,)
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}