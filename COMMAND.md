#### Run with dev flavor: from file

```bash
flutter run -t lib/main_dev.dart --dart-define-from-file=config/dev.json
```

#### Run with prod flavor: from file

```bash
flutter run -t lib/main_prod.dart --dart-define-from-file=config/prod.json
```

#### Dev
```bash
flutter run -t lib/main_dev.dart \
  --dart-define=FLAVOR=dev \
  --dart-define=APP_NAME="BookBuddy Dev" \
  --dart-define=APP_SUFFIX=.dev \
  --dart-define=BOOKS_API_KEY=YOUR_DEV_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1
```

#### Prod

```bash
flutter run -t lib/main_prod.dart \
  --dart-define=FLAVOR=prod \
  --dart-define=APP_NAME="BookBuddy" \
  --dart-define=APP_SUFFIX="" \
  --dart-define=BOOKS_API_KEY=YOUR_PROD_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1
```

#### Analysis code
```bash
flutter analyze
```

#### Code Generation
```bash
dart run build_runner build --delete-conflicting-outputs
```
