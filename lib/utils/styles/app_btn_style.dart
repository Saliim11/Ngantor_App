import 'package:flutter/material.dart';
import 'package:ngantor/utils/colors/app_colors.dart';

class AppBtnStyle {
  static ButtonStyle normal = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14),
  );
}