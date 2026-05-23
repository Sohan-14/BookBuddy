import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
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
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: AppColors.textPrimary.withValues(alpha: 0.6),
      ),
      title: Text(label, style: AppTextStyles.bodyMedium),
      subtitle: Text(
        url,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
        ),
      ),
      trailing: const Icon(
        Icons.copy_rounded,
        size: 16,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
