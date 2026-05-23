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

  void toggle(BookEntity book) {
    isFavorite(book.id) ? _remove(book.id) : _add(book);
  }

  bool isFavorite(String bookId) => state.any((b) => b.id == bookId);

  void _add(BookEntity book) {
    try {
      ref.read(favoritesRepositoryProvider).addFavorite(book);
      state = [...state, book];
    } catch (_) {}
  }

  void _remove(String bookId) {
    try {
      ref.read(favoritesRepositoryProvider).removeFavorite(bookId);
      state = state.where((b) => b.id != bookId).toList();
    } catch (_) {}
  }

  Future<void> refresh() async {
    try {
      state = ref.read(favoritesRepositoryProvider).getFavorites();
    } catch (_) {
      state = [];
    }
  }
}
