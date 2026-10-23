import 'package:flutter/material.dart';

import '../theme/tokens.g.dart';
import 'state_view.dart';

/// 상태 5종 미리보기 (T-104). 디버그 빌드에서만 라우트가 열립니다.
class StatePreviewScreen extends StatelessWidget {
  const StatePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상태 5종 미리보기')),
      body: ListView(
        padding: EdgeInsets.all(AppSpace.s4),
        children: [
          Text('1. 기본 상태는 각 화면이 그립니다 (예: 상품 카드 목록)',
              style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: AppSpace.s3),
          const Text('2. 로딩 (스켈레톤)'),
          const StateView(kind: ScreenStateKind.loading),
          SizedBox(height: AppSpace.s3),
          const Text('3. 빈 상태 (다음 행동 안내)'),
          StateView(
            kind: ScreenStateKind.empty,
            title: '이 동네에 아직 올라온 물건이 없어요',
            description: '첫 번째 물건을 올려 보세요.',
            actionLabel: '물건 올리기',
            onAction: () {},
          ),
          SizedBox(height: AppSpace.s3),
          const Text('4. 오류 (원인과 재시도)'),
          StateView(
            kind: ScreenStateKind.error,
            title: '사진 업로드에 실패했어요',
            description: '네트워크 상태를 확인하고 다시 시도해 주세요.',
            actionLabel: '다시 시도',
            onAction: () {},
          ),
          SizedBox(height: AppSpace.s3),
          const Text('5. 권한없음 (필수 권한은 숨기지 않고 안내)'),
          StateView(
            kind: ScreenStateKind.forbidden,
            title: '동네 인증에 위치 권한이 필요해요',
            description: '위치 권한을 허용하면 내 동네를 찾을 수 있어요.',
            actionLabel: '설정 열기',
            onAction: () {},
          ),
        ],
      ),
    );
  }
}
