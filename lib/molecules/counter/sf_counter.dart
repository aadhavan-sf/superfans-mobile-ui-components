import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

enum SfCounterState {
  enabled('Default'),
  disabled('Disabled'),
  loading('Loading');

  const SfCounterState(this.label);

  final String label;

  bool get isDisabled => this == SfCounterState.disabled;
  bool get isLoading => this == SfCounterState.loading;
}

enum _SfCounterLeftAction {
  disabledMinus,
  delete,
  minus,
}

class SfCounter extends StatelessWidget {
  const SfCounter({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 99,
    this.state = SfCounterState.enabled,
    this.onChanged,
    this.onDelete,
  });

  final int value;
  final int min;
  final int max;
  final SfCounterState state;
  final ValueChanged<int>? onChanged;
  final VoidCallback? onDelete;

  static const width = 106.0;
  static const height = 32.0;
  static const borderRadius = 8.0;
  static const _actionWidth = 32.0;
  static const _valueWidth = 40.0;
  static const _iconSize = 16.0;
  static const _dividerInset = 4.0;

  bool get _isInteractive =>
      !state.isDisabled && !state.isLoading && onChanged != null;

  bool get _canIncrement => _isInteractive && value < max;

  _SfCounterLeftAction get _leftAction {
    if (state.isDisabled || state.isLoading) {
      return _SfCounterLeftAction.disabledMinus;
    }
    if (value <= min) {
      return _SfCounterLeftAction.disabledMinus;
    }
    if (value == 1) {
      return _SfCounterLeftAction.delete;
    }
    return _SfCounterLeftAction.minus;
  }

  bool get _canDecrement =>
      _isInteractive && _leftAction != _SfCounterLeftAction.disabledMinus;

  @override
  Widget build(BuildContext context) {
    final colors = _SfCounterColors.resolve(state: state);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: colors.background,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: colors.border),
        ),
        child: state.isLoading
            ? Center(child: _CounterLoader(color: colors.icon))
            : Row(
                children: [
                  _CounterActionSegment(
                    width: _actionWidth,
                    highlighted: !_canDecrement && !state.isDisabled,
                    colors: colors,
                    onTap: _canDecrement ? _handleDecrement : null,
                    child: _leftIcon(colors),
                  ),
                  _CounterDivider(color: colors.divider),
                  _CounterValue(
                    width: _valueWidth,
                    value: value,
                    colors: colors,
                  ),
                  _CounterDivider(color: colors.divider),
                  _CounterActionSegment(
                    width: _actionWidth,
                    highlighted: !_canIncrement && !state.isDisabled,
                    colors: colors,
                    onTap: _canIncrement
                        ? () => onChanged?.call(value + 1)
                        : null,
                    child: PhosphorIcon(
                      PhosphorIconsRegular.plus,
                      size: _iconSize,
                      color: _canIncrement
                          ? colors.icon
                          : colors.iconDisabled,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _leftIcon(_SfCounterColors colors) {
    return switch (_leftAction) {
      _SfCounterLeftAction.disabledMinus => PhosphorIcon(
        PhosphorIconsRegular.minus,
        size: _iconSize,
        color: colors.iconDisabled,
      ),
      _SfCounterLeftAction.delete => PhosphorIcon(
        PhosphorIconsRegular.trash,
        size: _iconSize,
        color: colors.icon,
      ),
      _SfCounterLeftAction.minus => PhosphorIcon(
        PhosphorIconsRegular.minus,
        size: _iconSize,
        color: colors.icon,
      ),
    };
  }

  void _handleDecrement() {
    if (value == 1) {
      if (onDelete != null) {
        onDelete!();
      } else {
        onChanged?.call(min);
      }
      return;
    }

    onChanged?.call(value - 1);
  }
}

class _CounterActionSegment extends StatelessWidget {
  const _CounterActionSegment({
    required this.width,
    required this.highlighted,
    required this.colors,
    required this.child,
    this.onTap,
  });

  final double width;
  final bool highlighted;
  final _SfCounterColors colors;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        color: highlighted ? colors.actionMutedBackground : colors.background,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.neutral100.withValues(alpha: 0.4),
          highlightColor: AppColors.neutral100.withValues(alpha: 0.2),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _CounterValue extends StatelessWidget {
  const _CounterValue({
    required this.width,
    required this.value,
    required this.colors,
  });

  final double width;
  final int value;
  final _SfCounterColors colors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: colors.valueBackground,
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            '$value',
            style: AppTypography.textSm.regular(color: colors.value),
          ),
        ),
      ),
    );
  }
}

class _CounterDivider extends StatelessWidget {
  const _CounterDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SfCounter._dividerInset,
      ),
      child: Container(width: 1, color: color),
    );
  }
}

class _CounterLoader extends StatefulWidget {
  const _CounterLoader({required this.color});

  final Color color;

  @override
  State<_CounterLoader> createState() => _CounterLoaderState();
}

class _CounterLoaderState extends State<_CounterLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CustomPaint(
        size: const Size(AppSpacing.spacing4, AppSpacing.spacing4),
        painter: _DashedRadialSpinnerPainter(color: widget.color),
      ),
    );
  }
}

class _DashedRadialSpinnerPainter extends CustomPainter {
  const _DashedRadialSpinnerPainter({required this.color});

  final Color color;

  static const _dashCount = 8;
  static const _dashWidth = 1.5;
  static const _dashHeight = 3.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - _dashHeight / 2;

    for (var index = 0; index < _dashCount; index++) {
      final angle = (index / _dashCount) * 2 * math.pi;
      final dx = center.dx + radius * math.cos(angle);
      final dy = center.dy + radius * math.sin(angle);
      final dashCenter = Offset(dx, dy);

      canvas.save();
      canvas.translate(dashCenter.dx, dashCenter.dy);
      canvas.rotate(angle + math.pi / 2);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: _dashWidth,
            height: _dashHeight,
          ),
          const Radius.circular(1),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRadialSpinnerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _SfCounterColors {
  const _SfCounterColors({
    required this.background,
    required this.actionMutedBackground,
    required this.valueBackground,
    required this.border,
    required this.divider,
    required this.value,
    required this.icon,
    required this.iconDisabled,
  });

  final Color background;
  final Color actionMutedBackground;
  final Color valueBackground;
  final Color border;
  final Color divider;
  final Color value;
  final Color icon;
  final Color iconDisabled;

  static _SfCounterColors resolve({required SfCounterState state}) {
    if (state.isDisabled) {
      return const _SfCounterColors(
        background: AppColors.neutral00,
        actionMutedBackground: AppColors.neutral50,
        valueBackground: AppColors.neutral50,
        border: AppColors.neutral200,
        divider: AppColors.neutral200,
        value: AppColors.neutral400,
        icon: AppColors.neutral300,
        iconDisabled: AppColors.neutral300,
      );
    }

    return const _SfCounterColors(
      background: AppColors.neutral00,
      actionMutedBackground: AppColors.neutral50,
      valueBackground: AppColors.neutral50,
      border: AppColors.neutral300,
      divider: AppColors.neutral300,
      value: AppColors.neutral800,
      icon: AppColors.neutral800,
      iconDisabled: AppColors.neutral400,
    );
  }
}
