import 'package:book_buddy/core/widgets/app_error_widget.dart';
import 'package:book_buddy/core/widgets/empty_state_widget.dart';
import 'package:book_buddy/core/widgets/shimmer_card.dart';
import 'package:book_buddy/features/books/presentation/notifiers/book_list_notifier.dart';
import 'package:book_buddy/features/books/presentation/widgets/book_card.dart';
import 'package:book_buddy/features/books/presentation/widgets/book_search_bar.dart';
import 'package:book_buddy/features/books/presentation/widgets/pagination_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen> {
  final _scrollController = ScrollController();

  static const _scrollThreshold = 300.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final nearBottom =
        position.pixels >= position.maxScrollExtent - _scrollThreshold;
    if (nearBottom) {
      ref.read(bookListProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('REBUILD BOOK LIST SCREEN');
    final asyncState = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('BookBuddy')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: BookSearchBar(
              onSearch: (query) =>
                  ref.read(bookListProvider.notifier).search(query),
            ),
          ),
          Expanded(
            child: asyncState.when(
              loading: () => const ShimmerList(),
              error: (error, _) => AppErrorWidget.fromFailure(
                error,
                onRetry: () => ref.read(bookListProvider.notifier).refresh(),
              ),
              data: (bookState) {
                if (bookState.isEmpty) {
                  return EmptyStateWidget(
                    message: bookState.query.isEmpty
                        ? 'No books available.\nPull down to refresh.'
                        : 'No results for "${bookState.query}".\nTry a different keyword.',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(bookListProvider.notifier).refresh(),
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: bookState.books.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (index == bookState.books.length) {
                        return PaginationFooter(
                          isLoadingMore: bookState.isLoadingMore,
                          hasReachedEnd: bookState.hasReachedEnd,
                          errorMessage: bookState.paginationError,
                          onRetry: () => ref
                              .read(bookListProvider.notifier)
                              .fetchNextPage(),
                        );
                      }
                      return BookCard(book: bookState.books[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _errorMessage(Object error) {
    return error.toString().replaceAll('Exception: ', '');
  }
}
