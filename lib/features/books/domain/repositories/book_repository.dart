import 'package:book_buddy/features/books/domain/entities/book_entity.dart';

abstract interface class BookRepository {
  Future<({List<BookEntity> books, int totalItems})> getBooks({
    required String query,
    required int startIndex,
    required int maxResults,
  });
}
