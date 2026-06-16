import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_shadows.dart';
import 'type_scale_preview.dart';

class ShadowScalePage extends StatelessWidget {
  const ShadowScalePage({super.key});

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
                            'Shadow',
                            style: AppTypeScaleToken.textSm
                                .style(AppTypeWeight.semibold)
                                .copyWith(color: AppColors.brand600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Elevation scale',
                            style: AppTypeScaleToken.textXxl
                                .style(AppTypeWeight.semibold)
                                .copyWith(fontSize: 32, height: 1.25),
                          ),
                        ],
                      ),
                    ),
                    _CodeLabel('AppShadows.*'),
                  ],
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = constraints.maxWidth >= 900
                        ? 3
                        : constraints.maxWidth >= 600
                        ? 2
                        : 1;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: appShadowTokens.length,
                      itemBuilder: (context, index) {
                        return _ShadowTokenCard(
                          token: appShadowTokens[index],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShadowTokenCard extends StatelessWidget {
  const _ShadowTokenCard({required this.token});

  final AppShadowToken token;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: token.shadows,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              token.name,
              style: AppTypeScaleToken.textLg.style(AppTypeWeight.semibold),
            ),
            const SizedBox(height: 8),
            _CodeLabel(token.codeName),
            const SizedBox(height: 8),
            Text(
              token.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypeScaleToken.textXs
                  .style(AppTypeWeight.regular)
                  .copyWith(color: AppColors.neutral500),
            ),
          ],
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
