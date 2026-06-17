import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

enum AppTypeScaleToken {
  textXxl(AppTypography.textXxl),
  textXl(AppTypography.textXl),
  textLg(AppTypography.textLg),
  textMd(AppTypography.textMd),
  textSm(AppTypography.textSm),
  textXs(AppTypography.textXs);

  const AppTypeScaleToken(this.typography);

  final AppTypographyToken typography;

  String get codeName => typography.codeName;
  String get label => typography.label;
  double get fontSize => typography.fontSize;
  double get lineHeight => typography.lineHeight;
  String get remSize => typography.remSize;

  TextStyle style(AppTypeWeight weight, {Color color = AppColors.textPrimary}) {
    return switch (weight) {
      AppTypeWeight.regular => typography.regular(color: color),
      AppTypeWeight.semibold => typography.semibold(color: color),
      AppTypeWeight.bold => typography.bold(color: color),
    };
  }
}

enum AppTypeWeight {
  regular('Regular', FontWeight.w400),
  semibold('Semibold', FontWeight.w600),
  bold('Bold', FontWeight.w700);

  const AppTypeWeight(this.label, this.fontWeight);

  final String label;
  final FontWeight fontWeight;

  String get methodName {
    return switch (this) {
      AppTypeWeight.regular => 'regular',
      AppTypeWeight.semibold => 'semibold',
      AppTypeWeight.bold => 'bold',
    };
  }
}

enum AppPreviewDevice {
  iPhone13('iPhone 13'),
  iPhone13ProMax('iPhone 13 Pro Max'),
  iPhone14Pro('iPhone 14 Pro'),
  samsungGalaxyS20('Samsung Galaxy S20'),
  samsungGalaxyNote20Ultra('Samsung Galaxy Note20 Ultra'),
  pixel4('Pixel 4'),
  onePlus8Pro('OnePlus 8 Pro');

  const AppPreviewDevice(this.label);

  final String label;

  DeviceInfo get info {
    return switch (this) {
      AppPreviewDevice.iPhone13 => Devices.ios.iPhone13,
      AppPreviewDevice.iPhone13ProMax => Devices.ios.iPhone13ProMax,
      AppPreviewDevice.iPhone14Pro => Devices.ios.iPhone14Pro,
      AppPreviewDevice.samsungGalaxyS20 => Devices.android.samsungGalaxyS20,
      AppPreviewDevice.samsungGalaxyNote20Ultra =>
        Devices.android.samsungGalaxyNote20Ultra,
      AppPreviewDevice.pixel4 => Devices.android.pixel4,
      AppPreviewDevice.onePlus8Pro => Devices.android.onePlus8Pro,
    };
  }
}

class TypeScaleReferencePage extends StatelessWidget {
  const TypeScaleReferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.canvas,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Type scale',
                  style: AppTypeScaleToken.textXxl
                      .style(AppTypeWeight.bold)
                      .copyWith(fontSize: 32, height: 1.25),
                ),
                const SizedBox(height: 8),
                Text(
                  'Figma scale mapped for Regular, Semibold, and Bold.',
                  style: AppTypeScaleToken.textMd
                      .style(AppTypeWeight.regular)
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),
                for (final token in AppTypeScaleToken.values) ...[
                  _TypeScaleRow(token: token),
                  if (token != AppTypeScaleToken.values.last)
                    const SizedBox(height: 32),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeScaleRow extends StatelessWidget {
  const _TypeScaleRow({required this.token});

  final AppTypeScaleToken token;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 8,
              spacing: 16,
              children: [
                Text(token.label, style: _metadataStyle),
                Text(
                  'Font size: ${token.fontSize.toStringAsFixed(0)}px / '
                  '${token.remSize} | Line height: '
                  '${token.lineHeight.toStringAsFixed(0)}px',
                  style: _metadataStyle,
                ),
              ],
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 720;
                final samples = AppTypeWeight.values
                    .map(
                      (weight) => _WeightSample(token: token, weight: weight),
                    )
                    .toList();

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final sample in samples) ...[
                        sample,
                        if (sample != samples.last) const SizedBox(height: 20),
                      ],
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final sample in samples)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: sample,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WeightSample extends StatelessWidget {
  const _WeightSample({required this.token, required this.weight});

  final AppTypeScaleToken token;
  final AppTypeWeight weight;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: token.style(weight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(token.label),
          SizedBox(height: token.fontSize.clamp(12, 20)),
          Text(weight.label),
        ],
      ),
    );
  }
}

const _metadataStyle = TextStyle(
  color: AppColors.textSecondary,
  fontFamily: 'Figtree',
  fontSize: 16,
  fontWeight: FontWeight.w400,
  height: 1.5,
  letterSpacing: 0,
);
