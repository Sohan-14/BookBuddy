class AppRoutes {
  const AppRoutes._();

  // Shell tabs
  static const bookList = '/';
  static const favorites = '/favorites';
  static const settings = '/settings';

  // Detail — outside shell
  static const bookDetail = '/books/:id';

  // Helper — use this when navigating, not the raw path
  static String bookDetailPath(String id) => '/books/$id';
}
