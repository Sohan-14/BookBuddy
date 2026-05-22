import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase implements UseCase<void, String> {
  const RemoveFavoriteUseCase(this._repository);

  final FavoritesRepository _repository;

  @override
  Future<void> call(String params) async => _repository.removeFavorite(params);
}
