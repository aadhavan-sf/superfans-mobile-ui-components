import 'package:flutter/material.dart';

abstract final class AppColors {
  static const neutral25 = Color(0xFFF6F6F7);
  static const neutral50 = Color(0xFFEFEFF0);
  static const neutral100 = Color(0xFFE2E3E4);
  static const neutral200 = Color(0xFFCFD0D3);
  static const neutral300 = Color(0xFFBABBC0);
  static const neutral400 = Color(0xFF9D9EA6);
  static const neutral500 = Color(0xFF92939B);
  static const neutral600 = Color(0xFF7E7F86);
  static const neutral700 = Color(0xFF66666E);
  static const neutral800 = Color(0xFF55565A);
  static const neutral900 = Color(0xFF323234);

  static const brand25 = Color(0xFFF7F4FE);
  static const brand50 = Color(0xFFEFEBFC);
  static const brand100 = Color(0xFFE1D9FB);
  static const brand200 = Color(0xFFCBBAF8);
  static const brand300 = Color(0xFFB193F2);
  static const brand400 = Color(0xFF915EE9);
  static const brand500 = Color(0xFF8948DF);
  static const brand600 = Color(0xFF7935CC);
  static const brand700 = Color(0xFF662CAB);
  static const brand800 = Color(0xFF54268C);
  static const brand900 = Color(0xFF35165F);

  static const error25 = Color(0xFFFFF2F2);
  static const error50 = Color(0xFFFFE3E6);
  static const error100 = Color(0xFFFFCECB);
  static const error200 = Color(0xFFFFA2B0);
  static const error300 = Color(0xFFFF6C87);
  static const error400 = Color(0xFFFB3A61);
  static const error500 = Color(0xFFE9194E);
  static const error600 = Color(0xFFC40D3F);
  static const error700 = Color(0xFFA40D3C);
  static const error800 = Color(0xFF8C1039);
  static const error900 = Color(0xFF4E031A);

  static const warning25 = Color(0xFFFFF9ED);
  static const warning50 = Color(0xFFFFF3D5);
  static const warning100 = Color(0xFFFEE2AA);
  static const warning200 = Color(0xFFFDCC74);
  static const warning300 = Color(0xFFFBB451);
  static const warning400 = Color(0xFFF89117);
  static const warning500 = Color(0xFFE9750D);
  static const warning600 = Color(0xFFC2590C);
  static const warning700 = Color(0xFF9A4612);
  static const warning800 = Color(0xFF7C3B12);
  static const warning900 = Color(0xFF431C07);

  static const success25 = Color(0xFFEDFCF4);
  static const success50 = Color(0xFFD2F9E2);
  static const success100 = Color(0xFFAAF0CA);
  static const success200 = Color(0xFF72E3AD);
  static const success300 = Color(0xFF39CD8B);
  static const success400 = Color(0xFF16B372);
  static const success500 = Color(0xFF0A915C);
  static const success600 = Color(0xFF08744C);
  static const success700 = Color(0xFF095C3E);
  static const success800 = Color(0xFF094B35);
  static const success900 = Color(0xFF042A1E);

  static const lightening = Color(0xFFEEE0FE);

  static const canvas = neutral25;
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = neutral50;
  static const textPrimary = neutral900;
  static const textSecondary = neutral600;
  static const textInverse = Color(0xFFFFFFFF);
  static const border = neutral200;
  static const codeBackground = neutral900;
}

class AppColorToken {
  const AppColorToken({required this.name, required this.value});

  final String name;
  final Color value;

  String get hex {
    final argb = value.toARGB32();
    final rgb = argb & 0x00FFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

class AppColorGroup {
  const AppColorGroup({required this.name, required this.tokens});

  final String name;
  final List<AppColorToken> tokens;
}

enum AppTextColorToken {
  neutral900('neutral_900', 'AppColors.neutral900', AppColors.neutral900),
  neutral700('neutral_700', 'AppColors.neutral700', AppColors.neutral700),
  neutral600('neutral_600', 'AppColors.neutral600', AppColors.neutral600),
  brand700('Brand 700', 'AppColors.brand700', AppColors.brand700),
  error700('Error 700', 'AppColors.error700', AppColors.error700),
  warning700('Warning 700', 'AppColors.warning700', AppColors.warning700),
  success700('Success 700', 'AppColors.success700', AppColors.success700);

  const AppTextColorToken(this.label, this.code, this.value);

  final String label;
  final String code;
  final Color value;

  String get hex {
    final argb = value.toARGB32();
    final rgb = argb & 0x00FFFFFF;
    return '#${rgb.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

const appColorGroups = [
  AppColorGroup(
    name: 'Neutral',
    tokens: [
      AppColorToken(name: 'neutral_25', value: AppColors.neutral25),
      AppColorToken(name: 'neutral_50', value: AppColors.neutral50),
      AppColorToken(name: 'neutral_100', value: AppColors.neutral100),
      AppColorToken(name: 'neutral_200', value: AppColors.neutral200),
      AppColorToken(name: 'neutral_300', value: AppColors.neutral300),
      AppColorToken(name: 'neutral_400', value: AppColors.neutral400),
      AppColorToken(name: 'neutral_500', value: AppColors.neutral500),
      AppColorToken(name: 'neutral_600', value: AppColors.neutral600),
      AppColorToken(name: 'neutral_700', value: AppColors.neutral700),
      AppColorToken(name: 'neutral_800', value: AppColors.neutral800),
      AppColorToken(name: 'neutral_900', value: AppColors.neutral900),
    ],
  ),
  AppColorGroup(
    name: 'Brand',
    tokens: [
      AppColorToken(name: 'brand_25', value: AppColors.brand25),
      AppColorToken(name: 'brand_50', value: AppColors.brand50),
      AppColorToken(name: 'brand_100', value: AppColors.brand100),
      AppColorToken(name: 'brand_200', value: AppColors.brand200),
      AppColorToken(name: 'brand_300', value: AppColors.brand300),
      AppColorToken(name: 'brand_400', value: AppColors.brand400),
      AppColorToken(name: 'brand_500', value: AppColors.brand500),
      AppColorToken(name: 'brand_600', value: AppColors.brand600),
      AppColorToken(name: 'brand_700', value: AppColors.brand700),
      AppColorToken(name: 'brand_800', value: AppColors.brand800),
      AppColorToken(name: 'brand_900', value: AppColors.brand900),
    ],
  ),
  AppColorGroup(
    name: 'Error',
    tokens: [
      AppColorToken(name: 'error_25', value: AppColors.error25),
      AppColorToken(name: 'error_50', value: AppColors.error50),
      AppColorToken(name: 'error_100', value: AppColors.error100),
      AppColorToken(name: 'error_200', value: AppColors.error200),
      AppColorToken(name: 'error_300', value: AppColors.error300),
      AppColorToken(name: 'error_400', value: AppColors.error400),
      AppColorToken(name: 'error_500', value: AppColors.error500),
      AppColorToken(name: 'error_600', value: AppColors.error600),
      AppColorToken(name: 'error_700', value: AppColors.error700),
      AppColorToken(name: 'error_800', value: AppColors.error800),
      AppColorToken(name: 'error_900', value: AppColors.error900),
    ],
  ),
  AppColorGroup(
    name: 'Warning',
    tokens: [
      AppColorToken(name: 'warning_25', value: AppColors.warning25),
      AppColorToken(name: 'warning_50', value: AppColors.warning50),
      AppColorToken(name: 'warning_100', value: AppColors.warning100),
      AppColorToken(name: 'warning_200', value: AppColors.warning200),
      AppColorToken(name: 'warning_300', value: AppColors.warning300),
      AppColorToken(name: 'warning_400', value: AppColors.warning400),
      AppColorToken(name: 'warning_500', value: AppColors.warning500),
      AppColorToken(name: 'warning_600', value: AppColors.warning600),
      AppColorToken(name: 'warning_700', value: AppColors.warning700),
      AppColorToken(name: 'warning_800', value: AppColors.warning800),
      AppColorToken(name: 'warning_900', value: AppColors.warning900),
    ],
  ),
  AppColorGroup(
    name: 'Success',
    tokens: [
      AppColorToken(name: 'success_25', value: AppColors.success25),
      AppColorToken(name: 'success_50', value: AppColors.success50),
      AppColorToken(name: 'success_100', value: AppColors.success100),
      AppColorToken(name: 'success_200', value: AppColors.success200),
      AppColorToken(name: 'success_300', value: AppColors.success300),
      AppColorToken(name: 'success_400', value: AppColors.success400),
      AppColorToken(name: 'success_500', value: AppColors.success500),
      AppColorToken(name: 'success_600', value: AppColors.success600),
      AppColorToken(name: 'success_700', value: AppColors.success700),
      AppColorToken(name: 'success_800', value: AppColors.success800),
      AppColorToken(name: 'success_900', value: AppColors.success900),
    ],
  ),
  AppColorGroup(
    name: 'Special',
    tokens: [AppColorToken(name: 'lightening', value: AppColors.lightening)],
  ),
];
