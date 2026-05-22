import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/core/utils/debounce.dart';
import 'package:flutter/material.dart';

class BookSearchBar extends StatefulWidget {
  const BookSearchBar({
    required this.onSearch,
    super.key,
  });

  final ValueChanged<String> onSearch;

  @override
  State<BookSearchBar> createState() => _BookSearchBarState();
}

class _BookSearchBarState extends State<BookSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late final _debounce = Debounce(
    milliseconds: AppConstants.searchDebounceMs,
  );

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce.run(() {
      if (_controller.text == value) {
        widget.onSearch(value);
      }
    });
  }

  void _onSubmitted(String value) {
    _focusNode.unfocus();
    widget.onSearch(value);
  }

  void _onClear() {
    _controller.clear();
    _focusNode.unfocus();
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.isNotEmpty;

    return Card(
      color: AppColors.surface,
      elevation: .5,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.surface.withValues(alpha: 0.2),
          ),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          textInputAction: TextInputAction.search,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          decoration: InputDecoration(
            hintText: 'Search books, authors...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            border: InputBorder.none, // Remove default underline
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.primary,
              size: 22,
            ),
            suffixIcon: hasText
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: _onClear,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.clear_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
