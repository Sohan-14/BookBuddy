import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/books/domain/repositories/book_repository.dart';

class SearchBooksUseCase
    implements
        UseCase<({List<BookEntity> books, int totalItems}), SearchBooksParams> {
  const SearchBooksUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<({List<BookEntity> books, int totalItems})> call(
    SearchBooksParams params,
  ) => _repository.getBooks(
    query: params.query.trim(),
    startIndex: 0,
    maxResults: AppConstants.paginationLimit,
  );
}

class SearchBooksParams {
  const SearchBooksParams({required this.query});

  final String query;
}
