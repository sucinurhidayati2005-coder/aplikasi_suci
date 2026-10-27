import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF14284B);
  static const royal = Color(0xFF2547A8);
  static const paper = Color(0xFFF4F6FB);
  static const lost = Color(0xFFE5484D);
  static const found = Color(0xFF1FA67A);
  static const ink = Color(0xFF101828);
  static const muted = Color(0xFF667085);

  static const headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [navy, royal],
  );
}

const softShadow = [
  BoxShadow(color: Color(0x1A101828), blurRadius: 20, offset: Offset(0, 8)),
];

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.royal).copyWith(
    primary: AppColors.royal,
    onPrimary: Colors.white,
    secondary: AppColors.royal,
  );

  OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c, width: w),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.paper,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF2F4F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border(Colors.transparent),
      enabledBorder: border(Colors.transparent),
      focusedBorder: border(AppColors.royal, 1.6),
      errorBorder: border(AppColors.lost),
      focusedErrorBorder: border(AppColors.lost, 1.6),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
