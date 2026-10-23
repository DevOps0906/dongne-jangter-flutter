import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dongne_jangter/app/app.dart';
import 'package:dongne_jangter/core/widgets/state_view.dart';

void main() {
  testWidgets('앱이 홈 탭으로 열리고 하단 탭 5개를 보여준다 (T-102)', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DongneJangterApp()));
    await tester.pumpAndSettle();

    expect(find.text('홈 피드'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('동네생활'), findsOneWidget);
    expect(find.text('글쓰기'), findsOneWidget);
    expect(find.text('채팅'), findsOneWidget);
    expect(find.text('나의'), findsOneWidget);
  });

  testWidgets('상태 5종 중 권한없음은 안내 문구와 행동 버튼을 보여준다 (T-103)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StateView(
            kind: ScreenStateKind.forbidden,
            actionLabel: '설정 열기',
            onAction: () {},
          ),
        ),
      ),
    );

    expect(find.text('권한이 필요해요'), findsOneWidget);
    expect(find.text('설정 열기'), findsOneWidget);
  });
}
