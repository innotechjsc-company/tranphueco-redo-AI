import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/mobile_shell.dart';
import '../../../shared/widgets/bottom_tab_bar.dart';
import '../application/home_controller.dart';
import 'widgets/home_luxe_header.dart';
import 'widgets/home_quick_actions.dart';
import 'widgets/home_checkin_card.dart';
import 'widgets/home_stats_strip.dart';
import 'widgets/home_reward_grid.dart';
import 'widgets/home_utility_grid.dart';
import 'widgets/home_handbook_strip.dart';
import 'widgets/home_news_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFeed = ref.watch(homeFeedProvider);

    return MobileShell(
      backgroundColor: AppColors.background,
      withTabBar: true,
      bottomBar: BottomTabBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) return;
          if (i == 1) context.push('/shop');
          if (i == 2) context.push('/spin');
          if (i == 3) context.push('/profile');
        },
      ),
      child: asyncFeed.when(
        loading: () => const HomeSkeleton(),
        error: (e, _) =>
            HomeErrorView(onRetry: () => ref.invalidate(homeFeedProvider)),
        data: (feed) => RefreshIndicator(
          color: AppColors.brandRed,
          onRefresh: () async => ref.invalidate(homeFeedProvider),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: HomeHeaderWithPoints(
                  user: feed.user,
                  unread: feed.unreadNotifications,
                ),
              ),
              const SliverToBoxAdapter(child: HomeQuickActions()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: HomeCheckinCard(summary: feed.checkin)),
              SliverToBoxAdapter(child: HomeStatsStrip(stats: feed.stats)),
              const SliverToBoxAdapter(
                child: SectionTitle(title: 'Đổi điểm hot', routeTo: '/shop'),
              ),
              SliverToBoxAdapter(
                  child:
                      HomeRewardGrid(rewards: feed.rewards.take(10).toList())),
              const SliverToBoxAdapter(child: SectionTitle(title: 'Tiện ích')),
              const SliverToBoxAdapter(child: HomeUtilityGrid()),
              const SliverToBoxAdapter(
                child: SectionTitle(title: 'Sổ tay', routeTo: '/handbook'),
              ),
              SliverToBoxAdapter(
                  child: HomeHandbookStrip(notes: feed.handbookNotes)),
              const SliverToBoxAdapter(
                child: SectionTitle(title: 'Tin tức ECOTP', routeTo: '/news'),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverList.separated(
                  itemCount: feed.news.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => NewsRowCard(item: feed.news[i]),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: const [
        _Shimmer(height: 200),
        SizedBox(height: 24),
        _ShimmerRow(),
        SizedBox(height: 24),
        _ShimmerBox(height: 120, radius: 28),
        SizedBox(height: 24),
        _ShimmerRow(),
        SizedBox(height: 24),
        _ShimmerGrid(),
      ],
    );
  }
}

class _Shimmer extends StatelessWidget {
  final double height;
  const _Shimmer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  const _ShimmerRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
            4,
            (_) => Expanded(
                    child: Container(
                  height: 56,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(28),
                  ),
                ))),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double radius;
  const _ShimmerBox({required this.height, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _ShimmerGrid extends StatelessWidget {
  const _ShimmerGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.72,
        children: List.generate(
            4,
            (_) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                  ),
                )),
      ),
    );
  }
}

class HomeErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const HomeErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.cloudOff, size: 48, color: AppColors.brandRed),
          const SizedBox(height: 12),
          const Text(
            'Không tải được trang chủ',
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
