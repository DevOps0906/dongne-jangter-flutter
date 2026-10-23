# dongne-jangter-flutter

동네장터 **Flutter 앱 버전** 구현 레포입니다. 같은 기획을 웹 버전(`dongne-jangter-web`)과 나란히 구현해서 비교할 수 있게 만들었습니다. 기획과 디자인은 `spec/` 서브모듈을 기준으로 합니다.

## 3개 레포의 관계

| 레포 | 역할 | 이 레포와의 관계 |
|---|---|---|
| [dongne-jangter-spec](https://github.com/DevOps0906/dongne-jangter-spec) | 기획·디자인 캔버스·토큰·DB 스키마 | `spec/` 서브모듈로 포함 (읽기 전용) |
| [dongne-jangter-web](https://github.com/DevOps0906/dongne-jangter-web) | Next.js 웹/PWA 구현 | 같은 spec과 같은 Supabase 스키마 사용 |
| **dongne-jangter-flutter** (이 레포) | Flutter 앱 구현 | — |

- 디자인 값은 `spec/tokens/tokens.json`에서만 바꿉니다. `lib/core/theme/tokens.g.dart`는 생성 파일입니다.
- DB 스키마는 `spec/supabase/`에서 관리합니다. 이 레포에는 마이그레이션이 없습니다.

## 시작하기

```bash
# 1) 서브모듈 포함 클론 (처음 한 번)
git clone --recurse-submodules https://github.com/DevOps0906/dongne-jangter-flutter.git
cd dongne-jangter-flutter

# 이미 클론했다면
git submodule update --init --recursive

# 2) 패키지 설치
flutter pub get

# 3) 토큰 생성 (spec/tokens/tokens.json → lib/core/theme/tokens.g.dart)
dart run tool/gen_tokens.dart

# 4) 실행 (Supabase 값은 --dart-define 으로 넘깁니다. 코드에 키를 넣지 않습니다)
flutter run \
  --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJ...
```

## 주요 명령어

| 명령어 | 설명 |
|---|---|
| `dart run tool/gen_tokens.dart` | 토큰 파일 생성 |
| `flutter analyze` | 정적 분석 |
| `flutter test` | 테스트 실행 |

## 폴더 구조

```
dongne-jangter-flutter/
├── spec/                          공용 기획·토큰·스키마 (서브모듈, 읽기 전용)
├── tool/gen_tokens.dart           토큰 생성 스크립트
├── lib/
│   ├── main.dart                  진입점 (Supabase 초기화 + ProviderScope)
│   ├── app/
│   │   ├── app.dart               MaterialApp.router
│   │   ├── router.dart            GoRouter, 5탭 StatefulShellRoute
│   │   └── theme.dart             토큰으로 만든 라이트 테마
│   ├── core/
│   │   ├── theme/tokens.g.dart    생성 파일 (직접 수정 금지)
│   │   ├── supabase/              Supabase 초기화
│   │   └── widgets/               하단 탭(MainShell), 자리 표시 화면
│   └── features/                  auth, location, listings, community, chat, reviews, my
├── test/
├── analysis_options.yaml
└── pubspec.yaml
```

각 feature는 `data / domain / presentation` 세 층으로 나눕니다. 지금은 비어 있습니다.

## 라우트 구조

| 경로 | 탭 | 화면 |
|---|---|---|
| `/login` | — | 로그인 (탭 밖) |
| `/home` | 홈 | 홈 피드 (검색·상품 상세·가격 제안으로 이어짐) |
| `/community` | 동네생활 | 피드 (게시글 상세·글쓰기로 이어짐) |
| `/write` | 글쓰기 | 사진 올리기 → 상품 정보 입력 |
| `/chat` | 채팅 | 채팅 목록 → 채팅방 |
| `/my` | 나의 | 메인 (판매·구매 내역, 관심목록, 프로필, 설정으로 이어짐) |

## 현재 상태

- 완료: 프로젝트 뼈대, 토큰 기반 테마, 5탭 셸, 라우트 구조, Supabase 초기화 코드
- 진행 예정: 화면 구현, 인증 흐름, 상태 5종(로딩·빈·오류·권한없음) 공용 위젯

## 주의

- 이 레포의 `tokens.g.dart`는 Dart SDK가 없는 환경에서 `tool/gen_tokens.dart`와 같은 규칙으로 만든 결과입니다. 로컬에서 `dart run tool/gen_tokens.dart`를 한 번 실행해 결과가 같은지 확인해 주세요.
- 아직 `flutter analyze`와 빌드를 실행하지 않았습니다.
- 폰트(Gothic A1, IBM Plex Sans KR)는 `google_fonts` 패키지로 불러옵니다. 오프라인에서는 기본 글꼴로 대체됩니다.
- 라이트 테마만 있습니다.
