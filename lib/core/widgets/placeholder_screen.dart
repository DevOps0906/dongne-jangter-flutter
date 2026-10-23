import 'package:flutter/material.dart';

import '../theme/tokens.g.dart';

/// 구현 전 자리 표시 화면. 실제 화면이 완성되면 이 위젯 대신 features/ 의 화면을 연결합니다.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.note});

  final String title;
  final String note;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: AppSpace.s2),
            Text(
              '구현 예정 · $note',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
