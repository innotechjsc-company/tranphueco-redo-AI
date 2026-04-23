import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_gradients.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/mock/mock_providers.dart';
import '../../shared/widgets/brand_header.dart';

class CheckinPage extends ConsumerWidget {
  const CheckinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(checkinWeekProvider);
    return Container(
      decoration: const BoxDecoration(gradient: AppGradients.dark),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: Column(children: [
          const BrandHeader(title: 'Điểm danh hàng ngày'),
          const SizedBox(height: 24),
          Text('TUẦN NÀY', style: AppTextStyles.headingUpper(fontSize: 14, color: AppColors.brandGold)),
          const SizedBox(height: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: days.map((d) {
                final isClaimed = d.claimed;
                final isToday = d.today;
                return Column(children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isClaimed ? AppColors.brandGold : isToday ? AppColors.brandRed : Colors.white10,
                      border: isToday && !isClaimed ? Border.all(color: AppColors.brandRed, width: 2) : null),
                    child: Center(child: isClaimed
                      ? const Icon(Icons.check, color: AppColors.brandNavy, size: 20)
                      : Text('+${d.reward}', style: TextStyle(
                          color: isToday ? Colors.white : Colors.white54,
                          fontSize: 11, fontWeight: FontWeight.w700))),
                  ),
                  const SizedBox(height: 6),
                  Text(d.day, style: TextStyle(
                    color: isClaimed ? AppColors.brandGold : Colors.white54,
                    fontSize: 12, fontWeight: FontWeight.w600)),
                ]);
              }).toList())),
          const SizedBox(height: 40),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(width: double.infinity, height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandRed, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
                child: const Text('ĐIỂM DANH HÔM NAY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))))),
          const SizedBox(height: 16),
          Text('Điểm danh 7 ngày liên tiếp nhận thưởng x2!',
            style: AppTextStyles.bodySm.copyWith(color: Colors.white54)),
        ])),
      ),
    );
  }
}
