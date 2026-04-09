import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/main_shell/main_shell_page.dart';
import '../../features/explore/search_page.dart';
import '../../features/explore/rankings_page.dart';
import '../../features/explore/calendar_page.dart';
import '../../features/explore/drama_detail_page.dart';
import '../../features/profile/vip_purchase_page.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // 启动页
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),

      // 登录页
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),

      // 主框架（底部导航）
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellPage(navigationShell: navigationShell);
        },
        branches: [
          // 刷刷
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SizedBox.shrink(),
                ),
              ),
            ],
          ),
          // 找片
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SizedBox.shrink(),
                ),
              ),
            ],
          ),
          // 福利
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/welfare',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SizedBox.shrink(),
                ),
              ),
            ],
          ),
          // 我的
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ],
      ),

      // 剧集详情
      GoRoute(
        path: '/drama/:id',
        builder: (context, state) {
          final dramaId = state.pathParameters['id']!;
          return DramaDetailPage(dramaId: dramaId);
        },
      ),

      // 播放页
      GoRoute(
        path: '/play/:dramaId/:episodeId',
        builder: (context, state) {
          final dramaId = state.pathParameters['dramaId']!;
          final episodeId = state.pathParameters['episodeId']!;
          return _PlayerPagePlaceholder(
            dramaId: dramaId,
            episodeId: episodeId,
          );
        },
      ),

      // 搜索页
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),

      // 排行榜
      GoRoute(
        path: '/rankings',
        builder: (context, state) => const RankingsPage(),
      ),

      // 更新日历
      GoRoute(
        path: '/calendar',
        builder: (context, state) => const CalendarPage(),
      ),

      // VIP购买
      GoRoute(
        path: '/vip/purchase',
        builder: (context, state) => const VipPurchasePage(),
      ),
    ],
  );
}

/// 播放页占位组件（后续替换为实际播放页）
class _PlayerPagePlaceholder extends StatelessWidget {
  final String dramaId;
  final String episodeId;

  const _PlayerPagePlaceholder({
    required this.dramaId,
    required this.episodeId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('播放页')),
      body: Center(
        child: Text('播放页占位\n剧集ID: $dramaId\n集数ID: $episodeId'),
      ),
    );
  }
}
