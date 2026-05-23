import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    required this.icon,
    required this.label,
    required this.trailing,
    super.key,
    this.trailingColor,
  });

  final IconData icon;
  final String label;
  final String trailing;
  final Color? trailingColor;

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
      trailing: Text(
        trailing,
        style: theme.textTheme.bodySmall?.copyWith(
          color:
              trailingColor ??
              theme.colorScheme.onSurface.withValues(alpha: 0.5),
          fontWeight: trailingColor != null ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
