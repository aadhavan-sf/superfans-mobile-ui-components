import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'foundation/app_colors.dart';
import 'foundation/color_palette_preview.dart';
import 'foundation/shadow_scale_preview.dart';
import 'foundation/spacing_scale_preview.dart';
import 'foundation/type_scale_preview.dart';
import 'molecules/button/button_preview.dart';
import 'molecules/button/sf_button.dart';

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
          name: 'Molecules',
          children: [
            WidgetbookComponent(
              name: 'Buttons',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) => ButtonPlaygroundPage(
                    variant: context.knobs.object.dropdown(
                      label: 'Variant',
                      options: SfButtonVariant.values,
                      initialOption: SfButtonVariant.primary,
                      labelBuilder: (variant) => variant.label,
                    ),
                    state: context.knobs.object.dropdown(
                      label: 'State',
                      options: SfButtonState.values,
                      initialOption: SfButtonState.enabled,
                      labelBuilder: (state) => state.label,
                    ),
                    size: context.knobs.object.dropdown(
                      label: 'Size',
                      options: SfButtonSize.values,
                      initialOption: SfButtonSize.medium,
                      labelBuilder: (size) => size.label,
                    ),
                    icon: context.knobs.object.dropdown(
                      label: 'Icon',
                      options: SfButtonIcon.values,
                      initialOption: SfButtonIcon.none,
                      labelBuilder: (icon) => icon.label,
                    ),
                    destructive: context.knobs.boolean(
                      label: 'Destructive',
                      initialValue: false,
                    ),
                    device: context.knobs.object.dropdown(
                      label: 'Device mockup',
                      options: AppPreviewDevice.values,
                      initialOption: AppPreviewDevice.iPhone14Pro,
                      labelBuilder: (device) => device.label,
                    ),
                    label: context.knobs.string(
                      label: 'Label',
                      initialValue: 'Button CTA',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const ButtonVariantsPage(),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Foundation',
          isInitiallyExpanded: false,
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
            WidgetbookComponent(
              name: 'Shadows',
              useCases: [
                WidgetbookUseCase(
                  name: 'Elevation scale',
                  builder: (context) => const ShadowScalePage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Spacing',
              useCases: [
                WidgetbookUseCase(
                  name: 'Scale',
                  builder: (context) => const SpacingScalePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
