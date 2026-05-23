import 'package:book_buddy/core/router/app_routes.dart';
import 'package:book_buddy/core/router/scaffold_with_bottom_nav.dart';
import 'package:book_buddy/features/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.bookList,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithBottomNav(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.bookList,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: BookListScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: FavoritesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.bookDetail,
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;
          return BookDetailScreen(bookId: bookId);
        },
      ),
    ],
  );
}
