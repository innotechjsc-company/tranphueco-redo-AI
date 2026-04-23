import 'package:flutter/material.dart';
import '../../../../core/theme/app_gradients.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/splash-bg.jpg', fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(gradient: AppGradients.splashOverlay),
        ),
      ],
    );
  }
}
