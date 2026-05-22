import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailSliverAppBar extends StatelessWidget {
  const DetailSliverAppBar({required this.book, super.key});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.surface.withValues(alpha: .1),
      actions: [
        FavoriteButton(book: book, size: 26),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            _CoverBackground(url: book.thumbnailUrl),
            // Bottom fade so content below blends cleanly
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.textPrimary.withValues(alpha: .5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoverBackground extends StatelessWidget {
  const _CoverBackground({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null) return const _CoverPlaceholder();

    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.contain,
      placeholder: (_, _) => const _CoverPlaceholder(),
      errorWidget: (_, _, _) => const _CoverPlaceholder(),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: Icon(
        Icons.book_rounded,
        size: 80,
        color: AppColors.textSecondary.withValues(alpha: 0.5),
      ),
    );
  }
}
