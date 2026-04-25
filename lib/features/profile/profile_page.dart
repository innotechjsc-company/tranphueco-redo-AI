import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/points_card.dart';
import '../../shared/widgets/glass_card.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
          child: Column(
            children: [
              // Profile Header
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppGradients.red,
                    ),
                    child: Center(
                      child: Text(
                        user.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                        Text(
                          user.phone,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mutedForeground,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.brandGold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(
                                color:
                                    AppColors.brandGold.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.crown,
                                  size: 12, color: AppColors.brandGold),
                              const SizedBox(width: 4),
                              Text(
                                user.rank.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.brandGold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(LucideIcons.settings, color: Colors.white70),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Points Card
              PointsCard(
                points: user.points,
                rank: user.rank,
                memberCode: user.memberCode,
                rankProgress: user.rankProgress,
              ),
              const SizedBox(height: 24),

              // Stats Row (Chuẩn demo)
              Row(
                children: [
                  _statItem('12', 'Quà đã đổi'),
                  const SizedBox(width: 10),
                  _statItem('4', 'Voucher'),
                  const SizedBox(width: 10),
                  _statItem('28', 'Lượt quay'),
                ],
              ),
              const SizedBox(height: 24),

              // Menu List
              _profileMenu(LucideIcons.calendarCheck2, 'Điểm danh tích điểm',
                  () => context.push('/checkin')),
              _profileMenu(LucideIcons.history, 'Lịch sử tích điểm',
                  () => context.push('/history')),
              _profileMenu(LucideIcons.ticket, 'Ví Voucher của tôi',
                  () => context.push('/vouchers')),
              _profileMenu(LucideIcons.mapPin, 'Hệ thống chi nhánh',
                  () => context.push('/branches')),
              _profileMenu(LucideIcons.bookOpen, 'Sổ tay kỹ thuật',
                  () => context.push('/handbook')),
              _profileMenu(LucideIcons.headphones, 'Hỗ trợ khách hàng',
                  () => context.push('/support')),

              const SizedBox(height: 12),
              _profileMenu(
                  LucideIcons.logOut, 'Đăng xuất', () => context.go('/login'),
                  isDestructive: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.brandGold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileMenu(IconData icon, String label, VoidCallback onTap,
      {bool isDestructive = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isDestructive ? AppColors.brandRed : Colors.white)
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  size: 20,
                  color: isDestructive ? AppColors.brandRed : Colors.white70),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isDestructive ? AppColors.brandRed : Colors.white,
                ),
              ),
            ),
            Icon(LucideIcons.chevronRight,
                size: 20, color: Colors.white.withValues(alpha: 0.2)),
          ],
        ),
      ),
    );
  }
}
