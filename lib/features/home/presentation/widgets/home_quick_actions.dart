import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';

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

class _QuickActionTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String route;
  const _QuickActionTile(
      {required this.icon, required this.label, required this.route});

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.95),
        onTapUp: (_) => setState(() => _scale = 1.0),
        onTapCancel: () => setState(() => _scale = 1.0),
        onTap: () {
          HapticFeedback.selectionClick();
          context.push(widget.route);
        },
        child: Transform.scale(
          scale: _scale,
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1), width: 1.5),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
