import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mock_data.dart';

final currentUserProvider = Provider<User>((ref) => mockCurrentUser);

final rewardsProvider     = Provider<List<Reward>>((ref) => mockRewards);
final newsProvider        = Provider<List<NewsItem>>((ref) => mockNews);
final vouchersProvider    = Provider<List<Voucher>>((ref) => mockVouchers);
final branchesProvider    = Provider<List<Branch>>((ref) => mockBranches);
final notificationsProvider =
    Provider<List<AppNotification>>((ref) => mockNotifications);
final handbookProvider    =
    Provider<List<HandbookNote>>((ref) => mockHandbookNotes);
final supportTicketsProvider =
    Provider<List<SupportTicket>>((ref) => mockSupportTickets);
final pointTransactionsProvider =
    Provider<List<PointTransaction>>((ref) => mockPointTransactions);
final checkinWeekProvider =
    Provider<List<CheckinDay>>((ref) => mockCheckinWeek);
final wheelPrizesProvider =
    Provider<List<WheelPrize>>((ref) => mockWheelPrizes);
final scannedProductProvider =
    Provider<Product>((ref) => mockScannedProduct);

/// Tìm 1 reward theo id (dùng ở RewardDetailPage)
final rewardByIdProvider = Provider.family<Reward?, String>((ref, id) {
  final list = ref.watch(rewardsProvider);
  try {
    return list.firstWhere((r) => r.id == id);
  } catch (_) {
    return null;
  }
});

/// Tìm 1 news theo id
final newsByIdProvider = Provider.family<NewsItem?, String>((ref, id) {
  final list = ref.watch(newsProvider);
  try {
    return list.firstWhere((n) => n.id == id);
  } catch (_) {
    return null;
  }
});

/// Tìm 1 support ticket theo id
final supportByIdProvider = Provider.family<SupportTicket?, String>((ref, id) {
  final list = ref.watch(supportTicketsProvider);
  try {
    return list.firstWhere((t) => t.id == id);
  } catch (_) {
    return null;
  }
});
