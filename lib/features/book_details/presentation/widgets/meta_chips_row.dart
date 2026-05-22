import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';

class MetaChipsRow extends StatelessWidget {
  const MetaChipsRow({required this.book, super.key});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (book.averageRating != null)
          _MetaChip(
            icon: Icons.star_rounded,
            iconColor: Colors.amber,
            label:
                '${book.averageRating!.toStringAsFixed(1)}'
                '${book.ratingsCount != null ? '  (${book.ratingsCount})' : ''}',
          ),
        if (book.pageCount != null)
          _MetaChip(
            icon: Icons.menu_book_rounded,
            label: '${book.pageCount} pages',
          ),
        if (book.publishedDate != null)
          _MetaChip(
            icon: Icons.calendar_today_rounded,
            label: book.publishedDate!,
          ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.textSecondary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? AppColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
