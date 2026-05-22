import 'package:book_buddy/core/error/exceptions.dart';
import 'package:book_buddy/core/storage/hive_service.dart';
import 'package:book_buddy/features/favorites/data/models/hive_book_model.dart';
import 'package:hive_ce/hive.dart';

abstract interface class FavoritesLocalDatasource {
  List<HiveBookModel> getFavorites();
  void addFavorite(HiveBookModel model);
  void removeFavorite(String bookId);
  bool isFavorite(String bookId);
}

class FavoritesLocalDatasourceImpl implements FavoritesLocalDatasource {
  FavoritesLocalDatasourceImpl() : _box = HiveService.favoritesBox;

  final Box<HiveBookModel> _box;

  @override
  List<HiveBookModel> getFavorites() {
    try {
      return _box.values.whereType<HiveBookModel>().toList();
    } catch (e) {
      throw CacheException('Failed to load favorites: $e');
    }
  }

  @override
  Future<void> addFavorite(HiveBookModel model) async {
    try {
      await _box.put(model.id, model);
    } catch (e) {
      throw CacheException('Failed to save favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(String bookId) async {
    try {
      await _box.delete(bookId);
    } catch (e) {
      throw CacheException('Failed to remove favorite: $e');
    }
  }

  @override
  bool isFavorite(String bookId) {
    try {
      return _box.containsKey(bookId);
    } catch (e) {
      throw CacheException('Failed to check favorite: $e');
    }
  }
}
