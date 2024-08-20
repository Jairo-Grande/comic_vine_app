import 'package:comic_vine_app/utils/colors.dart';
import 'package:flutter/material.dart';


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
  );
}
