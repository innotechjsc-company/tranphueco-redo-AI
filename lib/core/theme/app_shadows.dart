import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppShadows {
  AppShadows._();

  /// shadow-brand - đỏ glow cho CTA / FAB
  static List<BoxShadow> brand = [
    BoxShadow(
      color: AppColors.brandRed.withValues(alpha: 0.40),
      offset: const Offset(0, 14),
      blurRadius: 40,
      spreadRadius: -16,
    ),
  ];

  /// shadow-gold - vàng glow cho PointsCard
  static List<BoxShadow> gold = [
    BoxShadow(
      color: AppColors.brandGold.withValues(alpha: 0.45),
      offset: const Offset(0, 14),
      blurRadius: 40,
      spreadRadius: -10,
    ),
  ];

  /// shadow-soft - neutral elevation
  static List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.brandNavy.withValues(alpha: 0.18),
      offset: const Offset(0, 8),
      blurRadius: 30,
      spreadRadius: -12,
    ),
  ];
}
