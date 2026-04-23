import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'logo.dart';

enum BrandHeaderLogo { none, left, right }

class BrandHeader extends StatelessWidget {
  const BrandHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showBack = true,
    this.right,
    this.logo = BrandHeaderLogo.none,
    this.lightText = true,
  });

  final String? title;
  final String? subtitle;
  final bool showBack;
  final Widget? right;
  final BrandHeaderLogo logo;
  final bool lightText;

  @override
  Widget build(BuildContext context) {
    final textColor = lightText ? Colors.white : AppColors.foreground;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              icon: Icon(LucideIcons.arrowLeft, color: textColor, size: 22),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            )
          else if (logo == BrandHeaderLogo.left)
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Logo(size: 36),
            ),
          if (title != null)
            Expanded(
              child: Column(
                crossAxisAlignment: showBack
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: AppTextStyles.h3.copyWith(color: textColor),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.bodySm.copyWith(
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            )
          else
            const Spacer(),
          if (logo == BrandHeaderLogo.right)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Logo(size: 36),
            ),
          if (right != null) right!,
        ],
      ),
    );
  }
}
