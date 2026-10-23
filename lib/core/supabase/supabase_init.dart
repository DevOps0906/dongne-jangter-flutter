import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase 초기화. 값은 --dart-define 으로 넘깁니다.
///
///   flutter run \
///     --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
///     --dart-define=SUPABASE_ANON_KEY=eyJ...
///
/// 값이 없으면 초기화를 건너뛰고 경고만 출력합니다. 키는 코드에 넣지 않습니다.
Future<void> initSupabase() async {
  const url = String.fromEnvironment('SUPABASE_URL');
  const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  if (url.isEmpty || anonKey.isEmpty) {
    debugPrint('SUPABASE_URL / SUPABASE_ANON_KEY 가 없어 Supabase 를 초기화하지 않았습니다.');
    return;
  }

  await Supabase.initialize(url: url, anonKey: anonKey);
}

SupabaseClient get supabase => Supabase.instance.client;
