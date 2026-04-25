import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../domain/home_feed.dart';

class HomeCheckinCard extends StatelessWidget {
  final CheckinSummary summary;
  const HomeCheckinCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          context.push('/checkin');
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppGradients.red,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandRed.withValues(alpha: 0.4),
                blurRadius: 40,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: -8,
                right: -16,
                child: IgnorePointer(
                  child: ExcludeSemantics(
                    child: Opacity(
                      opacity: 0.50,
                      child: SvgPicture.asset(
                        'assets/brand/footer.svg',
                        width: 176,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        child: const Center(
                          child: Icon(LucideIcons.calendarCheck,
                              color: Colors.white, size: 24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.flame,
                                size: 12, color: AppColors.brandGold),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'ĐIỂM DANH — CHUỖI ${summary.streakDays} NGÀY',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ShaderMask(
                          shaderCallback: (rect) =>
                              AppGradients.gold.createShader(rect),
                          child: Text(
                            '+${summary.todayReward} điểm',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          summary.sundayDoubled
                              ? 'CN sắp tới: thưởng x2'
                              : 'Hôm nay: nhận thưởng',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(LucideIcons.chevronRight,
                      color: Colors.white, size: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
