import 'package:flutter/material.dart';

/// Bảng màu thương hiệu Trần Phú ECOTP.
/// App luôn ở Dark Mode - matching demo web.
abstract class AppColors {
  AppColors._();

  // ================= DARK MODE (Default) =================
  static const Color background = Color(0xFF0A0B14);
  static const Color foreground = Color(0xFFFAFAFB);
  static const Color card = Color(0xFF161828);
  static const Color cardAlt = Color(0xFF1C1F30);
  static const Color secondary = Color(0xFF1E2235);
  static const Color muted = Color(0xFF2A2F46);
  static const Color mutedForeground = Color(0xFF9CA3AF);
  static const Color border = Color(0x1AFFFFFF); // 10% white
  static const Color shellBg = Color(0xFF080A14);
  static const Color surface = Color(0xFF12141E);

  // ================= BRAND TOKENS =================
  // Đỏ thương hiệu - Trần Phú signature
  static const Color brandRed = Color(0xFFD22A2D);
  static const Color brandRedLight = Color(0xFFE63E40);
  static const Color brandRedDark = Color(0xFFA8181B);
  static const Color brandRedFg = Color(0xFFFEFEFD);

  // Navy - text & dark surfaces
  static const Color brandNavy = Color(0xFF1B2238);
  static const Color brandNavyFg = Color(0xFFFEFEFD);
  static const Color brandNavyDeep = Color(0xFF0E1322);

  // Gold - premium accents
  static const Color brandOrange = Color(0xFFD08F4E);
  static const Color brandGoldLight = Color(0xFFF8E9B8);
  static const Color brandGold = Color(0xFFE8CC6A);
  static const Color brandGoldDark = Color(0xFF9C7A30);

  static const glassWhite = Color(0x14FFFFFF);
  static const glassBorder = Color(0x1AFFFFFF);
  static const white55 = Color(0x8CFFFFFF);
  static const white60 = Color(0x99FFFFFF);
}
