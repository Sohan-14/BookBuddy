import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/core/widgets/app_error_widget.dart';
import 'package:book_buddy/core/widgets/loading_widget.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/category_wrap.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/description_text.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/details_app_bar.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/meta_chips_row.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/publisher_section.dart';
import 'package:book_buddy/features/book_details/presentation/widgets/section_title.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/books/presentation/notifiers/book_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailScreen extends ConsumerWidget {
  const BookDetailScreen({required this.bookId, super.key});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(bookListProvider);

    return asyncState.when(
      loading: () => const Scaffold(body: LoadingWidget()),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: AppErrorWidget.fromFailure(e),
      ),
      data: (bookState) {
        final book = bookState.books.where((b) => b.id == bookId).firstOrNull;

        if (book == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const AppErrorWidget(message: 'Book not found.'),
          );
        }

        return _BookDetailView(book: book);
      },
    );
  }
}

class _BookDetailView extends StatelessWidget {
  const _BookDetailView({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailSliverAppBar(book: book),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _TitleSection(book: book),
                const SizedBox(height: 16),
                MetaChipsRow(book: book),
                const SizedBox(height: 28),
                if (book.description != null) ...[
                  const SectionTitle('About'),
                  const SizedBox(height: 10),
                  DescriptionText(book.description!),
                  const SizedBox(height: 28),
                ],
                if (book.categories.isNotEmpty) ...[
                  const SectionTitle('Categories'),
                  const SizedBox(height: 10),
                  CategoriesWrap(categories: book.categories),
                  const SizedBox(height: 28),
                ],
                PublisherSection(book: book),
                const SizedBox(
                  height: 100,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: AppTextStyles.displayLarge.copyWith(
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          book.authorsDisplay,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
