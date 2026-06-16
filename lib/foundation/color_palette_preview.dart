import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'type_scale_preview.dart';

class ColorPalettePage extends StatelessWidget {
  const ColorPalettePage({super.key});

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
                  'Colors',
                  style: AppTypeScaleToken.textXxl
                      .style(AppTypeWeight.bold)
                      .copyWith(fontSize: 32, height: 1.25),
                ),
                const SizedBox(height: 8),
                Text(
                  'Dashboard foundation palette grouped by role and scale.',
                  style: AppTypeScaleToken.textMd
                      .style(AppTypeWeight.regular)
                      .copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),
                for (final group in appColorGroups) ...[
                  _ColorGroupSection(group: group),
                  if (group != appColorGroups.last) const SizedBox(height: 32),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorGroupSection extends StatelessWidget {
  const _ColorGroupSection({required this.group});

  final AppColorGroup group;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              group.name,
              style: AppTypeScaleToken.textLg.style(AppTypeWeight.bold),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 960
                    ? 5
                    : constraints.maxWidth >= 720
                    ? 4
                    : constraints.maxWidth >= 480
                    ? 3
                    : 2;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.86,
                  ),
                  itemCount: group.tokens.length,
                  itemBuilder: (context, index) {
                    return _ColorTokenCard(token: group.tokens[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorTokenCard extends StatelessWidget {
  const _ColorTokenCard({required this.token});

  final AppColorToken token;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                color: token.value,
                border: Border(
                    bottom: BorderSide(
                      color: _needsStroke
                          ? AppColors.border
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    token.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypeScaleToken.textXs.style(
                      AppTypeWeight.semibold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    token.hex,
                    style: AppTypeScaleToken.textXs
                        .style(AppTypeWeight.regular)
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _needsStroke {
    return token.value == AppColors.surface ||
        token.value == AppColors.neutral00 ||
        token.value == AppColors.neutral25 ||
        token.value == AppColors.neutral50 ||
        token.value == AppColors.offWhite ||
        token.value == AppColors.brand25 ||
        token.value == AppColors.error25 ||
        token.value == AppColors.warning25 ||
        token.value == AppColors.success25;
  }
}
