import 'package:flutter/material.dart';

import '../atom_preview.dart';
import '../sf_atom.dart';
import 'sf_checkbox.dart';

class CheckBoxPlaygroundPage extends StatefulWidget {
  const CheckBoxPlaygroundPage({
    super.key,
    required this.state,
    required this.size,
    required this.value,
  });

  final SfAtomState state;
  final SfAtomSize size;
  final SfCheckBoxValue value;

  @override
  State<CheckBoxPlaygroundPage> createState() => _CheckBoxPlaygroundPageState();
}

class _CheckBoxPlaygroundPageState extends State<CheckBoxPlaygroundPage> {
  late SfCheckBoxValue _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(CheckBoxPlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AtomPlaygroundScaffold(
      title: 'Check box',
      subtitle: '${widget.size.label} / ${widget.state.label}',
      specs: [
        'State: ${widget.state.label}',
        'Size: ${widget.size.label}',
        'Value: ${_value.name}',
      ],
      child: SfCheckBox(
        value: _value,
        onChanged: widget.state.isDisabled
            ? null
            : (value) => setState(() => _value = value),
        size: widget.size,
        state: widget.state,
      ),
    );
  }
}

class CheckBoxVariantsPage extends StatelessWidget {
  const CheckBoxVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AtomVariantsScaffold(
      title: 'Check box',
      sections: [
        AtomSection(
          title: 'Default',
          children: [
            for (final size in SfAtomSize.values) ...[
              AtomLabeledControl(
                label: '${size.label} off',
                control: SfCheckBox(
                  value: SfCheckBoxValue.unchecked,
                  onChanged: (_) {},
                  size: size,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfCheckBox(
                  value: SfCheckBoxValue.checked,
                  onChanged: (_) {},
                  size: size,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} indeterminate',
                control: SfCheckBox(
                  value: SfCheckBoxValue.indeterminate,
                  onChanged: (_) {},
                  size: size,
                ),
              ),
            ],
          ],
        ),
        AtomSection(
          title: 'Disabled',
          children: [
            for (final size in SfAtomSize.values) ...[
              AtomLabeledControl(
                label: '${size.label} off',
                control: SfCheckBox(
                  value: SfCheckBoxValue.unchecked,
                  size: size,
                  state: SfAtomState.disabled,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfCheckBox(
                  value: SfCheckBoxValue.checked,
                  size: size,
                  state: SfAtomState.disabled,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} indeterminate',
                control: SfCheckBox(
                  value: SfCheckBoxValue.indeterminate,
                  size: size,
                  state: SfAtomState.disabled,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
