import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 하단 5탭 (T-102). 가운데 글쓰기는 탭 전환이 아니라 상품 등록 화면을 엽니다.
/// 웹(`src/lib/navigation.ts`)과 같은 순서와 경로를 씁니다.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// 화면 탭 위치 → 셸 브랜치 번호. 가운데(2)는 브랜치가 없습니다.
  static const _branchForTab = <int, int>{0: 0, 1: 1, 3: 2, 4: 3};
  static const _tabForBranch = <int, int>{0: 0, 1: 1, 2: 3, 3: 4};
  static const _writeTab = 2;

  @override
  Widget build(BuildContext context) {
    final selectedTab = _tabForBranch[navigationShell.currentIndex] ?? 0;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (tab) {
          if (tab == _writeTab) {
            context.push('/product/write');
            return;
          }
          navigationShell.goBranch(
            _branchForTab[tab]!,
            initialLocation: _branchForTab[tab] == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: '홈'),
          NavigationDestination(icon: Icon(Icons.forum_outlined), selectedIcon: Icon(Icons.forum), label: '동네생활'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box), label: '글쓰기'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: '채팅'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: '나의'),
        ],
      ),
    );
  }
}
