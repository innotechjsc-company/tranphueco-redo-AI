import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashBrandTop extends StatelessWidget {
  const SplashBrandTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('SINCE 1986',
            style: AppTextStyles.headingUpper(color: AppColors.brandGold)),
        const SizedBox(height: 4),
        Text('DÂY & CÁP ĐIỆN',
            style: AppTextStyles.headingUpper(color: AppColors.white55)),
      ],
    );
  }
}
