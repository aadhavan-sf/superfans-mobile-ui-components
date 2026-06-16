import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/type_scale_preview.dart';
import 'sf_button.dart';

class ButtonPlaygroundPage extends StatelessWidget {
  const ButtonPlaygroundPage({
    super.key,
    required this.variant,
    required this.state,
    required this.size,
    required this.icon,
    required this.destructive,
    required this.device,
    required this.label,
  });

  final SfButtonVariant variant;
  final SfButtonState state;
  final SfButtonSize size;
  final SfButtonIcon icon;
  final bool destructive;
  final AppPreviewDevice device;
  final String label;

  @override
  Widget build(BuildContext context) {
    final canBeDestructive =
        variant == SfButtonVariant.primary ||
        variant == SfButtonVariant.linkGrey;
    final effectiveDestructive = destructive && canBeDestructive;

    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MobileButtonMockup(
                device: device,
                child: _ButtonPreviewContent(
                  variant: variant,
                  state: state,
                  size: size,
                  icon: icon,
                  destructive: effectiveDestructive,
                  label: label,
                ),
              ),
              const SizedBox(height: AppSpacing.spacing8),
              _ButtonCodeSnippet(
                variant: variant,
                state: state,
                size: size,
                icon: icon,
                destructive: effectiveDestructive,
                label: label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonVariantsPage extends StatelessWidget {
  const ButtonVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: _MobileButtonMockup(
            device: AppPreviewDevice.iPhone14Pro,
            child: const _AllButtonStatesContent(),
          ),
        ),
      ),
    );
  }
}

class _AllButtonStatesContent extends StatelessWidget {
  const _AllButtonStatesContent();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.spacing5),
      children: [
        Text(
          'Buttons',
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
        const SizedBox(height: AppSpacing.spacing6),
        const _ButtonSection(
          title: 'Hierarchy',
          children: [
            SfButton(label: 'Primary', variant: SfButtonVariant.primary),
            SfButton(label: 'Secondary', variant: SfButtonVariant.secondary),
            SfButton(label: 'Link grey', variant: SfButtonVariant.linkGrey),
          ],
        ),
        const SizedBox(height: AppSpacing.spacing6),
        const _ButtonSection(
          title: 'Sizes',
          children: [
            SfButton(label: 'Small', size: SfButtonSize.small),
            SfButton(label: 'Medium', size: SfButtonSize.medium),
            SfButton(label: 'Large', size: SfButtonSize.large),
            SfButton(label: 'Xlarge', size: SfButtonSize.xlarge),
            SfButton(label: 'XXlarge', size: SfButtonSize.xxlarge),
          ],
        ),
        const SizedBox(height: AppSpacing.spacing6),
        const _ButtonSection(
          title: 'Icons',
          children: [
            SfButton(label: 'None', icon: SfButtonIcon.none),
            SfButton(label: 'Left icon', icon: SfButtonIcon.left),
            SfButton(label: 'Right icon', icon: SfButtonIcon.right),
            SfButton(label: 'Icon only', icon: SfButtonIcon.only),
          ],
        ),
        const SizedBox(height: AppSpacing.spacing6),
        const _ButtonSection(
          title: 'Disabled',
          children: [
            SfButton(
              label: 'Primary',
              variant: SfButtonVariant.primary,
              state: SfButtonState.disabled,
            ),
            SfButton(
              label: 'Secondary',
              variant: SfButtonVariant.secondary,
              state: SfButtonState.disabled,
            ),
            SfButton(
              label: 'Link grey',
              variant: SfButtonVariant.linkGrey,
              state: SfButtonState.disabled,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spacing6),
        const _ButtonSection(
          title: 'Destructive',
          children: [
            SfButton(
              label: 'Primary',
              variant: SfButtonVariant.primary,
              destructive: true,
            ),
            SfButton(
              label: 'Primary disabled',
              variant: SfButtonVariant.primary,
              state: SfButtonState.disabled,
              destructive: true,
            ),
            SfButton(
              label: 'Link grey',
              variant: SfButtonVariant.linkGrey,
              destructive: true,
            ),
            SfButton(
              label: 'Link disabled',
              variant: SfButtonVariant.linkGrey,
              state: SfButtonState.disabled,
              destructive: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title),
        const SizedBox(height: AppSpacing.spacing3),
        Wrap(
          spacing: AppSpacing.spacing3,
          runSpacing: AppSpacing.spacing3,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: children,
        ),
      ],
    );
  }
}

class _ButtonPreviewContent extends StatelessWidget {
  const _ButtonPreviewContent({
    required this.variant,
    required this.state,
    required this.size,
    required this.icon,
    required this.destructive,
    required this.label,
  });

  final SfButtonVariant variant;
  final SfButtonState state;
  final SfButtonSize size;
  final SfButtonIcon icon;
  final bool destructive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Button',
            style: AppTypeScaleToken.textXxl.style(AppTypeWeight.bold),
          ),
          const SizedBox(height: AppSpacing.spacing2),
          Text(
            '${variant.label} / ${state.label}',
            style: AppTypeScaleToken.textSm.style(
              AppTypeWeight.regular,
              color: AppColors.neutral600,
            ),
          ),
          const Spacer(),
          Center(
            child: SfButton(
              label: label,
              variant: variant,
              state: state,
              size: size,
              icon: icon,
              destructive: destructive,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _MobileButtonMockup extends StatelessWidget {
  const _MobileButtonMockup({required this.device, required this.child});

  final AppPreviewDevice device;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = device.info;

    return SizedBox(
      width: 390,
      height: 720,
      child: DeviceFrame(
        device: deviceInfo,
        screen: Material(
          color: AppColors.surface,
          child: Navigator(
            onGenerateRoute: (_) =>
                PageRouteBuilder(pageBuilder: (context, animation, _) => child),
          ),
        ),
      ),
    );
  }
}

class _ButtonCodeSnippet extends StatelessWidget {
  const _ButtonCodeSnippet({
    required this.variant,
    required this.state,
    required this.size,
    required this.icon,
    required this.destructive,
    required this.label,
  });

  final SfButtonVariant variant;
  final SfButtonState state;
  final SfButtonSize size;
  final SfButtonIcon icon;
  final bool destructive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.codeBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacing4),
          child: SelectableText(
            _sourceCode,
            style: const TextStyle(
              color: AppColors.neutral00,
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
      ),
    );
  }

  String get _sourceCode {
    final lines = [
      'SfButton(',
      "  label: '${label.replaceAll("'", r"\'")}',",
      '  variant: ${_variantCode(variant)},',
      '  size: ${_sizeCode(size)},',
      if (icon != SfButtonIcon.none) '  icon: ${_iconCode(icon)},',
      if (state == SfButtonState.disabled) '  state: SfButtonState.disabled,',
      if (destructive) '  destructive: true,',
      ')',
    ];

    return lines.join('\n');
  }

  String _variantCode(SfButtonVariant variant) {
    return switch (variant) {
      SfButtonVariant.primary => 'SfButtonVariant.primary',
      SfButtonVariant.secondary => 'SfButtonVariant.secondary',
      SfButtonVariant.linkGrey => 'SfButtonVariant.linkGrey',
    };
  }

  String _sizeCode(SfButtonSize size) {
    return switch (size) {
      SfButtonSize.small => 'SfButtonSize.small',
      SfButtonSize.medium => 'SfButtonSize.medium',
      SfButtonSize.large => 'SfButtonSize.large',
      SfButtonSize.xlarge => 'SfButtonSize.xlarge',
      SfButtonSize.xxlarge => 'SfButtonSize.xxlarge',
    };
  }

  String _iconCode(SfButtonIcon icon) {
    return switch (icon) {
      SfButtonIcon.none => 'SfButtonIcon.none',
      SfButtonIcon.left => 'SfButtonIcon.left',
      SfButtonIcon.right => 'SfButtonIcon.right',
      SfButtonIcon.only => 'SfButtonIcon.only',
    };
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypeScaleToken.textSm.style(
        AppTypeWeight.semibold,
        color: AppColors.neutral700,
      ),
    );
  }
}
