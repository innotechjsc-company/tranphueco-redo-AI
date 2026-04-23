import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashLoader extends StatelessWidget {
  final double progress;
  const SplashLoader({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Stack(
              children: [
                Container(height: 2, color: Colors.white.withOpacity(0.10)),
                AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 100),
                  widthFactor: progress,
                  child: Container(
                    height: 2,
                    decoration:
                        const BoxDecoration(gradient: AppGradients.gold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('CHẠM ĐỂ TIẾP TỤC →',
              style: AppTextStyles.headingUpper(color: AppColors.white60)),
        ],
      ),
    );
  }
}
