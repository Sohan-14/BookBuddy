import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/core/error/failures.dart';
import 'package:book_buddy/features/books/domain/usecases/get_books_usecase.dart';
import 'package:book_buddy/features/books/presentation/providers/book_providers.dart';
import 'package:book_buddy/features/books/presentation/states/book_list_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class BookListNotifier extends _$BookListNotifier {
  @override
  Future<BookListState> build() async {
    return _fetchInitial();
  }

  // ─── Private ────────────────────────────────────────────────────

  Future<BookListState> _fetchInitial({String query = ''}) async {
    try {
      final result = await ref
          .read(getBooksUseCaseProvider)
          .call(GetBooksParams(query: query, startIndex: 0));

      return BookListState(
        books: [],
        totalItems: result.totalItems,
        currentStartIndex: result.books.length,
        hasReachedEnd: result.books.length >= result.totalItems,
        query: query,
      );
    } catch (e) {
      rethrow;
    }
  }

  // ─── Public ─────────────────────────────────────────────────────

  /// Manual refresh — triggered by pull-to-refresh or retry button.
  /// Sets AsyncLoading first, then re-fetches.
  Future<void> refresh() async {
    final currentQuery = state.value?.query ?? '';
    // Manually set loading — does NOT trigger build() retry
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetchInitial(query: currentQuery),
    );
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed == (state.value?.query ?? '')) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetchInitial(query: trimmed),
    );
  }

  Future<void> fetchNextPage() async {
    final current = state.value;
    if (current == null) return;
    if (current.isLoadingMore || current.hasReachedEnd) return;

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
    } catch (e) {
      state = AsyncData(
        current.copyWith(
          isLoadingMore: false,
          paginationError: 'Something went wrong.',
        ),
      );
    }
  }
}
