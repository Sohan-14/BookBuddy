import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:book_buddy/features/favorites/data/models/hive_book_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  const HiveService._();

  static Future<void> init() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      Hive
        ..init(appDir.path)
        ..registerAdapter(HiveBookModelAdapter());

      await Hive.openBox<HiveBookModel>(AppConstants.favoritesBoxName);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Hive init error: $e');
      }
    }
  }

  static Box<HiveBookModel> get favoritesBox =>
      Hive.box<HiveBookModel>(AppConstants.favoritesBoxName);
}
