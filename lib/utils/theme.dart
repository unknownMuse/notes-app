import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/utils/utils.dart';

class NotesAppTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
    ),
    headline2: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
    ),
    bodyText1: GoogleFonts.roboto(
      fontSize: 18,
    ),
    bodyText2: GoogleFonts.roboto(
      color: const Color(0xFF6C757D),
      fontSize: 22,
    ),
  );

  static ThemeData lightTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return ThemeData(
      textTheme: lightTextTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.fabBgColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}
