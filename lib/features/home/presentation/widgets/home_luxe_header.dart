import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../shared/widgets/points_card.dart';

class HomeLuxeHeader extends StatelessWidget {
  final User user;
  final int unread;
  const HomeLuxeHeader({super.key, required this.user, required this.unread});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, MediaQuery.paddingOf(context).top + 16, 16, 96),
      decoration: const BoxDecoration(gradient: AppGradients.luxe),
      child: Stack(
        children: [
          Positioned(
            top: -64,
            right: -64,
            child: IgnorePointer(
              child: ExcludeSemantics(
                child: Opacity(
                  opacity: 0.30,
                  child:
                      SvgPicture.asset('assets/brand/element.svg', width: 224),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: IgnorePointer(
              child: ExcludeSemantics(
                child: Transform.rotate(
                  angle: math.pi,
                  child: Opacity(
                    opacity: 0.20,
                    child: SvgPicture.asset('assets/brand/element.svg',
                        width: 192),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserRow(user: user, unread: unread),
              const SizedBox(height: 20),
              Row(children: [
                const Icon(LucideIcons.crown,
                    size: 16, color: AppColors.brandGold),
                const SizedBox(width: 8),
                Text.rich(TextSpan(
                  style: const TextStyle(fontSize: 11, color: Colors.white70),
                  children: [
                    const TextSpan(text: 'Hạng '),
                    TextSpan(
                      text: user.rank,
                      style: const TextStyle(
                          color: AppColors.brandGold,
                          fontWeight: FontWeight.w800),
                    ),
                    const TextSpan(text: ' · Tích lũy năm 2025'),
                  ],
                )),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final User user;
  final int unread;
  const _UserRow({required this.user, required this.unread});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, gradient: AppGradients.gold),
        child: Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, gradient: AppGradients.red),
          alignment: Alignment.center,
          child: Text(
            user.name.characters.first,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'XIN CHÀO',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: AppColors.brandGold.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ]),
      ),
      _CircleIconButton(
          icon: LucideIcons.search, onTap: () => context.push('/search')),
      const SizedBox(width: 8),
      _CircleIconButton(
        icon: LucideIcons.bell,
        badge: unread > 0 ? unread : null,
        onTap: () => context.push('/notifications'),
      ),
    ]);
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final int? badge;
  final VoidCallback onTap;
  const _CircleIconButton(
      {required this.icon, this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipOval(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
            ),
          ),
          if (badge != null)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.brandRed,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.brandNavy, width: 2),
                ),
                child: Center(
                  child: Text(
                    badge.toString(),
                    style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class HomeHeaderWithPoints extends StatelessWidget {
  final User user;
  final int unread;
  const HomeHeaderWithPoints(
      {super.key, required this.user, required this.unread});

  static const double kHeaderHeight = 250;
  static const double kPointsCardHeight = 180;
  static const double kOverlap = 64;

  @override
  Widget build(BuildContext context) {
    const stackHeight = kHeaderHeight + kPointsCardHeight - kOverlap;

    return SizedBox(
      height: stackHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: kHeaderHeight,
            child: HomeLuxeHeader(user: user, unread: unread),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: kHeaderHeight - kOverlap,
            height: kPointsCardHeight,
            child: PointsCard(
              points: user.points,
              rank: user.rank,
              rankProgress: user.rankProgress,
              memberCode: user.memberCode,
            ),
          ),
        ],
      ),
    );
  }
}
