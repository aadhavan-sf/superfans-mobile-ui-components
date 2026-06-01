import 'dart:convert';

import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

enum AppCodeSnippetFormat {
  textWidget('Text widget'),
  textStyle('TextStyle only');

  const AppCodeSnippetFormat(this.label);

  final String label;
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

class TypeScalePlaygroundPage extends StatelessWidget {
  const TypeScalePlaygroundPage({
    super.key,
    required this.token,
    required this.weight,
    required this.textColor,
    required this.device,
    required this.previewText,
    required this.snippetFormat,
  });

  final AppTypeScaleToken token;
  final AppTypeWeight weight;
  final AppTextColorToken textColor;
  final AppPreviewDevice device;
  final String previewText;
  final AppCodeSnippetFormat snippetFormat;

  @override
  Widget build(BuildContext context) {
    final sourceCode = _TypographySnippet(
      token: token,
      weight: weight,
      textColor: textColor,
      previewText: previewText,
      format: snippetFormat,
    ).sourceCode;

    return ColoredBox(
      color: AppColors.canvas,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MobileDeviceMockup(
                  device: device,
                  child: _MobilePreviewContent(
                    token: token,
                    weight: weight,
                    textColor: textColor,
                    previewText: previewText,
                  ),
                ),
                const SizedBox(height: 40),
                _SourceCodePanel(
                  token: token,
                  weight: weight,
                  textColor: textColor,
                  sourceCode: sourceCode,
                ),
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

class _MobileDeviceMockup extends StatelessWidget {
  const _MobileDeviceMockup({required this.device, required this.child});

  final AppPreviewDevice device;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final deviceInfo = device.info;

    return SizedBox(
      width: 390,
      height: 720,
      child: DeviceFrame(
        device: deviceInfo,
        screen: Material(
          color: AppColors.surface,
          child: Navigator(
            onGenerateRoute: (_) =>
                PageRouteBuilder(pageBuilder: (context, animation, _) => child),
          ),
        ),
      ),
    );
  }
}

class _SourceCodePanel extends StatelessWidget {
  const _SourceCodePanel({
    required this.token,
    required this.weight,
    required this.textColor,
    required this.sourceCode,
  });

  final AppTypeScaleToken token;
  final AppTypeWeight weight;
  final AppTextColorToken textColor;
  final String sourceCode;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Text(
              'Flutter source code',
              style: AppTypeScaleToken.textMd.style(AppTypeWeight.bold),
            ),
            subtitle: Text(
              '${token.label} / ${weight.label} / ${textColor.label} ${textColor.hex}',
              style: AppTypeScaleToken.textSm
                  .style(AppTypeWeight.regular)
                  .copyWith(color: AppColors.textSecondary),
            ),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => _copySource(context),
                  child: const Text('Copy code'),
                ),
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.codeBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SelectableText(
                      sourceCode,
                      style: const TextStyle(
                        color: AppColors.textInverse,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copySource(BuildContext context) async {
    final messenger = ScaffoldMessenger.maybeOf(context);

    await Clipboard.setData(ClipboardData(text: sourceCode));

    messenger?.clearSnackBars();
    messenger?.showSnackBar(
      const SnackBar(content: Text('Typography snippet copied')),
    );
  }
}

class _MobilePreviewContent extends StatelessWidget {
  const _MobilePreviewContent({
    required this.token,
    required this.weight,
    required this.textColor,
    required this.previewText,
  });

  final AppTypeScaleToken token;
  final AppTypeWeight weight;
  final AppTextColorToken textColor;
  final String previewText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                previewText.trim().isEmpty ? 'Preview text' : previewText,
                style: token.style(weight, color: textColor.value),
              ),
              const SizedBox(height: 20),
              Text(
                '${token.label} / ${weight.label} / ${textColor.label}',
                style: AppTypeScaleToken.textSm
                    .style(AppTypeWeight.regular)
                    .copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'Size ${token.fontSize.toStringAsFixed(0)}px · '
                  'Line ${token.lineHeight.toStringAsFixed(0)}px · '
                  'Color ${textColor.code}',
                  style: AppTypeScaleToken.textXs
                      .style(AppTypeWeight.regular)
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypographySnippet {
  const _TypographySnippet({
    required this.token,
    required this.weight,
    required this.textColor,
    required this.previewText,
    required this.format,
  });

  final AppTypeScaleToken token;
  final AppTypeWeight weight;
  final AppTextColorToken textColor;
  final String previewText;
  final AppCodeSnippetFormat format;

  String get sourceCode {
    final style = _styleSnippet;

    if (format == AppCodeSnippetFormat.textStyle) {
      return style;
    }

    return '''
Text(
  ${jsonEncode(previewText.trim().isEmpty ? 'Preview text' : previewText)},
  style: $style,
)''';
  }

  String get _styleSnippet {
    return 'AppTypography.${token.codeName}.${weight.methodName}(color: ${textColor.code})';
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
