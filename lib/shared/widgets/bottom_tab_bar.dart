import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _tabs = <_TabItem>[
    _TabItem(icon: LucideIcons.home, label: 'Trang chủ'),
    _TabItem(icon: LucideIcons.gift, label: 'Gian hàng'),
    _TabItem(icon: LucideIcons.disc3, label: 'Vòng quay'),
    _TabItem(icon: LucideIcons.user, label: 'Cá nhân'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return Container(
      height: 70 + bottomInset,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
            top: BorderSide(
                color: Colors.white.withValues(alpha: 0.05), width: 0.5)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Row(
              children: [
                _tab(0),
                _tab(1),
                const SizedBox(width: 70), // Khoảng trống cho nút Scan
                _tab(2),
                _tab(3),
              ],
            ),
          ),
          // Nút Scan trung tâm
          Positioned(
            top: -28,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => context.push('/scan'),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.red,
                    border: Border.all(color: AppColors.surface, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandRed.withValues(alpha: 0.4),
                        blurRadius: 40,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: const Icon(LucideIcons.scanLine,
                      color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(int index) {
    final t = _tabs[index];
    final active = index == currentIndex;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              t.icon,
              size: 20,
              color: active ? AppColors.brandRed : AppColors.mutedForeground,
            ),
            const SizedBox(height: 4),
            Text(
              t.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? AppColors.brandRed : AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}
