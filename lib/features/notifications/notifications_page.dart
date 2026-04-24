import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../data/mock/mock_data.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';
import '../../shared/widgets/glass_card.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const BrandHeader(title: 'Thông báo'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  itemCount: notifications.length,
                  itemBuilder: (_, i) {
                    final n = notifications[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color:
                                    _typeColor(n.type).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(_typeIcon(n.type),
                                  color: _typeColor(n.type), size: 18),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(n.title,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: n.unread
                                                      ? FontWeight.w700
                                                      : FontWeight.w500,
                                                  fontSize: 14))),
                                      if (n.unread)
                                        Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                                color: AppColors.brandRed,
                                                shape: BoxShape.circle)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(n.message,
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(n.time,
                                      style: const TextStyle(
                                          color: Colors.white30, fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _typeColor(NotificationType type) {
    switch (type) {
      case NotificationType.promo:
        return AppColors.brandGold;
      case NotificationType.reward:
        return const Color(0xFF2ECC71);
      case NotificationType.system:
        return AppColors.mutedForeground;
    }
  }

  IconData _typeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.promo:
        return Icons.local_offer;
      case NotificationType.reward:
        return Icons.stars;
      case NotificationType.system:
        return Icons.info_outline;
    }
  }
}
