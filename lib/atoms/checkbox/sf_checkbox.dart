import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../sf_atom.dart';

enum SfCheckBoxValue {
  unchecked,
  checked,
  indeterminate,
}

class SfCheckBox extends StatelessWidget {
  const SfCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = SfAtomSize.small,
    this.state = SfAtomState.enabled,
  });

  final SfCheckBoxValue value;
  final ValueChanged<SfCheckBoxValue>? onChanged;
  final SfAtomSize size;
  final SfAtomState state;

  bool get _isDisabled => state.isDisabled || onChanged == null;
  bool get _isActive => value != SfCheckBoxValue.unchecked;

  @override
  Widget build(BuildContext context) {
    final colors = _SfCheckBoxColors.resolve(
      active: _isActive,
      disabled: _isDisabled,
    );
    final metrics = _SfCheckBoxMetrics.resolve(size: size);

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      checked: value == SfCheckBoxValue.checked,
      mixed: value == SfCheckBoxValue.indeterminate,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.radius1),
          onTap: _isDisabled ? null : _handleTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.ease,
            width: metrics.boxSize,
            height: metrics.boxSize,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(AppRadius.radius1),
              border: Border.all(color: colors.border),
            ),
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                curve: Curves.ease,
                opacity: _isActive ? 1 : 0,
                child: PhosphorIcon(
                  value == SfCheckBoxValue.indeterminate
                      ? PhosphorIconsRegular.minus
                      : PhosphorIconsRegular.check,
                  color: AppColors.neutral00,
                  size: metrics.iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    final nextValue = switch (value) {
      SfCheckBoxValue.indeterminate => SfCheckBoxValue.checked,
      SfCheckBoxValue.checked => SfCheckBoxValue.unchecked,
      SfCheckBoxValue.unchecked => SfCheckBoxValue.checked,
    };
    onChanged?.call(nextValue);
  }
}

class _SfCheckBoxMetrics {
  const _SfCheckBoxMetrics({
    required this.boxSize,
    required this.iconSize,
  });

  final double boxSize;
  final double iconSize;

  static _SfCheckBoxMetrics resolve({required SfAtomSize size}) {
    return switch (size) {
      SfAtomSize.small => const _SfCheckBoxMetrics(boxSize: 16, iconSize: 12),
      SfAtomSize.medium => const _SfCheckBoxMetrics(boxSize: 20, iconSize: 14),
    };
  }
}

class _SfCheckBoxColors {
  const _SfCheckBoxColors({
    required this.background,
    required this.border,
  });

  final Color background;
  final Color border;

  static _SfCheckBoxColors resolve({
    required bool active,
    required bool disabled,
  }) {
    if (disabled) {
      return _SfCheckBoxColors(
        background: active ? AppColors.brand100 : AppColors.neutral50,
        border: active ? AppColors.brand100 : AppColors.neutral200,
      );
    }

    return _SfCheckBoxColors(
      background: active ? AppColors.brand400 : AppColors.neutral00,
      border: active ? AppColors.brand400 : AppColors.neutral300,
    );
  }
}
