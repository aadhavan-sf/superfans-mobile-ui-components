import 'package:flutter/material.dart';

import '../foundation/app_colors.dart';
import '../foundation/app_spacing.dart';
import '../foundation/type_scale_preview.dart';

class PreviewSpecPanel extends StatelessWidget {
  const PreviewSpecPanel({
    super.key,
    required this.items,
  });

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.spacing2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current values',
              style: AppTypeScaleToken.textSm.style(
                AppTypeWeight.semibold,
                color: AppColors.neutral700,
              ),
            ),
            const SizedBox(height: AppSpacing.spacing2),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.spacing1),
                child: Text(
                  item,
                  style: AppTypeScaleToken.textSm.style(
                    AppTypeWeight.regular,
                    color: AppColors.neutral600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PreviewHelpBanner extends StatelessWidget {
  const PreviewHelpBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.brand25,
        border: Border.all(color: AppColors.brand100),
        borderRadius: BorderRadius.circular(AppSpacing.spacing2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacing3),
        child: Text(
          'Adjust props in the Knobs panel (right). '
          'Use the zoom toolbar below the component — scroll, pinch, slider, or +/-. '
          'For layout inspection, open Addons → enable Inspector.',
          style: AppTypeScaleToken.textXs.style(
            AppTypeWeight.regular,
            color: AppColors.brand700,
          ),
        ),
      ),
    );
  }
}
