# BookBuddy

A Flutter app to search, browse, and favorite books using the Google Books API.

---

## Tech Stack

- **Flutter** — UI framework
- **Riverpod** — State management (`riverpod_generator` annotation style)
- **Dio** — HTTP client with interceptors
- **Hive CE** — Local storage for favorites
- **go_router** — Navigation
- **very_good_analysis** — Lint rules

---

## Setup

#### Prerequisites

- A Google Books API key → [Get one here](https://console.cloud.google.com/) (Enable **Books API**)

#### Run code generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

**Dev flavor**
```bash
flutter run -t lib/main_dev.dart \
  --dart-define=FLAVOR=dev \
  --dart-define=APP_NAME="BookBuddy Dev" \
  --dart-define=APP_SUFFIX=.dev \
  --dart-define=BOOKS_API_KEY=YOUR_DEV_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1
```

**Prod flavor**
```bash
flutter run -t lib/main_prod.dart \
  --dart-define=FLAVOR=prod \
  --dart-define=APP_NAME="BookBuddy" \
  --dart-define=APP_SUFFIX="" \
  --dart-define=BOOKS_API_KEY=YOUR_PROD_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1
```

---

## Flavor Setup

No flavor packages used. Flavors are handled via `--dart-define` at run time, read in Dart via `String.fromEnvironment()` inside `FlavorConfig`.

| Property | Dev | Prod |
|---|---|---|
| App name | BookBuddy Dev | BookBuddy |
| Bundle ID suffix | `.dev` | — |
| API key | Separate dev key | Separate prod key |
| Entry point | `main_dev.dart` | `main_prod.dart` |

VSCode users: use the pre-configured `.vscode/launch.json` — just select the flavor from the Run panel.

---

## Architecture

Feature-first Clean Architecture. Each feature owns its full vertical slice.

```
lib/
├── core/          # Shared: network, storage, theme, router, error types
├── features/
│   ├── book_list/ # data / domain / presentation
│   ├── book_detail/
│   └── favorites/
├── flavor_config.dart
├── main_dev.dart
└── main_prod.dart
```

---

## State Management

Riverpod with `@riverpod` code generation (modern annotation style, not legacy `StateNotifier`).

---
