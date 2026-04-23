import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  AppTheme._();

  /// App luôn ở dark mode - matching demo web
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.brandRed,
          onPrimary: AppColors.brandRedFg,
          secondary: AppColors.brandGold,
          onSecondary: AppColors.brandNavy,
          surface: AppColors.card,
          onSurface: AppColors.foreground,
          error: AppColors.brandRed,
          onError: Colors.white,
        ),
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          displayLarge: AppTextStyles.displayXl,
          displayMedium: AppTextStyles.displayLg,
          bodyLarge: AppTextStyles.bodyLg,
          bodyMedium: AppTextStyles.bodyMd,
          bodySmall: AppTextStyles.bodySm,
          labelMedium: AppTextStyles.labelMd,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        cardTheme: CardThemeData(
          color: AppColors.card,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
        ),
      );
}
