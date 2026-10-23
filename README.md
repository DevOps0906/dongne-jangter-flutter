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

## 라우트 (웹과 같은 경로, 개발지시서 4장 기준)

| 구분 | 경로 | 화면 | 탭 바 |
|---|---|---|---|
| 인증·동네 | `/login`, `/login/verify` | 로그인·인증 | 없음 |
| 인증·동네 | `/setup/location`, `/location/map` | 동네 설정·인증, 동네 지도 | 없음 |
| 탭 | `/home` | 홈 피드 | 있음 |
| 탭 | `/community` | 동네생활 피드 | 있음 |
| 탭 | `/chat` | 채팅 목록 | 있음 |
| 탭 | `/my` | 나의 중고거래마켓 | 있음 |
| 전체 화면 | `/home/search` | 검색 | 없음 |
| 전체 화면 | `/product/write`, `/product/:id`, `/product/:id/offer`, `/product/:id/edit` | 상품 등록·상세·가격 제안·수정 | 없음 |
| 전체 화면 | `/chat/:roomId` | 채팅방 | 없음 |
| 전체 화면 | `/community/write`, `/community/:id` | 동네생활 글쓰기·게시글 상세 | 없음 |
| 전체 화면 | `/my/sales`, `/my/purchases`, `/my/likes`, `/my/settings` | 판매·구매 내역, 관심 목록, 설정 | 없음 |
| 전체 화면 | `/profile/:userId`, `/review/write` | 판매자 프로필, 매너 평가 | 없음 |
| 디버그 전용 | `/dev/states` | 상태 5종 미리보기 | 없음 |

가운데 글쓰기 탭은 탭 전환이 아니라 `/product/write`를 여는 동작입니다.

## 공용 위젯

- `core/widgets/main_shell.dart`: 하단 5탭 (T-102)
- `core/widgets/state_view.dart`: 상태 5종, 로딩은 스켈레톤 (T-103)
- `core/widgets/placeholder_screen.dart`: 자리 표시 화면 (T-101)
- `core/widgets/state_preview_screen.dart`: 상태 미리보기 (T-104)

## 개발 방법

1. 개발지시서(`spec/docs/dev/development-spec.md`)에서 작업 ID와 완료 기준을 확인합니다.
2. `git submodule update --remote spec`으로 spec을 최신으로 맞춥니다.
3. 토큰을 바꿨다면 `dart run tool/gen_tokens.dart`를 실행합니다.
4. 구현하고 완료 기준을 하나씩 확인합니다.
5. `flutter analyze`와 `flutter test`를 통과시킵니다.
6. 커밋 제목은 `[작업ID] 변경 내용`으로 씁니다. 끝에 Co-Authored-By와 Claude-Session 줄을 붙입니다.

새 화면을 만들 때는 `router.dart`의 같은 경로 `_page(...)`를 실제 화면 위젯으로 바꿉니다. 경로 순서에 주의하세요. `/product/write`처럼 구체적인 경로는 `/product/:id`보다 먼저 둡니다.

## 현재 상태

- 완료: 프로젝트 뼈대, 토큰 기반 테마, 21개 라우트 골격 (T-101), 하단 5탭 셸 (T-102), 상태 5종 공용 위젯 (T-103), 상태 미리보기 (T-104), 스모크 테스트 2개
- 미검증: `flutter analyze`와 `flutter test`는 아직 실행하지 않았습니다 (Dart SDK 없는 환경에서 작성)
- 진행 예정: P2 로그인과 동네 설정 (T-201~T-205), 인증 가드

## 주의

- 이 레포의 `tokens.g.dart`는 Dart SDK가 없는 환경에서 `tool/gen_tokens.dart`와 같은 규칙으로 만든 결과입니다. 로컬에서 `dart run tool/gen_tokens.dart`를 한 번 실행해 결과가 같은지 확인해 주세요.
- 아직 `flutter analyze`와 빌드를 실행하지 않았습니다.
- 폰트(Gothic A1, IBM Plex Sans KR)는 `google_fonts` 패키지로 불러옵니다. 오프라인에서는 기본 글꼴로 대체됩니다.
- 라이트 테마만 있습니다.
