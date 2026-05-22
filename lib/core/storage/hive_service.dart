import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  const HiveService._();

  static Future<void> init() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      Hive.init(appDir.path);

      // Register your adapters BEFORE opening boxes
      // Hive.registerAdapter(YourModelAdapter());

      await Hive.openBox<dynamic>(AppConstants.favoritesBoxName);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Hive init error: $e');
      }
    }
  }

  static Box<dynamic> get favoritesBox =>
      Hive.box<dynamic>(AppConstants.favoritesBoxName);
}
