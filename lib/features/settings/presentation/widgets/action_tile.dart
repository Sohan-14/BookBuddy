import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      ),
      title: Text(label, style: theme.textTheme.bodyMedium),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
