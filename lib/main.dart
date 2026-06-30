import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'atoms/checkbox/checkbox_preview.dart';
import 'atoms/checkbox/sf_checkbox.dart';
import 'atoms/radio_button/radio_button_preview.dart';
import 'atoms/sf_atom.dart';
import 'atoms/toggle/toggle_preview.dart';
import 'foundation/color_palette_preview.dart';
import 'foundation/shadow_scale_preview.dart';
import 'foundation/size_scale_preview.dart';
import 'foundation/type_scale_preview.dart';
import 'molecules/button/button_preview.dart';
import 'molecules/button/button_source_code.dart';
import 'molecules/button/button_source_code_knob.dart';
import 'molecules/button/sf_button.dart';
import 'molecules/cart_counter/cart_counter_preview.dart';
import 'molecules/countdown_timer/countdown_timer_preview.dart';
import 'molecules/toolbar/sf_toolbar.dart';
import 'molecules/toolbar/toolbar_preview.dart';
import 'preview/conditional_inspector_addon.dart';

void main() {
  runApp(const ComponentWorkbench());
}

class ComponentWorkbench extends StatelessWidget {
  const ComponentWorkbench({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ConditionalInspectorAddon(),
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
                      initialValue: 0,
                      min: 0,
                      max: 99,
                    );
                    final hours = context.knobs.int.slider(
                      label: 'Hours',
                      initialValue: 0,
                      min: 0,
                      max: 23,
                    );
                    final minutes = context.knobs.int.slider(
                      label: 'Minutes',
                      initialValue: 1,
                      min: 0,
                      max: 59,
                    );
                    final seconds = context.knobs.int.slider(
                      label: 'Seconds',
                      initialValue: 30,
                      min: 0,
                      max: 59,
                    );
                    final running = context.knobs.boolean(
                      label: 'Running',
                      initialValue: true,
                    );

                    return CountdownTimerPlaygroundPage(
                      key: ValueKey(
                        'days-$days-hours-$hours-min-$minutes-sec-$seconds-running-$running',
                      ),
                      days: days,
                      hours: hours,
                      minutes: minutes,
                      seconds: seconds,
                      running: running,
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
              name: 'Toolbar',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final variant = context.knobs.object.dropdown(
                      label: 'Variant',
                      options: SfToolbarVariant.values,
                      initialOption: SfToolbarVariant.homepage1,
                      labelBuilder: (value) => value.label,
                    );
                    final leftAction = context.knobs.object.dropdown(
                      label: 'Left action',
                      options: SfToolbarLeftActionKnob.values,
                      initialOption: SfToolbarLeftActionKnob.fromVariant,
                      labelBuilder: (value) => value.label,
                    );
                    final centerContent = context.knobs.object.dropdown(
                      label: 'Center content',
                      options: SfToolbarCenterContentKnob.values,
                      initialOption: SfToolbarCenterContentKnob.fromVariant,
                      labelBuilder: (value) => value.label,
                    );
                    final centerLabel = context.knobs.string(
                      label: 'Center label',
                      initialValue: 'LABEL',
                    );
                    final rightIconSlot1 = context.knobs.object.dropdown(
                      label: 'Right icon slot 1',
                      options: sfToolbarRightIconSlotOptions,
                      initialOption: SfToolbarRightAction.search,
                      labelBuilder: (value) => value.label,
                    );
                    final rightIconSlot2 = context.knobs.object.dropdown(
                      label: 'Right icon slot 2',
                      options: sfToolbarRightIconSlotOptions,
                      initialOption: SfToolbarRightAction.cartBadge,
                      labelBuilder: (value) => value.label,
                    );
                    final badgeCount = context.knobs.int.slider(
                      label: 'Badge count',
                      initialValue: 10,
                      min: 0,
                      max: 99,
                    );

                    return ToolbarPlaygroundPage(
                      key: ValueKey(
                        'variant-$variant-left-$leftAction-center-$centerContent-label-$centerLabel-slot1-$rightIconSlot1-slot2-$rightIconSlot2-badge-$badgeCount',
                      ),
                      variant: variant,
                      leftAction: leftAction,
                      centerContent: centerContent,
                      centerLabel: centerLabel,
                      rightIconSlot1: rightIconSlot1,
                      rightIconSlot2: rightIconSlot2,
                      badgeCount: badgeCount,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const ToolbarVariantsPage(),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Cart counter',
              useCases: [
                WidgetbookUseCase(
                  name: 'Playground',
                  builder: (context) {
                    final count = context.knobs.int.slider(
                      label: 'Count',
                      initialValue: 2,
                      min: 0,
                      max: 99,
                    );
                    final maxCount = context.knobs.int.slider(
                      label: 'Max count',
                      initialValue: 10,
                      min: 1,
                      max: 99,
                    );
                    final loading = context.knobs.boolean(
                      label: 'Loading',
                      initialValue: false,
                    );
                    final disabled = context.knobs.boolean(
                      label: 'Disabled',
                      initialValue: false,
                    );

                    return CartCounterPlaygroundPage(
                      key: ValueKey(
                        'count-$count-max-$maxCount-loading-$loading-disabled-$disabled',
                      ),
                      initialCount: count,
                      maxCount: maxCount,
                      loading: loading,
                      disabled: disabled,
                    );
                  },
                ),
                WidgetbookUseCase(
                  name: 'Variants',
                  builder: (context) => const CartCounterVariantsPage(),
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
              name: 'Size scale',
              useCases: [
                WidgetbookUseCase(
                  name: 'Size scale',
                  builder: (context) => const SizeScalePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
