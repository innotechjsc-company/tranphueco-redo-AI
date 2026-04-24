import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/reward_card.dart';
import '../../shared/widgets/logo.dart';
import '../../shared/utils/number_format.dart';

class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewards = ref.watch(rewardsProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Shop Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Row(
                children: [
                  const Logo(size: 32),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'GIAN HÀNG ĐỔI ĐIỂM',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Điểm',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.mutedForeground,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatVnNumber(user.points),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.brandGold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Tìm quà tặng, voucher...',
                  hintStyle:
                      TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                  prefixIcon: const Icon(LucideIcons.search,
                      size: 20, color: Colors.white30),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Rewards Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                itemCount: rewards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (_, i) => RewardCard(reward: rewards[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
