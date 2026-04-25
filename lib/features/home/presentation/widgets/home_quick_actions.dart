import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Row(
        children: [
          _QuickActionTile(
              icon: LucideIcons.scanLine, label: 'Quét mã', route: '/scan'),
          _QuickActionTile(
              icon: LucideIcons.gift, label: 'Đổi điểm', route: '/shop'),
          _QuickActionTile(
              icon: LucideIcons.sparkles, label: 'Vòng quay', route: '/spin'),
          _QuickActionTile(
              icon: LucideIcons.ticket, label: 'Voucher', route: '/vouchers'),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  const _QuickActionTile(
      {required this.icon, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          context.push(route);
        },
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1), width: 1.5),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
