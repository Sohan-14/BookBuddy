import 'package:book_buddy/core/theme/app_colors.dart';
import 'package:book_buddy/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatefulWidget {
  const DescriptionText(this.text, {super.key});

  final String text;

  @override
  State<DescriptionText> createState() => DescriptionTextState();
}

class DescriptionTextState extends State<DescriptionText> {
  bool _expanded = false;

  static const _collapsedMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            widget.text,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.7),
            maxLines: _collapsedMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
          secondChild: Text(
            widget.text,
            style: AppTextStyles.bodyMedium.copyWith(height: 1.7),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? 'Show less' : 'Read more',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
