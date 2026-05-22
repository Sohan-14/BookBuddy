import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/presentation/notifiers/favorites_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    required this.book,
    this.size = 24,
    super.key,
  });

  final BookEntity book;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Select only the boolean for this book — avoids rebuilding
    // when other books are toggled
    final isFavorite = ref.watch(
      favoritesProvider.select(
        (favorites) => favorites.any((b) => b.id == book.id),
      ),
    );

    return IconButton(
      onPressed: () =>
          ref.read(favoritesProvider.notifier).toggle(book),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          key: ValueKey(isFavorite),
          color: isFavorite ? Colors.redAccent : null,
          size: size,
        ),
      ),
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
}
