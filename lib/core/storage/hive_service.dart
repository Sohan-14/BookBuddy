import 'dart:io';

import 'package:book_buddy/core/constants/app_constants.dart';
import 'package:hive_ce/hive_ce.dart';

class HiveService {
  const HiveService._();

  static Future<void> init() async {
    final path = Directory.current.path;
    Hive.init(path);
    // Register adapters here as you add Hive models
    await Hive.openBox<dynamic>(AppConstants.favoritesBoxName);
  }

  static Box<dynamic> get favoritesBox =>
      Hive.box<dynamic>(AppConstants.favoritesBoxName);
}
