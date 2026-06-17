import 'package:flutter/material.dart';

import '../atom_preview.dart';
import '../sf_atom.dart';
import 'sf_radio_button.dart';

class RadioButtonPlaygroundPage extends StatefulWidget {
  const RadioButtonPlaygroundPage({
    super.key,
    required this.state,
    required this.size,
    required this.selected,
  });

  final SfAtomState state;
  final SfAtomSize size;
  final bool selected;

  @override
  State<RadioButtonPlaygroundPage> createState() =>
      _RadioButtonPlaygroundPageState();
}

class _RadioButtonPlaygroundPageState extends State<RadioButtonPlaygroundPage> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.selected;
  }

  @override
  void didUpdateWidget(RadioButtonPlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      _value = widget.selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AtomPlaygroundScaffold(
      title: 'Radio button',
      subtitle: '${widget.size.label} / ${widget.state.label}',
      specs: [
        'State: ${widget.state.label}',
        'Size: ${widget.size.label}',
        'Selected: $_value',
      ],
      child: SfRadioButton(
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

class RadioButtonVariantsPage extends StatelessWidget {
  const RadioButtonVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AtomVariantsScaffold(
      title: 'Radio button',
      sections: [
        AtomSection(
          title: 'Default',
          children: [
            for (final size in SfAtomSize.values) ...[
              AtomLabeledControl(
                label: '${size.label} off',
                control: SfRadioButton(
                  value: false,
                  onChanged: (_) {},
                  size: size,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfRadioButton(
                  value: true,
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
                control: SfRadioButton(
                  value: false,
                  size: size,
                  state: SfAtomState.disabled,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfRadioButton(
                  value: true,
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
