import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static const textXxl = AppTypographyToken(
    codeName: 'textXxl',
    label: 'Text xxl',
    fontSize: 24,
    lineHeight: 28,
  );
  static const textXl = AppTypographyToken(
    codeName: 'textXl',
    label: 'Text xl',
    fontSize: 20,
    lineHeight: 30,
  );
  static const textLg = AppTypographyToken(
    codeName: 'textLg',
    label: 'Text lg',
    fontSize: 18,
    lineHeight: 28,
  );
  static const textMd = AppTypographyToken(
    codeName: 'textMd',
    label: 'Text md',
    fontSize: 16,
    lineHeight: 24,
  );
  static const textSm = AppTypographyToken(
    codeName: 'textSm',
    label: 'Text sm',
    fontSize: 14,
    lineHeight: 20,
  );
  static const textXs = AppTypographyToken(
    codeName: 'textXs',
    label: 'Text xs',
    fontSize: 12,
    lineHeight: 18,
  );
}

class AppTypographyToken {
  const AppTypographyToken({
    required this.codeName,
    required this.label,
    required this.fontSize,
    required this.lineHeight,
  });

  final String codeName;
  final String label;
  final double fontSize;
  final double lineHeight;

  String get remSize => '${(fontSize / 16).toStringAsFixed(3)}rem';

  TextStyle regular({Color color = AppColors.textPrimary}) {
    return _style(FontWeight.w400, color);
  }

  TextStyle semibold({Color color = AppColors.textPrimary}) {
    return _style(FontWeight.w600, color);
  }

  TextStyle bold({Color color = AppColors.textPrimary}) {
    return _style(FontWeight.w700, color);
  }

  TextStyle _style(FontWeight fontWeight, Color color) {
    return TextStyle(
      color: color,
      fontFamily: 'Figtree',
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: 0,
    );
  }
}
