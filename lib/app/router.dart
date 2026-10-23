import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/main_shell.dart';
import '../core/widgets/placeholder_screen.dart';

/// 라우트 구조는 spec/docs/design/pattern-mapping.md 의 5탭·21화면 구조를 따릅니다.
/// 지금은 탭 뼈대와 자리 표시 화면만 있습니다. 화면은 features/ 아래에 채워 넣습니다.
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          const PlaceholderScreen(title: '로그인', note: 'features/auth'),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) =>
                  const PlaceholderScreen(title: '홈', note: 'features/listings'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/community',
              builder: (context, state) => const PlaceholderScreen(
                title: '동네생활',
                note: 'features/community',
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/write',
              builder: (context, state) => const PlaceholderScreen(
                title: '글쓰기',
                note: 'features/listings (사진 올리기)',
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) =>
                  const PlaceholderScreen(title: '채팅', note: 'features/chat'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my',
              builder: (context, state) =>
                  const PlaceholderScreen(title: '나의 동네장터', note: 'features/my'),
            ),
          ],
        ),
      ],
    ),
  ],
);
