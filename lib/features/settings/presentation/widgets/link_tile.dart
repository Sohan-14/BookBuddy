import 'package:flutter/material.dart';

class LinkTile extends StatelessWidget {
  const LinkTile({
    required this.icon,
    required this.label,
    required this.url,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String url;
  final VoidCallback onTap;

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
        url,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary.withValues(alpha: 0.7),
        ),
      ),
      trailing: Icon(
        Icons.copy_rounded,
        size: 16,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
      ),
      onTap: onTap,
    );
  }
}
