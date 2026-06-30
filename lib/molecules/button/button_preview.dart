import 'package:flutter/material.dart';

import '../../preview/molecule_preview.dart';
import 'sf_button.dart';

class ButtonPlaygroundPage extends StatelessWidget {
  const ButtonPlaygroundPage({
    super.key,
    required this.variant,
    required this.state,
    required this.size,
    required this.icon,
    required this.destructive,
    required this.label,
  });

  final SfButtonVariant variant;
  final SfButtonState state;
  final SfButtonSize size;
  final SfButtonIcon icon;
  final bool destructive;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MoleculePlaygroundScaffold(
      title: 'Button',
      subtitle: '${variant.label} / ${state.label}',
      child: SfButton(
        label: label,
        variant: variant,
        state: state,
        size: size,
        icon: icon,
        destructive: destructive,
      ),
    );
  }
}

class ButtonVariantsPage extends StatelessWidget {
  const ButtonVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoleculeVariantsScaffold(
      title: 'Buttons',
      sections: [
        MoleculeSection(
          title: 'Hierarchy',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SfButton(label: 'Primary', variant: SfButtonVariant.primary),
              SfButton(label: 'Secondary', variant: SfButtonVariant.secondary),
              SfButton(label: 'Link grey', variant: SfButtonVariant.linkGrey),
            ],
          ),
        ),
        MoleculeSection(
          title: 'Sizes',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SfButton(label: 'Small', size: SfButtonSize.small),
              SfButton(label: 'Medium', size: SfButtonSize.medium),
              SfButton(label: 'Large', size: SfButtonSize.large),
              SfButton(label: 'Xlarge', size: SfButtonSize.xlarge),
              SfButton(label: 'XXlarge', size: SfButtonSize.xxlarge),
            ],
          ),
        ),
        MoleculeSection(
          title: 'Icons',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SfButton(label: 'None', icon: SfButtonIcon.none),
              SfButton(label: 'Left icon', icon: SfButtonIcon.left),
              SfButton(label: 'Right icon', icon: SfButtonIcon.right),
              SfButton(label: 'Icon only', icon: SfButtonIcon.only),
            ],
          ),
        ),
        MoleculeSection(
          title: 'Disabled',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SfButton(
                label: 'Primary',
                variant: SfButtonVariant.primary,
                state: SfButtonState.disabled,
              ),
              SfButton(
                label: 'Secondary',
                variant: SfButtonVariant.secondary,
                state: SfButtonState.disabled,
              ),
              SfButton(
                label: 'Link grey',
                variant: SfButtonVariant.linkGrey,
                state: SfButtonState.disabled,
              ),
            ],
          ),
        ),
        MoleculeSection(
          title: 'Destructive',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SfButton(
                label: 'Primary',
                variant: SfButtonVariant.primary,
                destructive: true,
              ),
              SfButton(
                label: 'Primary disabled',
                variant: SfButtonVariant.primary,
                state: SfButtonState.disabled,
                destructive: true,
              ),
              SfButton(
                label: 'Link grey',
                variant: SfButtonVariant.linkGrey,
                destructive: true,
              ),
              SfButton(
                label: 'Link disabled',
                variant: SfButtonVariant.linkGrey,
                state: SfButtonState.disabled,
                destructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
