import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.routeTo,
    this.actionLabel = 'Xem tất cả',
  });

  final String title;
  final String? routeTo;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            color: AppColors.brandRed,
            margin: const EdgeInsets.only(right: 8),
          ),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: AppTextStyles.headingUpper(fontSize: 14),
            ),
          ),
          if (routeTo != null)
            GestureDetector(
              onTap: () => context.push(routeTo!),
              child: Row(
                children: [
                  Text(actionLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mutedForeground,
                      )),
                  const Icon(LucideIcons.chevronRight,
                      size: 14, color: AppColors.mutedForeground),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
