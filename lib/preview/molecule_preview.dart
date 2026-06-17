import 'package:flutter/material.dart';

import '../foundation/app_colors.dart';
import '../foundation/app_spacing.dart';
import '../foundation/type_scale_preview.dart';
import 'preview_specs.dart';
import 'preview_zoom.dart';

class MoleculePlaygroundScaffold extends StatelessWidget {
  const MoleculePlaygroundScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.specs = const [],
    this.footer,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final List<String> specs;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.spacing8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: AppTypeScaleToken.textXxl.style(AppTypeWeight.bold),
                ),
                const SizedBox(height: AppSpacing.spacing2),
                Text(
                  subtitle,
                  style: AppTypeScaleToken.textSm.style(
                    AppTypeWeight.regular,
                    color: AppColors.neutral600,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing4),
                const PreviewHelpBanner(),
                if (specs.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.spacing4),
                  PreviewSpecPanel(items: specs),
                ],
                const SizedBox(height: AppSpacing.spacing10),
                PreviewZoomSurface(child: child),
                if (footer != null) ...[
                  const SizedBox(height: AppSpacing.spacing6),
                  Align(alignment: Alignment.center, child: footer!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoleculeVariantsScaffold extends StatelessWidget {
  const MoleculeVariantsScaffold({
    super.key,
    required this.title,
    required this.sections,
  });

  final String title;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.spacing8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypeScaleToken.textXxl.style(AppTypeWeight.bold),
                ),
                const SizedBox(height: AppSpacing.spacing2),
                Text(
                  'Molecules',
                  style: AppTypeScaleToken.textSm.style(
                    AppTypeWeight.regular,
                    color: AppColors.neutral600,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing4),
                const PreviewHelpBanner(),
                const SizedBox(height: AppSpacing.spacing8),
                ...sections,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoleculeSection extends StatelessWidget {
  const MoleculeSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.spacing10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypeScaleToken.textSm.style(
              AppTypeWeight.semibold,
              color: AppColors.neutral700,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.spacing1),
            Text(
              subtitle!,
              style: AppTypeScaleToken.textXs.style(
                AppTypeWeight.regular,
                color: AppColors.neutral600,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.spacing4),
          Align(
            alignment: Alignment.center,
            child: PreviewZoomSurface(initialScale: 2.5, child: child),
          ),
        ],
      ),
    );
  }
}
