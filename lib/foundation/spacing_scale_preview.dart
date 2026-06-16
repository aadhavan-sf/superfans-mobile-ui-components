import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shadows.dart';
import 'app_spacing.dart';
import 'type_scale_preview.dart';

class SpacingScalePage extends StatelessWidget {
  const SpacingScalePage({super.key});

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Spacing',
                            style: AppTypeScaleToken.textSm
                                .style(AppTypeWeight.semibold)
                                .copyWith(color: AppColors.brand600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '4px-based layout scale',
                            style: AppTypeScaleToken.textXxl
                                .style(AppTypeWeight.semibold)
                                .copyWith(fontSize: 32, height: 1.25),
                          ),
                        ],
                      ),
                    ),
                    _CodeLabel('AppSpacing.*'),
                  ],
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 720;

                    return GridView.count(
                      crossAxisCount: isWide ? 2 : 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isWide ? 2.6 : 2.2,
                      children: const [
                        _SpacingExampleCard(
                          gap: AppSpacing.spacing2,
                          padding: AppSpacing.spacing3,
                          labels: ['gap 2', 'padding 3', 'space 4'],
                        ),
                        _SpacingExampleCard(
                          gap: AppSpacing.spacing4,
                          padding: AppSpacing.spacing6,
                          labels: ['gap 4', 'padding 6', 'space 8'],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final token in appSpacingTokens) ...[
                      _SpacingRow(token: token),
                      if (token != appSpacingTokens.last)
                        const SizedBox(height: 8),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpacingExampleCard extends StatelessWidget {
  const _SpacingExampleCard({
    required this.gap,
    required this.padding,
    required this.labels,
  });

  final double gap;
  final double padding;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final label in labels)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: AppShadows.xs,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Text(
                    label,
                    style: AppTypeScaleToken.textSm.style(
                      AppTypeWeight.regular,
                      color: AppColors.neutral700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow({required this.token});

  final AppSpacingToken token;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 620;
            final label = _SpacingLabel(token: token);
            final bar = _SpacingBar(token: token);
            final value = Text(
              token.px,
              textAlign: isNarrow ? TextAlign.left : TextAlign.right,
              style: AppTypeScaleToken.textSm
                  .style(AppTypeWeight.regular)
                  .copyWith(color: AppColors.neutral500),
            );

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  label,
                  const SizedBox(height: 8),
                  bar,
                  const SizedBox(height: 8),
                  value,
                ],
              );
            }

            return Row(
              children: [
                SizedBox(width: 220, child: label),
                Expanded(child: bar),
                const SizedBox(width: 16),
                SizedBox(width: 64, child: value),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SpacingLabel extends StatelessWidget {
  const _SpacingLabel({required this.token});

  final AppSpacingToken token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          token.name,
          style: AppTypeScaleToken.textMd.style(AppTypeWeight.semibold),
        ),
        const SizedBox(height: 4),
        _CodeLabel(token.cssVariable),
      ],
    );
  }
}

class _SpacingBar extends StatelessWidget {
  const _SpacingBar({required this.token});

  final AppSpacingToken token;

  @override
  Widget build(BuildContext context) {
    final width = token.value == 0 ? 1.0 : token.value;

    return SizedBox(
      height: 24,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: width,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.brand500,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _CodeLabel extends StatelessWidget {
  const _CodeLabel(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          value,
          style: const TextStyle(
            color: AppColors.neutral700,
            fontFamily: 'monospace',
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
