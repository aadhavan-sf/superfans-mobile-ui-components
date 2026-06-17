import 'package:flutter/material.dart';

import '../foundation/app_colors.dart';
import '../foundation/app_spacing.dart';
import '../foundation/type_scale_preview.dart';
import '../preview/preview_specs.dart';
import '../preview/preview_zoom.dart';

class AtomPlaygroundScaffold extends StatelessWidget {
  const AtomPlaygroundScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.specs = const [],
  });

  final String title;
  final String subtitle;
  final Widget child;
  final List<String> specs;

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AtomVariantsScaffold extends StatelessWidget {
  const AtomVariantsScaffold({
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
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypeScaleToken.textXxl.style(AppTypeWeight.bold),
                ),
                const SizedBox(height: AppSpacing.spacing2),
                Text(
                  'Atoms',
                  style: AppTypeScaleToken.textSm.style(
                    AppTypeWeight.regular,
                    color: AppColors.neutral600,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacing4),
                const PreviewHelpBanner(),
                const SizedBox(height: AppSpacing.spacing6),
                ...sections,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AtomSection extends StatelessWidget {
  const AtomSection({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.spacing6),
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
          const SizedBox(height: AppSpacing.spacing3),
          Wrap(
            spacing: AppSpacing.spacing4,
            runSpacing: AppSpacing.spacing4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}

class AtomLabeledControl extends StatelessWidget {
  const AtomLabeledControl({
    super.key,
    required this.label,
    required this.control,
  });

  final String label;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        control,
        const SizedBox(height: AppSpacing.spacing2),
        Text(
          label,
          style: AppTypeScaleToken.textXs.style(
            AppTypeWeight.regular,
            color: AppColors.neutral600,
          ),
        ),
      ],
    );
  }
}
