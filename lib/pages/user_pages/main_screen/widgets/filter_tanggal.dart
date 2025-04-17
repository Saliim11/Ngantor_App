import 'package:flutter/material.dart';
import 'package:ngantor/services/providers/widget_provider.dart';
import 'package:ngantor/utils/colors/app_colors.dart';

GestureDetector datePicker(BuildContext context, WidgetProvider wProv, TextEditingController selectedDate) {
  return GestureDetector(
    onTap: () {
      wProv.pickDate(context, selectedDate);
    },
    child: AbsorbPointer(
      child: TextField(
        controller: selectedDate,
        style: TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: "Masukkan Tanggal",
          hintStyle: TextStyle(color: AppColors.textPrimary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8)
          ),
        ),
      ),
    ),
  );
}