import 'package:flutter/material.dart';
import 'package:structure_flutter/core/helpers/constants.dart';
import 'ui.dart';

class AppTheme {
  ThemeData light([Locale locale = const Locale('en')]) {
    String currentFont = locale.languageCode == "en"
        ? AppConstants.englishAppFont
        : AppConstants.arabicAppFont;
    TextTheme lightTextTheme = TextTheme(
      labelMedium: TextStyle(
        fontFamily: currentFont,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        // color: AppColors.navy,
      ),
      //font family
      bodyLarge: TextStyle(
        fontFamily: currentFont,
        fontSize: AppFonts.body1,
        color: AppColors.black,
      ),
      bodyMedium: TextStyle(
        fontFamily: currentFont,
        fontSize: AppFonts.body2,
        color: AppColors.black,
      ),
      bodySmall: TextStyle(fontFamily: currentFont),
      displayLarge: TextStyle(fontFamily: currentFont),
      displayMedium: TextStyle(fontFamily: currentFont),
      displaySmall: TextStyle(fontFamily: currentFont),
      headlineLarge: TextStyle(
        fontFamily: currentFont,
        color: AppColors.secondary,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      headlineMedium: TextStyle(fontFamily: currentFont),
      headlineSmall: TextStyle(
        fontFamily: currentFont,
        fontSize: AppFonts.heading5,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontFamily: currentFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColors.primary,
      ),
      labelSmall: TextStyle(fontFamily: currentFont),
      titleLarge: TextStyle(
        fontFamily: currentFont,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      titleMedium: TextStyle(
        fontFamily: currentFont,
        color: AppColors.primary.shade200,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(fontFamily: currentFont),
    );
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      brightness: Brightness.light,
      fontFamily: currentFont,
      unselectedWidgetColor: AppColors.primary,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors
                .primary; // Change color for checked state if needed
          } else {
            return Colors.white;
          }
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(
          color: AppColors.primary, // Define the border color
          width: 2.0, // Define the border width
        ),
      ),
      primaryColor: AppColors.primary,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            TextStyle(fontFamily: currentFont, color: AppColors.black),
          ),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.grey,
      ),
      colorScheme: const ColorScheme(
        error: AppColors.error,
        onSecondary: AppColors.secondary,
        brightness: Brightness.light,
        onPrimary: AppColors.white,
        surface: AppColors.white,
        onError: AppColors.error,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        onSurface: AppColors.black,
        // background: AppColors.screenBackground,
        // onSurface: AppColors.onSurface,
        // onBackground: AppColors.background,
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: AppColors.hide,
        shadowColor: AppColors.hide,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
      ),
      textTheme: lightTextTheme,
      // dividerColor: AppColors.darkDivider,
    );
  }
}
