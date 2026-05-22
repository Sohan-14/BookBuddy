import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';

class AddFavoriteUseCase implements UseCase<void, BookEntity> {
  const AddFavoriteUseCase(this._repository);

  final FavoritesRepository _repository;

  @override
  Future<void> call(BookEntity params) async => _repository.addFavorite(params);
}
