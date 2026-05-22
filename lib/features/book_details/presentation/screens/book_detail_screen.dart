import 'package:book_buddy/core/widgets/app_error_widget.dart';
import 'package:book_buddy/core/widgets/loading_widget.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/books/presentation/notifiers/book_list_notifier.dart';
import 'package:book_buddy/features/favorites/presentation/widgets/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          _DetailSliverAppBar(book: book),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _TitleSection(book: book),
                const SizedBox(height: 16),
                _MetaChipsRow(book: book),
                const SizedBox(height: 28),
                if (book.description != null) ...[
                  const _SectionTitle('About'),
                  const SizedBox(height: 10),
                  _DescriptionText(book.description!),
                  const SizedBox(height: 28),
                ],
                if (book.categories.isNotEmpty) ...[
                  const _SectionTitle('Categories'),
                  const SizedBox(height: 10),
                  _CategoriesWrap(categories: book.categories),
                  const SizedBox(height: 28),
                ],
                _PublisherSection(book: book),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Sliver App Bar ──────────────────────────────────────────────────────────

class _DetailSliverAppBar extends StatelessWidget {
  const _DetailSliverAppBar({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      stretch: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      actions: [
        FavoriteButton(book: book, size: 26),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            _CoverBackground(url: book.thumbnailUrl),
            // Bottom fade so content below blends cleanly
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      theme.scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoverBackground extends StatelessWidget {
  const _CoverBackground({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null) return const _CoverPlaceholder();

    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.contain,
      placeholder: (_, _) => const _CoverPlaceholder(),
      errorWidget: (_, _, _) => const _CoverPlaceholder(),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.book_rounded,
        size: 80,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
      ),
    );
  }
}

// ─── Title Section ───────────────────────────────────────────────────────────

class _TitleSection extends StatelessWidget {
  const _TitleSection({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          book.authorsDisplay,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─── Meta Chips ──────────────────────────────────────────────────────────────

class _MetaChipsRow extends StatelessWidget {
  const _MetaChipsRow({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (book.averageRating != null)
          _MetaChip(
            icon: Icons.star_rounded,
            iconColor: Colors.amber,
            label:
                '${book.averageRating!.toStringAsFixed(1)}'
                '${book.ratingsCount != null ? '  (${book.ratingsCount})' : ''}',
          ),
        if (book.pageCount != null)
          _MetaChip(
            icon: Icons.menu_book_rounded,
            label: '${book.pageCount} pages',
          ),
        if (book.publishedDate != null)
          _MetaChip(
            icon: Icons.calendar_today_rounded,
            label: book.publishedDate!,
          ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? theme.colorScheme.primary),
          const SizedBox(width: 5),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ─── Sections ────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _DescriptionText extends StatefulWidget {
  const _DescriptionText(this.text);

  final String text;

  @override
  State<_DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<_DescriptionText> {
  bool _expanded = false;

  static const _collapsedMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.text,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
            maxLines: _collapsedMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            widget.text,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? 'Show less' : 'Read more',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoriesWrap extends StatelessWidget {
  const _CategoriesWrap({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories
          .map(
            (c) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.4),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(c, style: theme.textTheme.bodySmall),
            ),
          )
          .toList(),
    );
  }
}

class _PublisherSection extends StatelessWidget {
  const _PublisherSection({required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    if (book.publisher == null && book.publishedDate == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
        const SizedBox(height: 12),
        if (book.publisher != null)
          _InfoRow(label: 'Publisher', value: book.publisher!),
        if (book.publishedDate != null)
          _InfoRow(label: 'Published', value: book.publishedDate!),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
