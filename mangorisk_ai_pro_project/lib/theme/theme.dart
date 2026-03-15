import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class C {

  static const bg = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFAFAFA);

  static const textPrimary = Color(0xFF111111);
  static const textSecondary = Color(0xFF6B6B6B);

  static const border = Color(0xFFE8E8E8);

  static const accent = Color(0xFFF5A623);

  static const win = Color(0xFF16A34A);
  static const loss = Color(0xFFDC2626);
}

class AppTheme {

  static ThemeData get lightTheme {

    return ThemeData(

      scaffoldBackgroundColor: C.bg,

      textTheme: GoogleFonts.interTextTheme(),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: C.textPrimary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: C.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: C.border),
        ),
      ),
    );
  }
}
