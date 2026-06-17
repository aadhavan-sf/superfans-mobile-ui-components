import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../sf_atom.dart';

class SfRadioButton extends StatelessWidget {
  const SfRadioButton({
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
    final colors = _SfRadioButtonColors.resolve(
      selected: value,
      disabled: _isDisabled,
    );
    final metrics = _SfRadioButtonMetrics.resolve(size: size);

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      checked: value,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: _isDisabled ? null : () => onChanged?.call(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.ease,
            width: metrics.outerSize,
            height: metrics.outerSize,
            decoration: BoxDecoration(
              color: colors.background,
              shape: BoxShape.circle,
              border: Border.all(color: colors.border),
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.ease,
                width: value ? metrics.dotSize : 0,
                height: value ? metrics.dotSize : 0,
                decoration: BoxDecoration(
                  color: colors.dot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SfRadioButtonMetrics {
  const _SfRadioButtonMetrics({
    required this.outerSize,
    required this.dotSize,
  });

  final double outerSize;
  final double dotSize;

  static _SfRadioButtonMetrics resolve({required SfAtomSize size}) {
    return switch (size) {
      SfAtomSize.small => const _SfRadioButtonMetrics(
        outerSize: 16,
        dotSize: 6,
      ),
      SfAtomSize.medium => const _SfRadioButtonMetrics(
        outerSize: 20,
        dotSize: 8,
      ),
    };
  }
}

class _SfRadioButtonColors {
  const _SfRadioButtonColors({
    required this.background,
    required this.border,
    required this.dot,
  });

  final Color background;
  final Color border;
  final Color dot;

  static _SfRadioButtonColors resolve({
    required bool selected,
    required bool disabled,
  }) {
    if (disabled) {
      return _SfRadioButtonColors(
        background: selected ? AppColors.brand25 : AppColors.neutral50,
        border: selected ? AppColors.brand100 : AppColors.neutral200,
        dot: AppColors.brand100,
      );
    }

    return _SfRadioButtonColors(
      background: selected ? AppColors.brand50 : AppColors.neutral00,
      border: selected ? AppColors.brand400 : AppColors.neutral300,
      dot: AppColors.brand400,
    );
  }
}
