import 'package:book_buddy/core/router/scaffold_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Center(
                child: Text('data'),
              ),
            ),
          ),
          GoRoute(
            path: '/favorites',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Center(
                child: Text('data'),
              ),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: Center(
                child: Text('data'),
              ),
            ),
          ),
        ],
      ),

      GoRoute(
        path: '/books/:id',
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;
          return Center(
            child: Text(bookId),
          );
        },
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Center(
            child: Text('data'),
          ),
        ),
      ),
    ],
  );
}
