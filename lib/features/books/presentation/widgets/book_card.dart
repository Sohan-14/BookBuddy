import 'package:book_buddy/core/router/app_routes.dart';
import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  const BookCard({required this.book, super.key});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: .5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(AppRoutes.bookDetailPath(book.id)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BookCover(url: book.thumbnailUrl),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        book.title,
                        style: AppTextStyles.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book.authorsDisplay,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            book.averageRating?.toStringAsFixed(1) ??
                                'No Ratings',
                            style: AppTextStyles.bodyMedium,
                          ),
                          const SizedBox(width: 8),
                          const Spacer(),
                          if (book.pageCount != null)
                            Text(
                              '${book.pageCount} pages',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textPrimary.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookCover extends StatelessWidget {
  const _BookCover({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: url != null
          ? CachedNetworkImage(
              imageUrl: url!,
              width: 70,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (_, _) => _Placeholder(),
              errorWidget: (_, _, _) => _Placeholder(),
            )
          : _Placeholder(),
    );
  }
}

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.book_rounded,
        color: AppColors.textSecondary,
      ),
    );
  }
}
