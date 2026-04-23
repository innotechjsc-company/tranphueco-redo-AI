import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.size, this.semanticLabel = 'Trần Phú ECOTP'});

  final double? size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/brand/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
      errorBuilder: (_, __, ___) => Container(
        width: size ?? 36,
        height: size ?? 36,
        decoration: BoxDecoration(
          color: const Color(0xFFD22A2D),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'TP',
            style: TextStyle(
              color: Colors.white,
              fontSize: (size ?? 36) * 0.4,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
