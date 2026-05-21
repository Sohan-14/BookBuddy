import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig.initialize();
  runApp(const ProviderScope(child: App()));
}