import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'foundation/app_colors.dart';
import 'foundation/color_palette_preview.dart';
import 'foundation/type_scale_preview.dart';

void main() {
  runApp(const ComponentWorkbench());
}

class ComponentWorkbench extends StatelessWidget {
  const ComponentWorkbench({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Foundation',
          children: [
            WidgetbookComponent(
              name: 'Colors',
              useCases: [
                WidgetbookUseCase(
                  name: 'Palette',
                  builder: (context) => const ColorPalettePage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Typography',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) => TypeScalePlaygroundPage(
                    token: context.knobs.object.dropdown(
                      label: 'Type scale',
                      options: AppTypeScaleToken.values,
                      initialOption: AppTypeScaleToken.textXxl,
                      labelBuilder: (token) => token.label,
                    ),
                    weight: context.knobs.object.dropdown(
                      label: 'Weight',
                      options: AppTypeWeight.values,
                      initialOption: AppTypeWeight.regular,
                      labelBuilder: (weight) => weight.label,
                    ),
                    textColor: context.knobs.object.dropdown(
                      label: 'Text color',
                      options: AppTextColorToken.values,
                      initialOption: AppTextColorToken.neutral900,
                      labelBuilder: (color) => color.label,
                    ),
                    device: context.knobs.object.dropdown(
                      label: 'Device mockup',
                      options: AppPreviewDevice.values,
                      initialOption: AppPreviewDevice.iPhone14Pro,
                      labelBuilder: (device) => device.label,
                    ),
                    previewText: context.knobs.string(
                      label: 'Preview text',
                      initialValue: 'Your order is ready for pickup.',
                    ),
                    snippetFormat: context.knobs.object.dropdown(
                      label: 'Source snippet',
                      options: AppCodeSnippetFormat.values,
                      initialOption: AppCodeSnippetFormat.textWidget,
                      labelBuilder: (format) => format.label,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Type scale',
                  builder: (context) => const TypeScaleReferencePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
