import 'package:comic_vine_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData(
    colorScheme: const ColorScheme(
      error: ColorLight.error,
      onError: ColorLight.onError,
      onPrimary: ColorLight.onPrimary,
      onSecondary: ColorLight.onSecondary,
      onSurface: ColorLight.onSurface,
      surface: ColorLight.surface,
      brightness: Brightness.light,
      primary: ColorLight.primary,
      secondary: ColorLight.secondary,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      displaySmall: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
