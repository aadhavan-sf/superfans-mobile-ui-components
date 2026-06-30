import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';
import '../../preview/molecule_preview.dart';
import 'sf_toolbar.dart';

class ToolbarPlaygroundPage extends StatelessWidget {
  const ToolbarPlaygroundPage({
    super.key,
    required this.variant,
    required this.leftAction,
    required this.centerContent,
    required this.centerLabel,
    this.rightIconSlot1,
    this.rightIconSlot2,
    required this.badgeCount,
  });

  final SfToolbarVariant variant;
  final SfToolbarLeftActionKnob leftAction;
  final SfToolbarCenterContentKnob centerContent;
  final String centerLabel;
  final SfToolbarRightAction? rightIconSlot1;
  final SfToolbarRightAction? rightIconSlot2;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return MoleculePlaygroundScaffold(
      title: 'Toolbar',
      subtitle: variant.label,
      child: SfToolbar(
        variant: variant,
        leftAction: leftAction.action,
        centerContent: centerContent.content,
        centerLabel: centerLabel,
        rightIconSlot1: rightIconSlot1,
        rightIconSlot2: rightIconSlot2,
        badgeCount: badgeCount,
      ),
    );
  }
}

class ToolbarVariantsPage extends StatelessWidget {
  const ToolbarVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoleculeVariantsScaffold(
      title: 'Toolbar',
      sections: [
        MoleculeSection(
          title: 'Figma homepage variants',
          subtitle: 'Homepage toolbar presets from Mobile UI / Toolbar.',
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.circular(AppRadius.radius2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.spacing6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final variant in SfToolbarVariant.values) ...[
                    SfToolbar(variant: variant),
                    if (variant != SfToolbarVariant.values.last)
                      SizedBox(height: AppSpacing.spacing4),
                  ],
                ],
              ),
            ),
          ),
        ),
        MoleculeSection(
          title: 'Left slot options',
          subtitle: 'Back, notifications, menu, and empty slot.',
          child: Wrap(
            spacing: AppSpacing.spacing3,
            runSpacing: AppSpacing.spacing3,
            alignment: WrapAlignment.center,
            children: SfToolbarLeftAction.values
                .map((action) => _ToolbarLeftOptionChip(action: action))
                .toList(),
          ),
        ),
        MoleculeSection(
          title: 'Center slot options',
          subtitle: 'Label, mark, and full logo.',
          child: Wrap(
            spacing: AppSpacing.spacing3,
            runSpacing: AppSpacing.spacing3,
            alignment: WrapAlignment.center,
            children: SfToolbarCenterContent.values
                .map(
                  (content) => _ToolbarCenterOptionChip(centerContent: content),
                )
                .toList(),
          ),
        ),
        MoleculeSection(
          title: 'Right slot options',
          subtitle: 'All right-slot icon options with badge count 10.',
          child: Wrap(
            spacing: AppSpacing.spacing3,
            runSpacing: AppSpacing.spacing3,
            alignment: WrapAlignment.center,
            children: [
              ...sfToolbarRightIconSlotOptions.map(
                (action) => _ToolbarRightOptionChip(action: action),
              ),
              const _ToolbarRightOptionChip(
                action: SfToolbarRightAction.none,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToolbarLeftOptionChip extends StatelessWidget {
  const _ToolbarLeftOptionChip({required this.action});

  final SfToolbarLeftAction action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfToolbarLeftActionPreview(action: action),
        SizedBox(height: AppSpacing.spacing1),
        Text(
          action.label,
          style: AppTypography.textXs.regular(color: AppColors.neutral600),
        ),
      ],
    );
  }
}

class _ToolbarCenterOptionChip extends StatelessWidget {
  const _ToolbarCenterOptionChip({required this.centerContent});

  final SfToolbarCenterContent centerContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfToolbarCenterContentPreview(centerContent: centerContent),
        SizedBox(height: AppSpacing.spacing1),
        Text(
          centerContent.label,
          style: AppTypography.textXs.regular(color: AppColors.neutral600),
        ),
      ],
    );
  }
}

class _ToolbarRightOptionChip extends StatelessWidget {
  const _ToolbarRightOptionChip({required this.action});

  final SfToolbarRightAction action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfToolbarRightActionPreview(action: action),
        SizedBox(height: AppSpacing.spacing1),
        Text(
          action.label,
          style: AppTypography.textXs.regular(color: AppColors.neutral600),
        ),
      ],
    );
  }
}
