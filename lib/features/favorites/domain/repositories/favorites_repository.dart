import 'package:book_buddy/features/books/domain/entities/book_entity.dart';

abstract interface class FavoritesRepository {
  List<BookEntity> getFavorites();
  void addFavorite(BookEntity book);
  void removeFavorite(String bookId);
  bool isFavorite(String bookId);
}
