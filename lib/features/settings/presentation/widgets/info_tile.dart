import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
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
    return ListTile(
      leading: Icon(
        icon,
        size: 22,
        color: AppColors.textPrimary.withValues(alpha: 0.6),
      ),
      title: Text(label, style: AppTextStyles.bodyMedium),
      trailing: Text(
        trailing,
        style: AppTextStyles.bodySmall.copyWith(
          color: trailingColor ?? AppColors.textPrimary.withValues(alpha: 0.5),
          fontWeight: trailingColor != null ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
