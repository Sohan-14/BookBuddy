import 'package:book_buddy/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

class ScaffoldWithBottomNav extends StatelessWidget {
  const ScaffoldWithBottomNav({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          if (navigationShell.currentIndex == index) return;
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
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
