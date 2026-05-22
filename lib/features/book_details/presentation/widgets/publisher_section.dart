
import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

class PublisherSection extends StatelessWidget {
  const PublisherSection({required this.book, super.key});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    if (book.publisher == null && book.publishedDate == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: AppColors.textSecondary.withValues(alpha: 0.3)),
        const SizedBox(height: 12),
        if (book.publisher != null)
          _InfoRow(label: 'Publisher', value: book.publisher!),
        if (book.publishedDate != null)
          _InfoRow(label: 'Published', value: book.publishedDate!),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: AppTextStyles.bodySmall),
          ),
        ],
      ),
    );
  }
}
