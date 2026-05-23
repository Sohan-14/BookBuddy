import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
