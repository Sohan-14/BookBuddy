import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:book_buddy/features/settings/presentation/providers/settings_providers.dart';
import 'package:book_buddy/features/settings/presentation/widgets/action_tile.dart';
import 'package:book_buddy/features/settings/presentation/widgets/info_tile.dart';
import 'package:book_buddy/features/settings/presentation/widgets/link_tile.dart';
import 'package:book_buddy/features/settings/presentation/widgets/section_label.dart';
import 'package:book_buddy/features/settings/presentation/widgets/settings_footer.dart';
import 'package:book_buddy/features/settings/presentation/widgets/settings_header.dart';
import 'package:book_buddy/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfoAsync = ref.watch(packageInfoProvider);
    final theme = Theme.of(context);
    final flavor = FlavorConfig.instance;

    return Scaffold(
      appBar: AppBar(
        shadowColor: AppColors.surface,
        surfaceTintColor: AppColors.surface,
        backgroundColor: AppColors.surface,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Settings',
          style: AppTextStyles.headlineMedium,
        ),
      ),
      backgroundColor: AppColors.surface,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          SettingsHeader(packageInfoAsync: packageInfoAsync),
          const SizedBox(height: 8),
          const SectionLabel('App Info'),
          InfoTile(
            icon: Icons.local_offer_outlined,
            label: 'Version',
            trailing: packageInfoAsync.when(
              data: (info) => '${info.version} (${info.buildNumber})',
              loading: () => '—',
              error: (_, _) => '—',
            ),
          ),
          InfoTile(
            icon: Icons.layers_outlined,
            label: 'Flavor',
            trailing: flavor.flavor.name.toUpperCase(),
            trailingColor: flavor.isDev ? Colors.orange : Colors.green,
          ),
          InfoTile(
            icon: Icons.tag_rounded,
            label: 'Package',
            trailing: packageInfoAsync.when(
              data: (info) => info.packageName,
              loading: () => '—',
              error: (_, _) => '—',
            ),
          ),
          const InfoTile(
            icon: Icons.api_outlined,
            label: 'API',
            trailing: 'Google Books v1',
          ),
          const SizedBox(height: 8),
          const SectionLabel('Data'),
          const ActionTile(
            icon: Icons.storage_outlined,
            label: 'Storage',
            subtitle: 'Hive CE — local favorites',
          ),
          const ActionTile(
            icon: Icons.sync_outlined,
            label: 'State Management',
            subtitle: 'Riverpod — AsyncNotifier pattern',
          ),
          const SizedBox(height: 8),
          const SectionLabel('Links'),
          LinkTile(
            icon: Icons.book_outlined,
            label: 'Google Books API',
            url: 'https://developers.google.com/books',
            onTap: () => _copyToClipboard(
              context,
              'https://developers.google.com/books',
            ),
          ),
          LinkTile(
            icon: Icons.code_rounded,
            label: 'Source Code',
            url: 'https://github.com/Sohan-14/BookBuddy',
            onTap: () => _copyToClipboard(
              context,
              'https://github.com/Sohan-14/BookBuddy',
            ),
          ),
          const SizedBox(height: 32),
          SettingsFooter(theme: theme),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
