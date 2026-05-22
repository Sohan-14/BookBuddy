import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoriesWrap extends StatelessWidget {
  const CategoriesWrap({required this.categories, super.key});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories
          .map(
            (c) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textPrimary.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(c, style: AppTextStyles.bodySmall),
            ),
          )
          .toList(),
    );
  }
}
