import 'package:flutter/material.dart';

abstract class AppGradients {
  AppGradients._();

  /// gradient-gold - vàng sang trọng cho PointsCard
  static const LinearGradient gold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFAEFC2), // 0%
      Color(0xFFEFD487), // 35%
      Color(0xFFC79E48), // 70%
      Color(0xFF9D7C32), // 100%
    ],
    stops: [0.0, 0.35, 0.70, 1.0],
  );

  /// gradient-red - CTA buttons
  static const LinearGradient red = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE6383A), Color(0xFFB81E21)],
  );

  /// gradient-dark - page background
  static const LinearGradient dark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF12141E), Color(0xFF0A0B14)],
  );

  /// gradient-luxe - Header onboarding / home (navy → reddish black)
  static const LinearGradient luxe = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1B2238),
      Color(0xFF38221F),
      Color(0xFF6E2E26),
    ],
    stops: [0.0, 0.6, 1.0],
  );

  /// gradient-home-header - phần trên home (dark with subtle warm tones)
  static const LinearGradient homeHeader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A1D2E),
      Color(0xFF12141E),
    ],
  );

  static const splashOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
    colors: [
      Color(0xB3000000),
      Color(0x59000000),
      Color(0xD9000000),
    ],
  );

  /// gradient-checkin-banner - red banner for check-in card
  static const LinearGradient checkinBanner = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFD22A2D),
      Color(0xFFE6383A),
    ],
  );
}
