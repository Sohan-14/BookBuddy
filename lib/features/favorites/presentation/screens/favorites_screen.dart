import 'package:book_buddy/core/router/app_routes.dart';
import 'package:book_buddy/core/widgets/empty_state_widget.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/presentation/notifiers/favorites_notifier.dart';
import 'package:book_buddy/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? EmptyStateWidget(
              action: () => context.go(AppRoutes.bookList),
              message: 'Have no favorite books',
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: favorites.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) =>
                  _FavoriteCard(book: favorites[index]),
            ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(AppRoutes.bookDetailPath(book.id)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FavoriteCover(url: book.thumbnailUrl),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        book.title,
                        style: theme.textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book.authorsDisplay,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (book.averageRating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              book.averageRating!.toStringAsFixed(1),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              // Favorite toggle directly on card
              FavoriteButton(book: book),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteCover extends StatelessWidget {
  const _FavoriteCover({this.url});

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
              placeholder: (_, __) => _Placeholder(),
              errorWidget: (_, __, ___) => _Placeholder(),
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
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.book_rounded,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      ),
    );
  }
}
