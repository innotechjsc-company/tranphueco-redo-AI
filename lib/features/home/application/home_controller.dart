import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/mock/mock_data.dart';
import '../domain/home_feed.dart';

final homeRepositoryProvider =
    Provider<HomeRepository>((ref) => HomeRepository());

class HomeRepository {
  Future<HomeFeed> loadFeed() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HomeFeed(
      user: mockCurrentUser,
      rewards: mockRewards.take(4).toList(),
      news: mockNews.take(2).toList(),
      handbookNotes: mockHandbookNotes.take(6).toList(),
      unreadNotifications: mockNotifications.where((n) => n.unread).length,
      stats: const HomeStats(
        vouchers: 5,
        redeemed: 12,
        spinTickets: 3,
      ),
      checkin: const CheckinSummary(
        streakDays: 5,
        todayReward: 30,
        sundayDoubled: true,
      ),
    );
  }
}

final homeFeedProvider = FutureProvider.autoDispose<HomeFeed>((ref) async {
  final repo = ref.watch(homeRepositoryProvider);
  return repo.loadFeed();
});
