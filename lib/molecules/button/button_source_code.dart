import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_spacing.dart';
import 'sf_button.dart';

abstract final class ButtonSourceCode {
  static String format({
    required SfButtonVariant variant,
    required SfButtonState state,
    required SfButtonSize size,
    required SfButtonIcon icon,
    required bool destructive,
    required String label,
  }) {
    final lines = [
      'SfButton(',
      "  label: '${label.replaceAll("'", r"\'")}',",
      if (variant != SfButtonVariant.primary)
        '  variant: ${_variantCode(variant)},',
      if (size != SfButtonSize.small) '  size: ${_sizeCode(size)},',
      if (icon != SfButtonIcon.none) '  icon: ${_iconCode(icon)},',
      if (state == SfButtonState.disabled) '  state: SfButtonState.disabled,',
      if (destructive) '  destructive: true,',
      ')',
    ];

    return lines.join('\n');
  }

  static String _variantCode(SfButtonVariant variant) {
    return switch (variant) {
      SfButtonVariant.primary => 'SfButtonVariant.primary',
      SfButtonVariant.secondary => 'SfButtonVariant.secondary',
      SfButtonVariant.linkGrey => 'SfButtonVariant.linkGrey',
    };
  }

  static String _sizeCode(SfButtonSize size) {
    return switch (size) {
      SfButtonSize.small => 'SfButtonSize.small',
      SfButtonSize.medium => 'SfButtonSize.medium',
      SfButtonSize.large => 'SfButtonSize.large',
      SfButtonSize.xlarge => 'SfButtonSize.xlarge',
      SfButtonSize.xxlarge => 'SfButtonSize.xxlarge',
    };
  }

  static String _iconCode(SfButtonIcon icon) {
    return switch (icon) {
      SfButtonIcon.none => 'SfButtonIcon.none',
      SfButtonIcon.left => 'SfButtonIcon.left',
      SfButtonIcon.right => 'SfButtonIcon.right',
      SfButtonIcon.only => 'SfButtonIcon.only',
    };
  }
}

class ButtonSourceCodePanel extends StatelessWidget {
  const ButtonSourceCodePanel({
    super.key,
    required this.sourceCode,
  });

  final String sourceCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.codeBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacing3),
            child: SelectableText(
              sourceCode,
              style: const TextStyle(
                color: AppColors.neutral00,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spacing3),
        FilledButton(
          onPressed: () => _copyCode(context),
          child: const Text('Copy code'),
        ),
      ],
    );
  }

  Future<void> _copyCode(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);

    await Clipboard.setData(ClipboardData(text: sourceCode));

    messenger?.clearSnackBars();
    messenger?.showSnackBar(
      const SnackBar(content: Text('Button code copied')),
    );
  }
}
