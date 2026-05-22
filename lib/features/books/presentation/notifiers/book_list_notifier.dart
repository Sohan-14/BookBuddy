import 'package:book_buddy/core/error/failures.dart';
import 'package:book_buddy/features/books/domain/usecases/get_books_usecase.dart';
import 'package:book_buddy/features/books/presentation/providers/book_providers.dart';
import 'package:book_buddy/features/books/presentation/states/book_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class BookListNotifier extends _$BookListNotifier {
  @override
  Future<BookListState> build() => _fetchInitial();

  // ─── Private ────────────────────────────────────────────────────────────────

  Future<BookListState> _fetchInitial({String query = ''}) async {
    final result = await ref
        .read(getBooksUseCaseProvider)
        .call(GetBooksParams(query: query, startIndex: 0));

    return BookListState(
      books: result.books,
      totalItems: result.totalItems,
      currentStartIndex: result.books.length,
      hasReachedEnd: result.books.length >= result.totalItems,
      query: query,
    );
  }

  // ─── Public ─────────────────────────────────────────────────────────────────

  Future<void> fetchNextPage() async {
    final current = state.value;
    if (current == null) return;
    if (current.isLoadingMore || current.hasReachedEnd) return;

    // Mark loading — keep existing data visible
    state = AsyncData(
      current.copyWith(
        isLoadingMore: true,
        clearPaginationError: true,
      ),
    );

    try {
      final result = await ref
          .read(getBooksUseCaseProvider)
          .call(
            GetBooksParams(
              query: current.query,
              startIndex: current.currentStartIndex,
            ),
          );

      final merged = [...current.books, ...result.books];

      state = AsyncData(
        current.copyWith(
          books: merged,
          totalItems: result.totalItems,
          currentStartIndex: merged.length,
          isLoadingMore: false,
          hasReachedEnd: merged.length >= result.totalItems,
          clearPaginationError: true,
        ),
      );
    } on NetworkFailure catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          paginationError: e.message,
        ),
      );
    } on ServerFailure catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          paginationError: e.message,
        ),
      );
    }
  }

  Future<void> refresh() async {
    final currentQuery = state.value?.query ?? '';
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchInitial(query: currentQuery));
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    // Skip if same query
    if (trimmed == (state.value?.query ?? '')) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchInitial(query: trimmed));
  }
}
