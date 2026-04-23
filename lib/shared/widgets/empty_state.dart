import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const EmptyState({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.card.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 28, color: AppColors.brandGold),
        ),
        const SizedBox(height: 16),
        Text(message,
            textAlign: TextAlign.center,
            style:
                AppTextStyles.body.copyWith(color: Colors.white70)),
      ]),
    );
  }
}
