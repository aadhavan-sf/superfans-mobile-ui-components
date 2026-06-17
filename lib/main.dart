import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'atoms/checkbox/checkbox_preview.dart';
import 'atoms/checkbox/sf_checkbox.dart';
import 'atoms/radio_button/radio_button_preview.dart';
import 'atoms/sf_atom.dart';
import 'atoms/toggle/toggle_preview.dart';
import 'foundation/color_palette_preview.dart';
import 'foundation/shadow_scale_preview.dart';
import 'foundation/spacing_scale_preview.dart';
import 'foundation/type_scale_preview.dart';
import 'molecules/button/button_preview.dart';
import 'molecules/button/button_source_code.dart';
import 'molecules/button/button_source_code_knob.dart';
import 'molecules/button/sf_button.dart';
import 'molecules/countdown_timer/countdown_timer_preview.dart';
import 'molecules/counter/counter_preview.dart';
import 'molecules/counter/sf_counter.dart';

void main() {
  runApp(const ComponentWorkbench());
}

class ComponentWorkbench extends StatelessWidget {
  const ComponentWorkbench({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        InspectorAddon(),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Atoms',
          children: [
            WidgetbookComponent(
              name: 'Toggle',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final state = context.knobs.object.dropdown(
                      label: 'State',
                      options: SfAtomState.values,
                      initialOption: SfAtomState.enabled,
                      labelBuilder: (state) => state.label,
                    );
                    final size = context.knobs.object.dropdown(
                      label: 'Size',
                      options: SfAtomSize.values,
                      initialOption: SfAtomSize.small,
                      labelBuilder: (size) => size.label,
                    );
                    final pressed = context.knobs.boolean(
                      label: 'Pressed',
                      initialValue: false,
                    );

                    return TogglePlaygroundPage(
                      state: state,
                      size: size,
                      pressed: pressed,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const ToggleVariantsPage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Radio button',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final state = context.knobs.object.dropdown(
                      label: 'State',
                      options: SfAtomState.values,
                      initialOption: SfAtomState.enabled,
                      labelBuilder: (state) => state.label,
                    );
                    final size = context.knobs.object.dropdown(
                      label: 'Size',
                      options: SfAtomSize.values,
                      initialOption: SfAtomSize.small,
                      labelBuilder: (size) => size.label,
                    );
                    final selected = context.knobs.boolean(
                      label: 'Selected',
                      initialValue: false,
                    );

                    return RadioButtonPlaygroundPage(
                      state: state,
                      size: size,
                      selected: selected,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const RadioButtonVariantsPage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Check box',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final state = context.knobs.object.dropdown(
                      label: 'State',
                      options: SfAtomState.values,
                      initialOption: SfAtomState.enabled,
                      labelBuilder: (state) => state.label,
                    );
                    final size = context.knobs.object.dropdown(
                      label: 'Size',
                      options: SfAtomSize.values,
                      initialOption: SfAtomSize.small,
                      labelBuilder: (size) => size.label,
                    );
                    final value = context.knobs.object.dropdown(
                      label: 'Value',
                      options: SfCheckBoxValue.values,
                      initialOption: SfCheckBoxValue.unchecked,
                      labelBuilder: (value) => switch (value) {
                        SfCheckBoxValue.unchecked => 'Off',
                        SfCheckBoxValue.checked => 'On',
                        SfCheckBoxValue.indeterminate => 'Indeterminate',
                      },
                    );

                    return CheckBoxPlaygroundPage(
                      state: state,
                      size: size,
                      value: value,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const CheckBoxVariantsPage(),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Molecules',
          children: [
            WidgetbookComponent(
              name: 'Buttons',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final variant = context.knobs.object.dropdown(
                      label: 'Variant',
                      options: SfButtonVariant.values,
                      initialOption: SfButtonVariant.primary,
                      labelBuilder: (variant) => variant.label,
                    );
                    final state = context.knobs.object.dropdown(
                      label: 'State',
                      options: SfButtonState.values,
                      initialOption: SfButtonState.enabled,
                      labelBuilder: (state) => state.label,
                    );
                    final size = context.knobs.object.dropdown(
                      label: 'Size',
                      options: SfButtonSize.values,
                      initialOption: SfButtonSize.small,
                      labelBuilder: (size) => size.label,
                    );
                    final icon = context.knobs.object.dropdown(
                      label: 'Icon',
                      options: SfButtonIcon.values,
                      initialOption: SfButtonIcon.none,
                      labelBuilder: (icon) => icon.label,
                    );
                    final destructive = context.knobs.boolean(
                      label: 'Destructive',
                      initialValue: false,
                    );
                    final label = context.knobs.string(
                      label: 'Label',
                      initialValue: 'Button CTA',
                    );
                    final canBeDestructive =
                        variant == SfButtonVariant.primary ||
                        variant == SfButtonVariant.linkGrey;
                    final effectiveDestructive =
                        destructive && canBeDestructive;

                    context.knobs.buttonSourceCode(
                      sourceCode: ButtonSourceCode.format(
                        variant: variant,
                        state: state,
                        size: size,
                        icon: icon,
                        destructive: effectiveDestructive,
                        label: label,
                      ),
                    );

                    return ButtonPlaygroundPage(
                      variant: variant,
                      state: state,
                      size: size,
                      icon: icon,
                      destructive: effectiveDestructive,
                      label: label,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const ButtonVariantsPage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Countdown timer',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final days = context.knobs.int.slider(
                      label: 'Days',
                      initialValue: 2,
                      min: 0,
                      max: 30,
                    );
                    final hours = context.knobs.int.slider(
                      label: 'Hours',
                      initialValue: 10,
                      min: 0,
                      max: 23,
                    );
                    final minutes = context.knobs.int.slider(
                      label: 'Minutes',
                      initialValue: 45,
                      min: 0,
                      max: 59,
                    );
                    final seconds = context.knobs.int.slider(
                      label: 'Seconds',
                      initialValue: 5,
                      min: 0,
                      max: 59,
                    );
                    final showDays = context.knobs.boolean(
                      label: 'Show days',
                      initialValue: true,
                    );

                    return CountdownTimerPlaygroundPage(
                      days: days,
                      hours: hours,
                      minutes: minutes,
                      seconds: seconds,
                      showDays: showDays,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const CountdownTimerVariantsPage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Counter',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final min = context.knobs.int.slider(
                      label: 'Min',
                      initialValue: 0,
                      min: 0,
                      max: 10,
                    );
                    final max = context.knobs.int.slider(
                      label: 'Max',
                      initialValue: 10,
                      min: 1,
                      max: 99,
                    );
                    final value = context.knobs.int.slider(
                      label: 'Value',
                      initialValue: 2,
                      min: 0,
                      max: 99,
                    );
                    final state = context.knobs.object.dropdown(
                      label: 'State',
                      options: SfCounterState.values,
                      initialOption: SfCounterState.enabled,
                      labelBuilder: (state) => state.label,
                    );

                    final clampedMax = max < min + 1 ? min + 1 : max;

                    return CounterPlaygroundPage(
                      initialValue: value.clamp(min, clampedMax),
                      min: min,
                      max: clampedMax,
                      state: state,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const CounterVariantsPage(),
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
