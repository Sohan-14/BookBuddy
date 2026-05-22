import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/books/domain/repositories/book_repository.dart';

class GetBooksUseCase
    implements
        UseCase<({List<BookEntity> books, int totalItems}), GetBooksParams> {
  const GetBooksUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<({List<BookEntity> books, int totalItems})> call(
    GetBooksParams params,
  ) => _repository.getBooks(
    query: params.query.trim().isEmpty
        ? 'subject:fiction'
        : params.query.trim(),
    startIndex: params.startIndex,
    maxResults: AppConstants.paginationLimit,
  );
}

class GetBooksParams {
  const GetBooksParams({
    required this.query,
    required this.startIndex,
  });

  final String query;
  final int startIndex;
}
