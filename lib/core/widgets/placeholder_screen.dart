import 'package:flutter/material.dart';

import '../theme/tokens.g.dart';

/// 구현 전 자리 표시 화면 (T-101). 실제 화면을 만들면 features/ 의 화면으로 바꿉니다.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.route,
    required this.pattern,
    this.detail,
  });

  final String title;
  final String route;
  final String pattern;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpace.s4),
          children: [
            Text(
              '$route · 패턴 $pattern',
              style: textTheme.bodySmall,
            ),
            if (detail != null) ...[
              SizedBox(height: AppSpace.s1),
              Text(detail!, style: textTheme.bodySmall),
            ],
            SizedBox(height: AppSpace.s4),
            Container(
              padding: EdgeInsets.all(AppSpace.s4),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.card),
              ),
              child: Text(
                '구현 예정 화면입니다. 라우트와 자리만 먼저 만들어 두었습니다.',
                style: textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: AppSpace.s3),
            Text(
              '상태 5종 미리보기는 디버그 빌드의 /dev/states 에서 볼 수 있어요.',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
