import 'package:book_buddy/app.dart';
import 'package:book_buddy/core/storage/hive_service.dart';
import 'package:book_buddy/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.initialize();
  await HiveService.init();
  runApp(const ProviderScope(child: App()));
}
