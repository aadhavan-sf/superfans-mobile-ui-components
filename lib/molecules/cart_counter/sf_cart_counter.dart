import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

/// Mobile cart quantity counter — Flutter port of Dashboard
/// `src/components/mobile-ui/CartCounter/CartCounter.tsx`.
enum SfCartCounterDisplayState {
  min('Min'),
  single('Single'),
  defaultState('Default'),
  max('Max'),
  loading('Loading'),
  disabled('Disabled');

  const SfCartCounterDisplayState(this.label);

  final String label;
}

enum _SfCartCounterLeftAction { minus, trash }

class SfCartCounter extends StatelessWidget {
  const SfCartCounter({
    super.key,
    this.count = 0,
    this.displayState,
    this.loading = false,
    this.disabled = false,
    this.maxCount,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
  });

  final int count;
  final SfCartCounterDisplayState? displayState;
  final bool loading;
  final bool disabled;
  final int? maxCount;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  /// Component width — not on the size scale.
  static const width = 106.0;

  static const height = AppSpacing.spacing8;
  static const borderRadius = AppRadius.radius2;
  static const _iconSize = AppSpacing.spacing4;

  /// 1px border — not on the size scale.
  static const _borderWidth = 1.0;

  static RoundedRectangleBorder get _shellShape => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    side: const BorderSide(
      color: AppColors.neutral200,
      width: _borderWidth,
    ),
  );

  _ResolvedCartCounter _resolve() {
    if (displayState == SfCartCounterDisplayState.loading) {
      return _ResolvedCartCounter(
        count: count,
        disabled: false,
        loading: true,
        maxCount: maxCount,
      );
    }

    if (displayState == SfCartCounterDisplayState.disabled) {
      return _ResolvedCartCounter(
        count: 0,
        disabled: true,
        loading: false,
        maxCount: maxCount,
      );
    }

    switch (displayState) {
      case SfCartCounterDisplayState.min:
        return _ResolvedCartCounter(
          count: 0,
          disabled: false,
          loading: false,
          maxCount: maxCount,
        );
      case SfCartCounterDisplayState.single:
        return _ResolvedCartCounter(
          count: 1,
          disabled: false,
          loading: false,
          maxCount: maxCount,
        );
      case SfCartCounterDisplayState.defaultState:
        return _ResolvedCartCounter(
          count: 2,
          disabled: false,
          loading: false,
          maxCount: maxCount,
        );
      case SfCartCounterDisplayState.max:
        return _ResolvedCartCounter(
          count: 10,
          disabled: false,
          loading: false,
          maxCount: maxCount ?? 10,
        );
      case SfCartCounterDisplayState.loading:
      case SfCartCounterDisplayState.disabled:
      case null:
        break;
    }

    return _ResolvedCartCounter(
      count: count,
      disabled: disabled,
      loading: loading,
      maxCount: maxCount,
    );
  }

  _SfCartCounterLeftAction _leftAction(_ResolvedCartCounter resolved) {
    if (resolved.count == 1) {
      return _SfCartCounterLeftAction.trash;
    }
    if (resolved.maxCount != null && resolved.count >= resolved.maxCount!) {
      return _SfCartCounterLeftAction.trash;
    }
    return _SfCartCounterLeftAction.minus;
  }

  Color _contentColor(_ResolvedCartCounter resolved) {
    return resolved.disabled ? AppColors.neutral300 : AppColors.neutral700;
  }

  @override
  Widget build(BuildContext context) {
    final resolved = _resolve();
    final contentColor = _contentColor(resolved);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: AppColors.neutral00,
        shape: _shellShape,
        clipBehavior: Clip.none,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: resolved.loading
              ? _buildLoading(contentColor)
              : _buildControls(
                  resolved: resolved,
                  contentColor: contentColor,
                ),
        ),
      ),
    );
  }

  Widget _buildLoading(Color contentColor) {
    return ColoredBox(
      color: AppColors.neutral00,
      child: Center(
        child: _PhosphorSpinner(color: contentColor),
      ),
    );
  }

  Widget _buildControls({
    required _ResolvedCartCounter resolved,
    required Color contentColor,
  }) {
    final leftAction = _leftAction(resolved);
    final isMinusDisabled = resolved.disabled || resolved.count <= 0;
    final leftDisabled =
        resolved.disabled ||
        (leftAction == _SfCartCounterLeftAction.minus && isMinusDisabled);
    final leftCallback = leftAction == _SfCartCounterLeftAction.trash
        ? (onRemove ?? onDecrement)
        : onDecrement;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _CartCounterSegmentButton(
            enabled: !leftDisabled && leftCallback != null,
            onTap: leftCallback,
            child: leftAction == _SfCartCounterLeftAction.trash
                ? PhosphorIcon(
                    PhosphorIconsRegular.trash,
                    size: _iconSize,
                    color: contentColor,
                  )
                : PhosphorIcon(
                    PhosphorIconsRegular.minus,
                    size: _iconSize,
                    color: contentColor,
                  ),
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: AppColors.neutral200,
                  width: _borderWidth,
                ),
              ),
            ),
            child: Center(
              child: Text(
                '${resolved.count}',
                style: AppTypography.textSm
                    .regular(color: contentColor)
                    .copyWith(
                      fontWeight: FontWeight.w500,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
              ),
            ),
          ),
        ),
        Expanded(
          child: _CartCounterSegmentButton(
            enabled: !resolved.disabled && onIncrement != null,
            onTap: onIncrement,
            child: PhosphorIcon(
              PhosphorIconsRegular.plus,
              size: _iconSize,
              color: contentColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _ResolvedCartCounter {
  const _ResolvedCartCounter({
    required this.count,
    required this.disabled,
    required this.loading,
    required this.maxCount,
  });

  final int count;
  final bool disabled;
  final bool loading;
  final int? maxCount;
}

/// Matches Dashboard segment buttons: transparent background, no hover styles.
class _CartCounterSegmentButton extends StatelessWidget {
  const _CartCounterSegmentButton({
    required this.enabled,
    required this.child,
    this.onTap,
  });

  final bool enabled;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: enabled,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: enabled ? onTap : null,
          hoverColor: Colors.transparent,
          splashColor: AppColors.neutral100.withValues(alpha: 0.35),
          highlightColor: Colors.transparent,
          child: SizedBox.expand(
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

/// Matches Dashboard `<Spinner size={16} weight="regular" className="animate-spin" />`.
class _PhosphorSpinner extends StatefulWidget {
  const _PhosphorSpinner({required this.color});

  final Color color;

  @override
  State<_PhosphorSpinner> createState() => _PhosphorSpinnerState();
}

class _PhosphorSpinnerState extends State<_PhosphorSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
      child: PhosphorIcon(
        PhosphorIconsRegular.spinner,
        size: SfCartCounter._iconSize,
        color: widget.color,
      ),
    );
  }
}
