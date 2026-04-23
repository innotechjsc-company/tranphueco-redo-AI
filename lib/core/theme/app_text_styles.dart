import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  // Display - Playfair Display (luxurious serif)
  static TextStyle displayXl = const TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 36,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -0.5,
    color: AppColors.foreground,
  );
  static TextStyle displayLg = const TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 28,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.3,
    color: AppColors.foreground,
  );

  // Headings - Open Sans
  static TextStyle h1 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: 1.2,
    color: AppColors.foreground,
  );
  static TextStyle h2 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.foreground,
  );
  static TextStyle h3 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.foreground,
  );
  static TextStyle h4 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.foreground,
  );

  // Body - Open Sans
  static TextStyle bodyLg = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.foreground,
  );
  static TextStyle bodyMd = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.foreground,
  );
  static TextStyle bodySm = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.mutedForeground,
  );
  static TextStyle body = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.foreground,
  );
  static TextStyle caption = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.mutedForeground,
  );

  // Labels - bold, semibold
  static TextStyle labelMd = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.foreground,
  );

  /// .heading-upper - uppercase, letter-spacing 0.08em, weight 800
  static TextStyle headingUpper({double fontSize = 12, Color? color}) =>
      TextStyle(
        fontFamily: 'OpenSans',
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        letterSpacing: fontSize * 0.08,
        color: color ?? AppColors.foreground,
      );

  static TextStyle slogan = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 10,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w600,
    color: AppColors.brandGold,
    letterSpacing: 2.5,
  );
}
