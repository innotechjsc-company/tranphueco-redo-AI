import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/utils/number_format.dart';
import '../../shared/widgets/glass_card.dart';

class RewardDetailPage extends ConsumerWidget {
  const RewardDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reward = ref.watch(rewardByIdProvider(id));

    if (reward == null) {
      return const Scaffold(
          body: Center(child: Text('Không tìm thấy sản phẩm')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.chevronLeft,
                        color: Colors.white, size: 28),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Text(
                      reward.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer for balance
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: CachedNetworkImage(
                        imageUrl: reward.image,
                        fit: BoxFit.contain,
                        // padding: const EdgeInsets.all(32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Pricing
                  const Text(
                    'SẢN PHẨM ĐỔI ĐIỂM',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppColors.brandGold,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Cần ${formatVnNumber(reward.points)} đ',
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          'Số lượng còn: ${reward.stock}',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.mutedForeground,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Info Tabs Placeholder
                  Row(
                    children: [
                      _tabItem('Thông tin', true),
                      const SizedBox(width: 24),
                      _tabItem('Thể lệ', false),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Text(
                    reward.description,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                        height: 1.6),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom CTA
          Container(
            padding: EdgeInsets.fromLTRB(
                20, 16, 20, 16 + MediaQuery.viewPaddingOf(context).bottom),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                  top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandRed,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'Đổi ngay',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String label, bool active) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: active ? Colors.white : AppColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 4),
        if (active)
          Container(
            width: 20,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.brandRed,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}
