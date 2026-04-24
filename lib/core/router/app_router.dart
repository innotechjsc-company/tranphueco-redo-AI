import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/onboarding_page.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/register/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/scan/scan_page.dart';
import '../../features/scan/scan_result_page.dart';
import '../../features/shop/shop_page.dart';
import '../../features/shop/reward_detail_page.dart';
import '../../features/spin/spin_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/vouchers/vouchers_page.dart';
import '../../features/history/history_page.dart';
import '../../features/news/news_page.dart';
import '../../features/news/news_detail_page.dart';
import '../../features/notifications/notifications_page.dart';
import '../../features/support/support_page.dart';
import '../../features/support/support_new_page.dart';
import '../../features/support/support_detail_page.dart';
import '../../features/branches/branches_page.dart';
import '../../features/handbook/handbook_page.dart';
import '../../features/handbook/handbook_new_page.dart';
import '../../features/checkin/checkin_page.dart';
import '../../features/transfer/transfer_page.dart';
import '../../features/search/search_page.dart';
import '../../shared/widgets/main_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingPage()),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          final phone = state.uri.queryParameters['phone'];
          final pwd = state.uri.queryParameters['pwd'];
          return LoginScreen(prefillPhone: phone, prefillPwd: pwd);
        },
      ),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

      // Stateful tab shell - giữ state khi chuyển tab
      StatefulShellRoute.indexedStack(
        builder: (ctx, state, navShell) =>
            MainScaffold(navigationShell: navShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/shop', builder: (_, __) => const ShopPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/spin', builder: (_, __) => const SpinPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
          ]),
        ],
      ),

      // Standalone routes (push lên trên tab shell)
      GoRoute(path: '/scan', builder: (_, __) => const ScanPage()),
      GoRoute(path: '/scan/result', builder: (_, __) => const ScanResultPage()),
      GoRoute(path: '/vouchers', builder: (_, __) => const VouchersPage()),
      GoRoute(path: '/history', builder: (_, __) => const HistoryPage()),
      GoRoute(path: '/news', builder: (_, __) => const NewsPage()),
      GoRoute(
        path: '/news/:id',
        builder: (_, state) => NewsDetailPage(id: state.pathParameters['id']!),
      ),
      GoRoute(
          path: '/notifications',
          builder: (_, __) => const NotificationsPage()),
      GoRoute(path: '/support', builder: (_, __) => const SupportPage()),
      GoRoute(path: '/support/new', builder: (_, __) => const SupportNewPage()),
      GoRoute(
        path: '/support/:id',
        builder: (_, state) =>
            SupportDetailPage(id: state.pathParameters['id']!),
      ),
      GoRoute(path: '/branches', builder: (_, __) => const BranchesPage()),
      GoRoute(path: '/handbook', builder: (_, __) => const HandbookPage()),
      GoRoute(
          path: '/handbook/new', builder: (_, __) => const HandbookNewPage()),
      GoRoute(path: '/checkin', builder: (_, __) => const CheckinPage()),
      GoRoute(path: '/transfer', builder: (_, __) => const TransferPage()),
      GoRoute(path: '/search', builder: (_, __) => const SearchPage()),
      GoRoute(
        path: '/shop/:id',
        builder: (_, state) =>
            RewardDetailPage(id: state.pathParameters['id']!),
      ),
    ],
  );
});
