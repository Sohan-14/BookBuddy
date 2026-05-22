import 'package:book_buddy/core/error/failures.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/presentation/providers/favorites_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_notifier.g.dart';

@Riverpod(keepAlive: true)
class FavoritesNotifier extends _$FavoritesNotifier {
  @override
  List<BookEntity> build() {
    try {
      return ref.read(favoritesRepositoryProvider).getFavorites();
    } catch (_) {
      return [];
    }
  }

  // ─── Public ───────────────────────────────────────────────────────

  void toggle(BookEntity book) {
    isFavorite(book.id) ? _remove(book.id) : _add(book);
  }

  bool isFavorite(String bookId) => state.any((b) => b.id == bookId);

  // ─── Private ──────────────────────────────────────────────────────

  void _add(BookEntity book) {
    try {
      ref.read(favoritesRepositoryProvider).addFavorite(book);
      state = [...state, book];
    } on CacheFailure {
      // Hive write failed — state unchanged, consistent with storage
    }
  }

  void _remove(String bookId) {
    try {
      ref.read(favoritesRepositoryProvider).removeFavorite(bookId);
      state = state.where((b) => b.id != bookId).toList();
    } on CacheFailure {
      // Hive delete failed — state unchanged
    }
  }
}
