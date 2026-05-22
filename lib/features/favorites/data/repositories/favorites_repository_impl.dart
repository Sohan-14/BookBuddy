import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/features/books/domain/entities/book_entity.dart';
import 'package:book_buddy/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:book_buddy/features/favorites/data/mappers/hive_book_mapper.dart';
import 'package:book_buddy/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._datasource);

  final FavoritesLocalDatasource _datasource;

  @override
  List<BookEntity> getFavorites() {
    try {
      final models = _datasource.getFavorites();
      return HiveBookMapper.toEntityList(models);
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  void addFavorite(BookEntity book) {
    try {
      final model = HiveBookMapper.toHiveModel(book);
      _datasource.addFavorite(model);
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  void removeFavorite(String bookId) {
    try {
      _datasource.removeFavorite(bookId);
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }

  @override
  bool isFavorite(String bookId) {
    try {
      return _datasource.isFavorite(bookId);
    } on CacheException catch (e) {
      throw CacheException(e.message);
    }
  }
}
