import 'package:book_buddy/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:book_buddy/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:book_buddy/features/favorites/domain/usecases/add_favorite_usecase.dart';
import 'package:book_buddy/features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'package:book_buddy/features/favorites/domain/usecases/is_favorite_usecase.dart';
import 'package:book_buddy/features/favorites/domain/usecases/remove_favorite_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorites_providers.g.dart';

@Riverpod(keepAlive: true)
FavoritesLocalDatasource favoritesLocalDatasource(
  Ref ref,
) =>
    FavoritesLocalDatasourceImpl();

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) =>
    FavoritesRepositoryImpl(ref.watch(favoritesLocalDatasourceProvider));

@Riverpod(keepAlive: true)
GetFavoritesUseCase getFavoritesUseCase(Ref ref) =>
    GetFavoritesUseCase(ref.watch(favoritesRepositoryProvider));

@Riverpod(keepAlive: true)
AddFavoriteUseCase addFavoriteUseCase(Ref ref) =>
    AddFavoriteUseCase(ref.watch(favoritesRepositoryProvider));

@Riverpod(keepAlive: true)
RemoveFavoriteUseCase removeFavoriteUseCase(Ref ref) =>
    RemoveFavoriteUseCase(ref.watch(favoritesRepositoryProvider));

@Riverpod(keepAlive: true)
IsFavoriteUseCase isFavoriteUseCase(Ref ref) =>
    IsFavoriteUseCase(ref.watch(favoritesRepositoryProvider));
