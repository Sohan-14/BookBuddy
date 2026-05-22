import 'package:book_buddy/core/usecase/usecase.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  const IsFavoriteUseCase(this._repository);

  final FavoritesRepository _repository;

  @override
  Future<bool> call(String params) async => _repository.isFavorite(params);
}
