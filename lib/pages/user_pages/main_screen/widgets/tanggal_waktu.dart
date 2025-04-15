import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ngantor/utils/colors/app_colors.dart';

Container showTanggalWaktu(BuildContext context) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width * 0.8,
    margin: const EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Center(
      child: StreamBuilder<DateTime>(
        stream: Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()),
        builder: (context, snapshot) {
          final now = snapshot.data ?? DateTime.now();

          final formattedDate = DateFormat("EEEE, d MMMM yyyy").format(now);
          final formattedTime = DateFormat("HH:mm:ss").format(now);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 2,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}