import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
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
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: AppColors.textPrimary.withValues(alpha: 0.6),
      ),
      title: Text(label, style: AppTextStyles.bodyMedium),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
