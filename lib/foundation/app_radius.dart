import 'app_spacing.dart';

class AppRadiusToken {
  const AppRadiusToken({
    required this.name,
    required this.codeName,
    required this.value,
  });

  final String name;
  final String codeName;
  final double value;

  String get px =>
      '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}px';
}

abstract final class AppRadius {
  static const radius1 = AppSpacing.spacing1;
  static const radius2 = AppSpacing.spacing2;
  static const radius3 = AppSpacing.spacing3;
  static const radius4 = AppSpacing.spacing4;
  static const radius5 = AppSpacing.spacing5;
  static const radius6 = AppSpacing.spacing6;
  static const radius8 = AppSpacing.spacing8;
  static const radius10 = AppSpacing.spacing10;
  static const radius12 = AppSpacing.spacing12;
  static const radius16 = AppSpacing.spacing16;
  static const radius20 = AppSpacing.spacing20;
  static const radius24 = AppSpacing.spacing24;
  static const radius32 = AppSpacing.spacing32;
  static const radius64 = AppSpacing.spacing64;
}

const appRadiusTokens = [
  AppRadiusToken(
    name: '1',
    codeName: 'AppRadius.radius1',
    value: AppRadius.radius1,
  ),
  AppRadiusToken(
    name: '2',
    codeName: 'AppRadius.radius2',
    value: AppRadius.radius2,
  ),
  AppRadiusToken(
    name: '3',
    codeName: 'AppRadius.radius3',
    value: AppRadius.radius3,
  ),
  AppRadiusToken(
    name: '4',
    codeName: 'AppRadius.radius4',
    value: AppRadius.radius4,
  ),
  AppRadiusToken(
    name: '5',
    codeName: 'AppRadius.radius5',
    value: AppRadius.radius5,
  ),
  AppRadiusToken(
    name: '6',
    codeName: 'AppRadius.radius6',
    value: AppRadius.radius6,
  ),
  AppRadiusToken(
    name: '8',
    codeName: 'AppRadius.radius8',
    value: AppRadius.radius8,
  ),
  AppRadiusToken(
    name: '10',
    codeName: 'AppRadius.radius10',
    value: AppRadius.radius10,
  ),
  AppRadiusToken(
    name: '12',
    codeName: 'AppRadius.radius12',
    value: AppRadius.radius12,
  ),
  AppRadiusToken(
    name: '16',
    codeName: 'AppRadius.radius16',
    value: AppRadius.radius16,
  ),
  AppRadiusToken(
    name: '20',
    codeName: 'AppRadius.radius20',
    value: AppRadius.radius20,
  ),
  AppRadiusToken(
    name: '24',
    codeName: 'AppRadius.radius24',
    value: AppRadius.radius24,
  ),
  AppRadiusToken(
    name: '32',
    codeName: 'AppRadius.radius32',
    value: AppRadius.radius32,
  ),
  AppRadiusToken(
    name: '64',
    codeName: 'AppRadius.radius64',
    value: AppRadius.radius64,
  ),
];
