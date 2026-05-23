import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({required this.packageInfoAsync, super.key});

  final AsyncValue<PackageInfo> packageInfoAsync;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              size: 32,
              color: AppColors.surface,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BookBuddy',
                style: AppTextStyles.displayLarge.copyWith(),
              ),
              const SizedBox(height: 6),
              packageInfoAsync.when(
                data: (info) => _VersionBadge(version: info.version),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VersionBadge extends StatelessWidget {
  const _VersionBadge({required this.version});

  final String version;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'v$version',
        style: AppTextStyles.titleMedium.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
