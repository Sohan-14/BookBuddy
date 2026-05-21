enum Flavor { dev, prod }

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final String booksBaseUrl;
  final String booksApiKey;

  const FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.booksBaseUrl,
    required this.booksApiKey,
  });

  static late final FlavorConfig instance;

  static void initialize() {
    const flavor = String.fromEnvironment('FLAVOR');
    instance = FlavorConfig._(
      flavor: flavor == 'prod' ? Flavor.prod : Flavor.dev,
      appName: String.fromEnvironment('APP_NAME', defaultValue: 'BookBuddy'),
      booksBaseUrl: String.fromEnvironment('BOOKS_BASE_URL'),
      booksApiKey: String.fromEnvironment('BOOKS_API_KEY'),
    );
  }

  bool get isDev => flavor == Flavor.dev;
}