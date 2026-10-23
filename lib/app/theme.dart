import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/tokens.g.dart';

/// 디자인 토큰(spec/tokens/tokens.json 에서 생성된 값)으로 만든 라이트 테마.
/// 다크 테마는 아직 없습니다.
ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.brand,
    primary: AppColors.brand,
    onPrimary: AppColors.surface,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
    error: AppColors.danger,
    brightness: Brightness.light,
  );

  final baseText = GoogleFonts.ibmPlexSansKrTextTheme();
  final base = AppTextSize.of(AppBreakpoint.mobile);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.ground,
    textTheme: baseText.copyWith(
      headlineSmall: GoogleFonts.gothicA1(
        fontSize: base.headline,
        fontWeight: AppFontWeight.headline,
        color: AppColors.ink,
      ),
      titleLarge: GoogleFonts.gothicA1(
        fontSize: base.title,
        fontWeight: AppFontWeight.title,
        color: AppColors.ink,
      ),
      bodyMedium: baseText.bodyMedium?.copyWith(
        fontSize: base.body,
        fontWeight: AppFontWeight.body,
        color: AppColors.ink,
      ),
      bodySmall: baseText.bodySmall?.copyWith(
        fontSize: base.caption,
        fontWeight: AppFontWeight.caption,
        color: AppColors.muted,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: base.micro,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
          color: states.contains(WidgetState.selected)
              ? AppColors.brand
              : AppColors.muted,
        ),
      ),
    ),
  );
}
