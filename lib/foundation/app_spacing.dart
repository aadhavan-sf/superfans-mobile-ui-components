class AppSpacingToken {
  const AppSpacingToken({
    required this.name,
    required this.cssVariable,
    required this.codeName,
    required this.value,
  });

  final String name;
  final String cssVariable;
  final String codeName;
  final double value;

  String get px => '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}px';
}

abstract final class AppSpacing {
  static const zero = 0.0;
  static const spacing1 = 4.0;
  static const spacing2 = 8.0;
  static const spacing3 = 12.0;
  static const spacing4 = 16.0;
  static const spacing5 = 20.0;
  static const spacing6 = 24.0;
  static const spacing8 = 32.0;
  static const spacing10 = 40.0;
  static const spacing12 = 48.0;
  static const spacing16 = 64.0;
  static const spacing20 = 80.0;
  static const spacing24 = 96.0;
  static const spacing32 = 128.0;
  static const spacing64 = 256.0;
}

const appSpacingTokens = [
  AppSpacingToken(
    name: '0',
    cssVariable: '--spacing_0',
    codeName: 'AppSpacing.zero',
    value: AppSpacing.zero,
  ),
  AppSpacingToken(
    name: '1',
    cssVariable: '--spacing_1',
    codeName: 'AppSpacing.spacing1',
    value: AppSpacing.spacing1,
  ),
  AppSpacingToken(
    name: '2',
    cssVariable: '--spacing_2',
    codeName: 'AppSpacing.spacing2',
    value: AppSpacing.spacing2,
  ),
  AppSpacingToken(
    name: '3',
    cssVariable: '--spacing_3',
    codeName: 'AppSpacing.spacing3',
    value: AppSpacing.spacing3,
  ),
  AppSpacingToken(
    name: '4',
    cssVariable: '--spacing_4',
    codeName: 'AppSpacing.spacing4',
    value: AppSpacing.spacing4,
  ),
  AppSpacingToken(
    name: '5',
    cssVariable: '--spacing_5',
    codeName: 'AppSpacing.spacing5',
    value: AppSpacing.spacing5,
  ),
  AppSpacingToken(
    name: '6',
    cssVariable: '--spacing_6',
    codeName: 'AppSpacing.spacing6',
    value: AppSpacing.spacing6,
  ),
  AppSpacingToken(
    name: '8',
    cssVariable: '--spacing_8',
    codeName: 'AppSpacing.spacing8',
    value: AppSpacing.spacing8,
  ),
  AppSpacingToken(
    name: '10',
    cssVariable: '--spacing_10',
    codeName: 'AppSpacing.spacing10',
    value: AppSpacing.spacing10,
  ),
  AppSpacingToken(
    name: '12',
    cssVariable: '--spacing_12',
    codeName: 'AppSpacing.spacing12',
    value: AppSpacing.spacing12,
  ),
  AppSpacingToken(
    name: '16',
    cssVariable: '--spacing_16',
    codeName: 'AppSpacing.spacing16',
    value: AppSpacing.spacing16,
  ),
  AppSpacingToken(
    name: '20',
    cssVariable: '--spacing_20',
    codeName: 'AppSpacing.spacing20',
    value: AppSpacing.spacing20,
  ),
  AppSpacingToken(
    name: '24',
    cssVariable: '--spacing_24',
    codeName: 'AppSpacing.spacing24',
    value: AppSpacing.spacing24,
  ),
  AppSpacingToken(
    name: '32',
    cssVariable: '--spacing_32',
    codeName: 'AppSpacing.spacing32',
    value: AppSpacing.spacing32,
  ),
  AppSpacingToken(
    name: '64',
    cssVariable: '--spacing_64',
    codeName: 'AppSpacing.spacing64',
    value: AppSpacing.spacing64,
  ),
];
