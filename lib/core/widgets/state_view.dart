import 'package:flutter/material.dart';

import '../theme/tokens.g.dart';

/// 공용 상태 4종 (기본 상태는 화면이 직접 그립니다). 개발지시서 7장 2번.
/// 로딩은 스피너 대신 스켈레톤을 씁니다.
enum ScreenStateKind { loading, empty, error, forbidden }

class StateView extends StatelessWidget {
  const StateView({
    super.key,
    required this.kind,
    this.title,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  final ScreenStateKind kind;
  final String? title;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  static const _defaults = <ScreenStateKind, (String, String)>{
    ScreenStateKind.loading: ('불러오는 중이에요', ''),
    ScreenStateKind.empty: ('아직 아무것도 없어요', '다음 행동을 눌러 시작해 보세요.'),
    ScreenStateKind.error: ('문제가 생겼어요', '잠시 후 다시 시도해 주세요.'),
    ScreenStateKind.forbidden: ('권한이 필요해요', '필요한 권한을 허용한 뒤 다시 시도해 주세요.'),
  };

  @override
  Widget build(BuildContext context) {
    if (kind == ScreenStateKind.loading) {
      return const _SkeletonList();
    }

    final textTheme = Theme.of(context).textTheme;
    final fallback = _defaults[kind]!;
    final isError = kind == ScreenStateKind.error;

    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpace.s5, vertical: AppSpace.s6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? fallback.$1,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                color: isError ? AppColors.danger : AppColors.ink,
              ),
            ),
            SizedBox(height: AppSpace.s2),
            Text(
              description ?? fallback.$2,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
            if (actionLabel != null) ...[
              SizedBox(height: AppSpace.s4),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size(44, 44),
                  backgroundColor: AppColors.brand,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                ),
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SkeletonList extends StatelessWidget {
  const _SkeletonList();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '불러오는 중',
      child: ListView.separated(
        padding: EdgeInsets.all(AppSpace.s4),
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(height: AppSpace.s3),
        itemBuilder: (_, __) => Container(
          padding: EdgeInsets.all(AppSpace.s3),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.placeholder,
                  borderRadius: BorderRadius.circular(AppRadius.thumb),
                ),
              ),
              SizedBox(width: AppSpace.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bar(width: 0.75),
                    SizedBox(height: AppSpace.s2),
                    _bar(width: 0.5),
                    SizedBox(height: AppSpace.s2),
                    _bar(width: 0.3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bar({required double width}) {
    return FractionallySizedBox(
      widthFactor: width,
      child: Container(
        height: 14,
        decoration: BoxDecoration(
          color: AppColors.placeholder,
          borderRadius: BorderRadius.circular(AppRadius.thumb),
        ),
      ),
    );
  }
}
