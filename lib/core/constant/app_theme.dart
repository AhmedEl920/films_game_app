import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_app/core/constant/app_color.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    cardColor: AppColors.cardBackground,
    dividerColor: AppColors.divider,
    fontFamily: 'arsura',

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.black,
      elevation: 0,
      centerTitle: true,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.divider,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: .2),
      trackHeight: 4,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardBackground,

      floatingLabelStyle: const TextStyle(color: AppColors.primary),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      labelStyle: const TextStyle(color: AppColors.textPrimary,fontFamily: 'Amiri'),

      hintStyle: const TextStyle(color: AppColors.textSecondary,fontFamily: 'Amiri'),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.divider),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp),

      bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),

      bodySmall: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),

      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),

      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),

      titleSmall: TextStyle(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),

      labelLarge: TextStyle(
        fontFamily: "Amiri",
        fontWeight: FontWeight.bold,
        fontSize: 30.sp,
        color: AppColors.white,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.primary),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,

      backgroundColor: AppColors.cardBackground,

      selectedItemColor: AppColors.primary,

      unselectedItemColor: AppColors.textSecondary,

      selectedIconTheme: IconThemeData(color: AppColors.primary, size: 24.sp),

      unselectedIconTheme: IconThemeData(
        color: AppColors.textSecondary,
        size: 24.sp,
      ),

      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),

      unselectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,

      surface: AppColors.cardBackground,

      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.textPrimary,

      error: AppColors.error,
      onError: AppColors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkCardBackground,
    dividerColor: AppColors.darkDivider,
    fontFamily: 'arsura',

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.darkDivider,
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: .2),
      trackHeight: 4,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCardBackground,

      floatingLabelStyle: const TextStyle(color: AppColors.primary),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      labelStyle: const TextStyle(color: AppColors.darkTextPrimary),

      hintStyle: const TextStyle(color: AppColors.darkTextSecondary),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkDivider),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary, fontSize: 18.sp),

      bodyMedium: TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 16.sp,
      ),

      bodySmall: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14.sp),

      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),

      titleMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),

      titleSmall: TextStyle(
        color: AppColors.darkTextSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),

      labelLarge: TextStyle(
        fontFamily: "arsura",
        fontWeight: FontWeight.bold,
        fontSize: 30.sp,
        color: AppColors.primary,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.primary),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,

      backgroundColor: AppColors.darkCardBackground,

      selectedItemColor: AppColors.primary,

      unselectedItemColor: AppColors.darkTextSecondary,

      selectedIconTheme: IconThemeData(color: AppColors.primary, size: 24.sp),

      unselectedIconTheme: IconThemeData(
        color: AppColors.darkTextSecondary,
        size: 24.sp,
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,

      surface: AppColors.darkCardBackground,

      onPrimary: AppColors.black,
      onSecondary: AppColors.black,
      onSurface: AppColors.darkTextPrimary,

      error: AppColors.error,
      onError: AppColors.white,
    ),
  );
}
