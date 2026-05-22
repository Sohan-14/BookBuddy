import 'package:book_buddy/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  const ScaffoldWithBottomNav({required this.child, super.key});

  final Widget child;

  static const List<BottomTab> _tabs = [
    BottomTab(
      path: AppRoutes.bookList,
      label: 'Explore',
      icon: Icon(Icons.menu_book_outlined),
      activeIcon: Icon(Icons.menu_book),
    ),
    BottomTab(
      path: AppRoutes.favorites,
      label: 'Favorites',
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
    ),
    BottomTab(
      path: AppRoutes.settings,
      label: 'Settings',
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
    ),
  ];

  int _locationToIndex(String location) {
    if (location.startsWith(AppRoutes.favorites)) return 1;
    if (location.startsWith(AppRoutes.settings)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => context.go(_tabs[index].path),
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
                icon: tab.icon,
                selectedIcon: tab.activeIcon,
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class BottomTab {
  const BottomTab({
    required this.path,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String path;
  final String label;
  final Widget icon;
  final Widget activeIcon;
}
