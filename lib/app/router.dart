import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/main_shell.dart';
import '../core/widgets/placeholder_screen.dart';
import '../core/widgets/state_preview_screen.dart';

/// 라우트는 웹(`src/app`)과 같은 경로를 씁니다. 기준은 개발지시서 4장입니다.
/// 탭 바는 StatefulShellRoute 안(홈·동네생활·채팅·나의)에만 보입니다.
/// 같은 패턴 경로는 더 구체적인 경로(예: /product/write)를 먼저 둡니다.
GoRoute _page({
  required String path,
  required String title,
  required String pattern,
  String? paramName,
  String? paramLabel,
}) {
  return GoRoute(
    path: path,
    builder: (context, state) {
      final detail = paramName == null
          ? null
          : '$paramLabel: ${state.pathParameters[paramName] ?? '-'}';
      return PlaceholderScreen(
        title: title,
        route: path,
        pattern: pattern,
        detail: detail,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    // ── 인증·동네 (탭 바 없음)
    _page(path: '/login', title: '로그인·인증', pattern: 'I + V-K'),
    _page(path: '/login/verify', title: '인증번호 입력', pattern: 'I + V-K'),
    _page(path: '/setup/location', title: '동네 설정·인증', pattern: 'I + 고유'),
    _page(path: '/location/map', title: '동네 지도', pattern: '고유'),

    // ── 탭 바 영역 (홈·동네생활·채팅·나의)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          _page(path: '/home', title: '홈 피드', pattern: 'B + G'),
        ]),
        StatefulShellBranch(routes: [
          _page(path: '/community', title: '동네생활 피드', pattern: 'B + G'),
        ]),
        StatefulShellBranch(routes: [
          _page(path: '/chat', title: '채팅 목록', pattern: 'F (1단)'),
        ]),
        StatefulShellBranch(routes: [
          _page(path: '/my', title: '나의 중고거래마켓', pattern: 'H + G'),
        ]),
      ],
    ),

    // ── 전체 화면 (탭 바 없음). 구체적 경로를 동적 경로보다 먼저 둡니다.
    _page(path: '/home/search', title: '검색', pattern: 'B'),
    _page(path: '/product/write', title: '상품 등록', pattern: 'I (사진 → 정보 → 가격·장소)'),
    _page(path: '/product/:id', title: '상품 상세', pattern: 'G', paramName: 'id', paramLabel: '상품 ID'),
    _page(path: '/product/:id/offer', title: '가격 제안 시트', pattern: 'BottomSheet (V-K)', paramName: 'id', paramLabel: '상품 ID'),
    _page(path: '/product/:id/edit', title: '상품 수정', pattern: 'I', paramName: 'id', paramLabel: '상품 ID'),
    _page(path: '/chat/:roomId', title: '채팅방', pattern: 'F 본문', paramName: 'roomId', paramLabel: '채팅방 ID'),
    _page(path: '/community/write', title: '동네생활 글쓰기', pattern: 'I (1단계)'),
    _page(path: '/community/:id', title: '게시글 상세', pattern: 'G', paramName: 'id', paramLabel: '게시글 ID'),
    _page(path: '/my/sales', title: '판매 내역', pattern: 'B + G'),
    _page(path: '/my/purchases', title: '구매 내역', pattern: 'B + G'),
    _page(path: '/my/likes', title: '관심 목록', pattern: 'B'),
    _page(path: '/my/settings', title: '설정', pattern: 'H'),
    _page(path: '/profile/:userId', title: '판매자 프로필', pattern: 'G (V-F 매너온도)', paramName: 'userId', paramLabel: '사용자 ID'),
    _page(path: '/review/write', title: '매너 평가', pattern: 'I (2단계)'),

    // ── 개발용 (디버그 빌드에서만)
    if (kDebugMode)
      GoRoute(
        path: '/dev/states',
        builder: (context, state) => const StatePreviewScreen(),
      ),
  ],
);
