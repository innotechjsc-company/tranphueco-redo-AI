import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Tiêu đề section "| Tiêu đề ... Xem tất cả >"
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final String actionLabel;
  const SectionHeader(
      {super.key,
      required this.title,
      this.onSeeAll,
      this.actionLabel = 'Xem tất cả'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Text('| ',
              style: AppTextStyles.h4
                  .copyWith(color: AppColors.brandRed)),
          Text(title, style: AppTextStyles.h4),
          const Spacer(),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: Row(children: [
                Text(actionLabel,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.mutedForeground)),
                const Icon(Icons.chevron_right,
                    size: 16, color: AppColors.mutedForeground),
              ]),
            ),
        ],
      ),
    );
  }
}
