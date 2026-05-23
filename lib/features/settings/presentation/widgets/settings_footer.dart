import 'package:flutter/material.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({required this.theme, super.key});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Built with Flutter',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Clean Architecture · Riverpod · Hive',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
