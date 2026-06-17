import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_shadows.dart';
import '../sf_atom.dart';

class SfToggle extends StatelessWidget {
  const SfToggle({
    super.key,
    required this.value,
    this.onChanged,
    this.size = SfAtomSize.small,
    this.state = SfAtomState.enabled,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final SfAtomSize size;
  final SfAtomState state;

  bool get _isDisabled => state.isDisabled || onChanged == null;

  @override
  Widget build(BuildContext context) {
    final colors = _SfToggleColors.resolve(
      value: value,
      disabled: _isDisabled,
    );
    final metrics = _SfToggleMetrics.resolve(size: size);

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      checked: value,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(metrics.trackHeight / 2),
          ),
          onTap: _isDisabled ? null : () => onChanged?.call(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.ease,
            width: metrics.trackWidth,
            height: metrics.trackHeight,
            padding: EdgeInsets.all(metrics.padding),
            decoration: BoxDecoration(
              color: colors.track,
              borderRadius: BorderRadius.circular(metrics.trackHeight / 2),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 160),
              curve: Curves.ease,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: metrics.thumbSize,
                height: metrics.thumbSize,
                decoration: BoxDecoration(
                  color: AppColors.neutral00,
                  shape: BoxShape.circle,
                  boxShadow: _isDisabled ? AppShadows.xs : AppShadows.sm,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SfToggleMetrics {
  const _SfToggleMetrics({
    required this.trackWidth,
    required this.trackHeight,
    required this.thumbSize,
    required this.padding,
  });

  final double trackWidth;
  final double trackHeight;
  final double thumbSize;
  final double padding;

  static _SfToggleMetrics resolve({required SfAtomSize size}) {
    return switch (size) {
      SfAtomSize.small => const _SfToggleMetrics(
        trackWidth: 36,
        trackHeight: 20,
        thumbSize: 16,
        padding: 2,
      ),
      SfAtomSize.medium => const _SfToggleMetrics(
        trackWidth: 44,
        trackHeight: 24,
        thumbSize: 20,
        padding: 2,
      ),
    };
  }
}

class _SfToggleColors {
  const _SfToggleColors({required this.track});

  final Color track;

  static _SfToggleColors resolve({
    required bool value,
    required bool disabled,
  }) {
    if (disabled) {
      return _SfToggleColors(
        track: value ? AppColors.brand100 : AppColors.neutral50,
      );
    }

    return _SfToggleColors(
      track: value ? AppColors.brand400 : AppColors.neutral100,
    );
  }
}
