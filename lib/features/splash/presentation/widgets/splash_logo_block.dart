import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashLogoBlock extends StatelessWidget {
  const SplashLogoBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(color: AppColors.brandGold.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandGold.withValues(alpha: 0.25),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Image.asset('assets/brand/logo.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.displayLg,
            children: [
              const TextSpan(text: 'Trần Phú '),
              TextSpan(
                text: 'ECOTP',
                style: AppTextStyles.displayLg.copyWith(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        AppColors.brandGoldLight,
                        AppColors.brandGold,
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 40)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 32,
                height: 1,
                color: AppColors.brandGold.withValues(alpha: 0.6)),
            const SizedBox(width: 8),
            Text('DẪN ĐẦU TƯƠNG LAI', style: AppTextStyles.slogan),
            const SizedBox(width: 8),
            Container(
                width: 32,
                height: 1,
                color: AppColors.brandGold.withValues(alpha: 0.6)),
          ],
        ),
      ],
    );
  }
}
