import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_shadows.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

enum SfButtonVariant {
  primary('Primary'),
  secondary('Secondary'),
  linkGrey('Link grey');

  const SfButtonVariant(this.label);

  final String label;
}

enum SfButtonState {
  enabled('Default'),
  disabled('Disabled');

  const SfButtonState(this.label);

  final String label;
}

enum SfButtonSize {
  small('Small'),
  medium('Medium'),
  large('Large'),
  xlarge('Xlarge'),
  xxlarge('XXlarge');

  const SfButtonSize(this.label);

  final String label;
}

enum SfButtonIcon {
  none('None'),
  left('Left'),
  right('Right'),
  only('Only');

  const SfButtonIcon(this.label);

  final String label;
}

class SfButton extends StatelessWidget {
  const SfButton({
    super.key,
    required this.label,
    this.variant = SfButtonVariant.primary,
    this.state = SfButtonState.enabled,
    this.size = SfButtonSize.medium,
    this.icon = SfButtonIcon.none,
    this.destructive = false,
    this.onPressed,
  });

  final String label;
  final SfButtonVariant variant;
  final SfButtonState state;
  final SfButtonSize size;
  final SfButtonIcon icon;
  final bool destructive;
  final VoidCallback? onPressed;

  static const radius = 12.0;

  bool get _isDisabled => state == SfButtonState.disabled;
  bool get _isIconOnly => icon == SfButtonIcon.only;
  bool get _isDestructive =>
      destructive &&
      (variant == SfButtonVariant.primary ||
          variant == SfButtonVariant.linkGrey);

  @override
  Widget build(BuildContext context) {
    final colors = _SfButtonColors.resolve(
      variant: variant,
      destructive: _isDestructive,
      disabled: _isDisabled,
    );
    final isLink = variant == SfButtonVariant.linkGrey;
    final metrics = _SfButtonMetrics.resolve(size: size, isLink: isLink);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: _isIconOnly ? metrics.iconOnlySize : 0,
        minHeight: _isIconOnly ? metrics.iconOnlySize : 0,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: _isDisabled ? null : onPressed,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.background,
              border: Border.all(color: colors.border),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: colors.shadow,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isIconOnly
                    ? metrics.iconPadding
                    : metrics.paddingX,
                vertical: _isIconOnly ? metrics.iconPadding : metrics.paddingY,
              ),
              child: Center(
                widthFactor: 1,
                child: _ButtonContent(
                  label: label,
                  icon: icon,
                  metrics: metrics,
                  color: colors.text,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.label,
    required this.icon,
    required this.metrics,
    required this.color,
  });

  final String label;
  final SfButtonIcon icon;
  final _SfButtonMetrics metrics;
  final Color color;

  bool get _isIconOnly => icon == SfButtonIcon.only;

  @override
  Widget build(BuildContext context) {
    final iconWidget = PhosphorIcon(
      PhosphorIconsRegular.circle,
      color: color,
      size: 20,
    );

    if (_isIconOnly) {
      return iconWidget;
    }

    final labelWidget = Text(
      label,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: metrics.textStyle(color),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon == SfButtonIcon.left) ...[
          iconWidget,
          const SizedBox(width: AppSpacing.spacing2),
        ],
        labelWidget,
        if (icon == SfButtonIcon.right) ...[
          const SizedBox(width: AppSpacing.spacing2),
          iconWidget,
        ],
      ],
    );
  }
}

class _SfButtonMetrics {
  const _SfButtonMetrics({
    required this.paddingX,
    required this.paddingY,
    required this.iconPadding,
    required this.textStyle,
  });

  final double paddingX;
  final double paddingY;
  final double iconPadding;
  final TextStyle Function(Color color) textStyle;

  double get iconOnlySize => 20 + (iconPadding * 2);

  static _SfButtonMetrics resolve({
    required SfButtonSize size,
    required bool isLink,
  }) {
    if (isLink) {
      return _SfButtonMetrics(
        paddingX: 0,
        paddingY: 0,
        iconPadding: 0,
        textStyle: (color) => AppTypography.textSm.semibold(color: color),
      );
    }

    return switch (size) {
      SfButtonSize.small => _SfButtonMetrics(
        paddingX: 14,
        paddingY: AppSpacing.spacing2,
        iconPadding: AppSpacing.spacing2,
        textStyle: (color) => AppTypography.textSm.semibold(color: color),
      ),
      SfButtonSize.medium => _SfButtonMetrics(
        paddingX: AppSpacing.spacing4,
        paddingY: 10,
        iconPadding: 10,
        textStyle: (color) => AppTypography.textSm.semibold(color: color),
      ),
      SfButtonSize.large => _SfButtonMetrics(
        paddingX: 18,
        paddingY: 10,
        iconPadding: 10,
        textStyle: (color) => AppTypography.textMd.semibold(color: color),
      ),
      SfButtonSize.xlarge => _SfButtonMetrics(
        paddingX: AppSpacing.spacing5,
        paddingY: AppSpacing.spacing3,
        iconPadding: 10,
        textStyle: (color) => AppTypography.textMd.semibold(color: color),
      ),
      SfButtonSize.xxlarge => _SfButtonMetrics(
        paddingX: AppSpacing.spacing6,
        paddingY: 14,
        iconPadding: 14,
        textStyle: (color) => AppTypography.textMd.semibold(color: color),
      ),
    };
  }
}

class _SfButtonColors {
  const _SfButtonColors({
    required this.background,
    required this.border,
    required this.text,
    required this.shadow,
  });

  final Color background;
  final Color border;
  final Color text;
  final List<BoxShadow> shadow;

  static _SfButtonColors resolve({
    required SfButtonVariant variant,
    required bool destructive,
    required bool disabled,
  }) {
    return switch (variant) {
      SfButtonVariant.primary => _primary(
        destructive: destructive,
        disabled: disabled,
      ),
      SfButtonVariant.secondary => _secondary(disabled: disabled),
      SfButtonVariant.linkGrey => _linkGrey(
        destructive: destructive,
        disabled: disabled,
      ),
    };
  }

  static _SfButtonColors _primary({
    required bool destructive,
    required bool disabled,
  }) {
    if (destructive) {
      return _SfButtonColors(
        background: disabled ? AppColors.error300 : AppColors.error600,
        border: disabled ? AppColors.error300 : AppColors.error600,
        text: AppColors.neutral00,
        shadow: disabled ? const [] : AppShadows.xs,
      );
    }

    return _SfButtonColors(
      background: disabled ? AppColors.brand200 : AppColors.brand400,
      border: disabled ? AppColors.brand200 : AppColors.brand400,
      text: AppColors.neutral00,
      shadow: disabled ? const [] : AppShadows.xs,
    );
  }

  static _SfButtonColors _secondary({required bool disabled}) {
    return _SfButtonColors(
      background: Colors.transparent,
      border: disabled ? AppColors.neutral200 : AppColors.neutral300,
      text: disabled ? AppColors.neutral300 : AppColors.neutral700,
      shadow: const [],
    );
  }

  static _SfButtonColors _linkGrey({
    required bool destructive,
    required bool disabled,
  }) {
    if (destructive) {
      return _SfButtonColors(
        background: Colors.transparent,
        border: Colors.transparent,
        text: disabled ? AppColors.error300 : AppColors.error600,
        shadow: const [],
      );
    }

    return _SfButtonColors(
      background: Colors.transparent,
      border: Colors.transparent,
      text: disabled ? AppColors.neutral300 : AppColors.neutral600,
      shadow: const [],
    );
  }
}
