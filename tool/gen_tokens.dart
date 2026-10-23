// spec/tokens/tokens.json → lib/core/theme/tokens.g.dart
// 실행: dart run tool/gen_tokens.dart
// 생성 파일은 직접 고치지 않습니다. 값은 spec 레포의 tokens.json에서만 바꿉니다.

import 'dart:convert';
import 'dart:io';

String hexToDart(String hex) {
  final clean = hex.replaceFirst('#', '').toUpperCase();
  return '0xFF$clean';
}

void main() {
  final sourceFile = File('spec/tokens/tokens.json');
  if (!sourceFile.existsSync()) {
    stderr.writeln('spec/tokens/tokens.json 을 찾을 수 없습니다. 서브모듈을 초기화했는지 확인하세요.');
    exit(1);
  }

  final t = jsonDecode(sourceFile.readAsStringSync()) as Map<String, dynamic>;
  final version = (t['\$meta'] as Map)['version'];
  final color = t['color'] as Map<String, dynamic>;
  final space = t['space'] as Map<String, dynamic>;
  final radius = t['radius'] as Map<String, dynamic>;
  final fontSize = t['fontSize'] as Map<String, dynamic>;
  final bp = t['breakpoints'] as Map<String, dynamic>;

  final out = StringBuffer();
  out.writeln('// 자동 생성 파일. 수정하지 마세요.');
  out.writeln('// 원본: spec/tokens/tokens.json (v$version)');
  out.writeln('// 생성: dart run tool/gen_tokens.dart');
  out.writeln();
  out.writeln("import 'package:flutter/material.dart';");
  out.writeln();

  // 색
  out.writeln('abstract final class AppColors {');
  for (final entry in color.entries) {
    if (entry.value is String) {
      out.writeln('  static const ${entry.key} = Color(${hexToDart(entry.value as String)});');
    }
  }
  final status = color['status'] as Map<String, dynamic>;
  for (final entry in status.entries) {
    final pair = entry.value as Map<String, dynamic>;
    out.writeln('  static const status${_cap(entry.key)}Fg = Color(${hexToDart(pair['fg'] as String)});');
    out.writeln('  static const status${_cap(entry.key)}Bg = Color(${hexToDart(pair['bg'] as String)});');
  }
  final manner = color['mannerTemp'] as Map<String, dynamic>;
  for (final entry in manner.entries) {
    final v = (entry.value as Map<String, dynamic>)['value'] as String;
    out.writeln('  static const manner${_cap(entry.key)} = Color(${hexToDart(v)});');
  }
  out.writeln('}');
  out.writeln();

  // 간격
  out.writeln('abstract final class AppSpace {');
  for (final entry in space.entries) {
    out.writeln('  static const s${entry.key} = ${(entry.value as num).toDouble()};');
  }
  out.writeln('}');
  out.writeln();

  // radius
  out.writeln('abstract final class AppRadius {');
  for (final entry in radius.entries) {
    final v = (entry.value as num).toDouble();
    out.writeln('  static const ${entry.key} = ${v == 999 ? 9999.0 : v};');
  }
  out.writeln('}');
  out.writeln();

  // 반응형 글자 크기
  final buckets = ['mobile', 'tablet', 'desktop'];
  out.writeln('enum AppBreakpoint { mobile, tablet, desktop }');
  out.writeln();
  out.writeln('AppBreakpoint breakpointOf(double width) {');
  out.writeln('  if (width >= ${(bp['desktop'] as Map)['min']}) return AppBreakpoint.desktop;');
  out.writeln('  if (width >= ${(bp['tablet'] as Map)['min']}) return AppBreakpoint.tablet;');
  out.writeln('  return AppBreakpoint.mobile;');
  out.writeln('}');
  out.writeln();
  out.writeln('final class AppTextSize {');
  out.writeln('  const AppTextSize({');
  for (final name in fontSize.keys) {
    out.writeln('    required this.$name,');
  }
  out.writeln('  });');
  for (final name in fontSize.keys) {
    out.writeln('  final double $name;');
  }
  out.writeln();
  out.writeln('  static AppTextSize of(AppBreakpoint breakpoint) => switch (breakpoint) {');
  for (final b in buckets) {
    out.writeln('        AppBreakpoint.$b => _$b,');
  }
  out.writeln('      };');
  out.writeln();
  for (final b in buckets) {
    out.writeln('  static const _$b = AppTextSize(');
    for (final entry in fontSize.entries) {
      final sizes = entry.value as Map<String, dynamic>;
      out.writeln('    ${entry.key}: ${(sizes[b] as num).toDouble()},');
    }
    out.writeln('  );');
  }
  out.writeln('}');
  out.writeln();

  // 글자 굵기 (Flutter FontWeight 는 런타임 상수)
  out.writeln('abstract final class AppFontWeight {');
  for (final entry in fontSize.entries) {
    final w = (entry.value as Map<String, dynamic>)['weight'] as int;
    out.writeln('  static const ${entry.key} = FontWeight.w$w;');
  }
  out.writeln('}');

  final target = File('lib/core/theme/tokens.g.dart');
  target.parent.createSync(recursive: true);
  target.writeAsStringSync(out.toString());
  stdout.writeln('tokens.g.dart 생성: ${target.path}');
}

String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
