import '../../../data/mock/mock_data.dart';

class HomeStats {
  final int vouchers;
  final int redeemed;
  final int spinTickets;
  const HomeStats({
    required this.vouchers,
    required this.redeemed,
    required this.spinTickets,
  });
}

class CheckinSummary {
  final int streakDays;
  final int todayReward;
  final bool sundayDoubled;
  const CheckinSummary({
    required this.streakDays,
    required this.todayReward,
    required this.sundayDoubled,
  });
}

class HomeFeed {
  final User user;
  final List<Reward> rewards;
  final List<NewsItem> news;
  final List<HandbookNote> handbookNotes;
  final int unreadNotifications;
  final HomeStats stats;
  final CheckinSummary checkin;
  const HomeFeed({
    required this.user,
    required this.rewards,
    required this.news,
    required this.handbookNotes,
    required this.unreadNotifications,
    required this.stats,
    required this.checkin,
  });
}
