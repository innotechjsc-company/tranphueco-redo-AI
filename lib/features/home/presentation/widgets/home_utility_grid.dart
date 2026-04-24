import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

class HomeUtilityGrid extends StatelessWidget {
  const HomeUtilityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _UtilityTile(
              icon: LucideIcons.repeat,
              title: 'Chuyển điểm',
              desc: 'Gửi điểm cho bạn bè',
              route: '/transfer',
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _UtilityTile(
              icon: LucideIcons.headphones,
              title: 'Hỗ trợ',
              desc: 'Liên hệ tổng đài 24/7',
              route: '/support',
            ),
          ),
        ],
      ),
    );
  }
}

class _UtilityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String route;
  const _UtilityTile({
    required this.icon,
    required this.title,
    required this.desc,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFAEFC2),
                    Color(0xFFE8CC6A),
                    Color(0xFFC79E48),
                    Color(0xFF9D7C32)
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: AppColors.brandNavyDeep),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    desc,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
