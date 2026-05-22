import 'package:book_buddy/features/books/domain/entities/book_entity.dart';

class BookListState {
  const BookListState({
    this.books = const [],
    this.totalItems = 0,
    this.currentStartIndex = 0,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.query = '',
    this.paginationError,
  });

  final List<BookEntity> books;
  final int totalItems;
  final int currentStartIndex;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String query;
  final String? paginationError;

  bool get isEmpty => books.isEmpty;
  bool get hasBooks => books.isNotEmpty;

  BookListState copyWith({
    List<BookEntity>? books,
    int? totalItems,
    int? currentStartIndex,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    String? query,
    String? paginationError,
    bool clearPaginationError = false,
  }) => BookListState(
    books: books ?? this.books,
    totalItems: totalItems ?? this.totalItems,
    currentStartIndex: currentStartIndex ?? this.currentStartIndex,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    query: query ?? this.query,
    paginationError: clearPaginationError
        ? null
        : paginationError ?? this.paginationError,
  );
}
