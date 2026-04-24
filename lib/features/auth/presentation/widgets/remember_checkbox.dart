import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RememberCheckbox extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;
  const RememberCheckbox({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: value ? AppColors.brandRed : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: value ? AppColors.brandRed : AppColors.muted,
                width: 2,
              ),
            ),
            child: value
                ? const Icon(Icons.check, size: 12, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          const Text(
            'Ghi nhớ đăng nhập',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
