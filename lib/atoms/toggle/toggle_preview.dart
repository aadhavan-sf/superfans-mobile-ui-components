import 'package:flutter/material.dart';

import '../atom_preview.dart';
import '../sf_atom.dart';
import 'sf_toggle.dart';

class TogglePlaygroundPage extends StatefulWidget {
  const TogglePlaygroundPage({
    super.key,
    required this.state,
    required this.size,
    required this.pressed,
  });

  final SfAtomState state;
  final SfAtomSize size;
  final bool pressed;

  @override
  State<TogglePlaygroundPage> createState() => _TogglePlaygroundPageState();
}

class _TogglePlaygroundPageState extends State<TogglePlaygroundPage> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.pressed;
  }

  @override
  void didUpdateWidget(TogglePlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pressed != oldWidget.pressed) {
      _value = widget.pressed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AtomPlaygroundScaffold(
      title: 'Toggle',
      subtitle: '${widget.size.label} / ${widget.state.label}',
      specs: [
        'State: ${widget.state.label}',
        'Size: ${widget.size.label}',
        'Pressed: $_value',
      ],
      child: SfToggle(
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

class ToggleVariantsPage extends StatelessWidget {
  const ToggleVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AtomVariantsScaffold(
      title: 'Toggle',
      sections: [
        AtomSection(
          title: 'Default',
          children: [
            for (final size in SfAtomSize.values) ...[
              AtomLabeledControl(
                label: '${size.label} off',
                control: SfToggle(
                  value: false,
                  onChanged: (_) {},
                  size: size,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfToggle(
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
                control: SfToggle(
                  value: false,
                  size: size,
                  state: SfAtomState.disabled,
                ),
              ),
              AtomLabeledControl(
                label: '${size.label} on',
                control: SfToggle(
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
