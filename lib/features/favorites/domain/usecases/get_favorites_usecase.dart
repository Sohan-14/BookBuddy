import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';

class GetFavoritesUseCase implements UseCase<List<BookEntity>, NoParams> {
  const GetFavoritesUseCase(this._repository);

  final FavoritesRepository _repository;

  @override
  Future<List<BookEntity>> call(NoParams params) async =>
      _repository.getFavorites();
}
