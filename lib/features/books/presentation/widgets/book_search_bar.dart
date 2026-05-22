import 'package:book_buddy/core/constants/app_constants.dart';
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
  late final _debounce = Debounce(
    milliseconds: AppConstants.searchDebounceMs,
  );

  @override
  void dispose() {
    _controller.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    _debounce.run(() => widget.onSearch(value));
  }

  void _onClear() {
    _controller.clear();
    setState(() {});
    widget.onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search books or authors...',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: _onClear,
              )
            : null,
      ),
    );
  }
}
