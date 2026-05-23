# run with dev flavor: from file
flutter run -t lib/main_dev.dart --dart-define-from-file=config/dev.json

# run with prod flavor: from file
flutter run -t lib/main_prod.dart --dart-define-from-file=config/prod.json

# Dev
flutter run -t lib/main_dev.dart \
  --dart-define=FLAVOR=dev \
  --dart-define=APP_NAME="BookBuddy Dev" \
  --dart-define=APP_SUFFIX=.dev \
  --dart-define=BOOKS_API_KEY=YOUR_DEV_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1

# Prod
flutter run -t lib/main_prod.dart \
  --dart-define=FLAVOR=prod \
  --dart-define=APP_NAME="BookBuddy" \
  --dart-define=APP_SUFFIX="" \
  --dart-define=BOOKS_API_KEY=YOUR_PROD_KEY \
  --dart-define=BOOKS_BASE_URL=https://www.googleapis.com/books/v1

# show 0 errors (some warnings from empty files is fine)
flutter analyze

# Code Generation
dart run build_runner build --delete-conflicting-outputs
