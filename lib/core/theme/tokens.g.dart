// 자동 생성 파일. 수정하지 마세요.
// 원본: spec/tokens/tokens.json (v0.1.0)
// 생성: dart run tool/gen_tokens.dart

import 'package:flutter/material.dart';

abstract final class AppColors {
  static const brand = Color(0xFFC2410C);
  static const brandHover = Color(0xFF9A3412);
  static const ink = Color(0xFF18202C);
  static const muted = Color(0xFF5A6472);
  static const line = Color(0xFFE3E6EA);
  static const lineSoft = Color(0xFFEEF0F3);
  static const ground = Color(0xFFF4F5F7);
  static const surface = Color(0xFFFFFFFF);
  static const placeholder = Color(0xFFEEF0F3);
  static const danger = Color(0xFFB91C1C);
  static const statusSellingFg = Color(0xFF166534);
  static const statusSellingBg = Color(0xFFDCFCE7);
  static const statusReservedFg = Color(0xFF1D4ED8);
  static const statusReservedBg = Color(0xFFDBEAFE);
  static const statusSoldFg = Color(0xFF4B5563);
  static const statusSoldBg = Color(0xFFEEF0F3);
  static const mannerLow = Color(0xFF1D4ED8);
  static const mannerMid = Color(0xFF0F766E);
  static const mannerHigh = Color(0xFF6D28D9);
  static const mannerTop = Color(0xFFBE123C);
}

abstract final class AppSpace {
  static const s1 = 4.0;
  static const s2 = 8.0;
  static const s3 = 12.0;
  static const s4 = 16.0;
  static const s5 = 24.0;
  static const s6 = 32.0;
}

abstract final class AppRadius {
  static const thumb = 6.0;
  static const button = 8.0;
  static const input = 10.0;
  static const card = 12.0;
  static const pill = 9999.0;
}

enum AppBreakpoint { mobile, tablet, desktop }

AppBreakpoint breakpointOf(double width) {
  if (width >= 1200) return AppBreakpoint.desktop;
  if (width >= 768) return AppBreakpoint.tablet;
  return AppBreakpoint.mobile;
}

final class AppTextSize {
  const AppTextSize({
    required this.display,
    required this.title,
    required this.headline,
    required this.body,
    required this.bodyStrong,
    required this.caption,
    required this.micro,
  });
  final double display;
  final double title;
  final double headline;
  final double body;
  final double bodyStrong;
  final double caption;
  final double micro;

  static AppTextSize of(AppBreakpoint breakpoint) => switch (breakpoint) {
        AppBreakpoint.mobile => _mobile,
        AppBreakpoint.tablet => _tablet,
        AppBreakpoint.desktop => _desktop,
      };

  static const _mobile = AppTextSize(
    display: 24.0,
    title: 20.0,
    headline: 18.0,
    body: 15.0,
    bodyStrong: 15.0,
    caption: 12.0,
    micro: 11.0,
  );
  static const _tablet = AppTextSize(
    display: 28.0,
    title: 22.0,
    headline: 18.0,
    body: 15.0,
    bodyStrong: 15.0,
    caption: 13.0,
    micro: 11.0,
  );
  static const _desktop = AppTextSize(
    display: 32.0,
    title: 24.0,
    headline: 20.0,
    body: 16.0,
    bodyStrong: 16.0,
    caption: 13.0,
    micro: 12.0,
  );
}

abstract final class AppFontWeight {
  static const display = FontWeight.w800;
  static const title = FontWeight.w800;
  static const headline = FontWeight.w800;
  static const body = FontWeight.w400;
  static const bodyStrong = FontWeight.w700;
  static const caption = FontWeight.w400;
  static const micro = FontWeight.w600;
}
