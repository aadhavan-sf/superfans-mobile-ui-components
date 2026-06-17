import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/type_scale_preview.dart';
import '../../preview/molecule_preview.dart';
import 'sf_counter.dart';

class CounterPlaygroundPage extends StatefulWidget {
  const CounterPlaygroundPage({
    super.key,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.state,
  });

  final int initialValue;
  final int min;
  final int max;
  final SfCounterState state;

  @override
  State<CounterPlaygroundPage> createState() => _CounterPlaygroundPageState();
}

class _CounterPlaygroundPageState extends State<CounterPlaygroundPage> {
  late int _value;
  String? _lastAction;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(widget.min, widget.max);
  }

  @override
  void didUpdateWidget(CounterPlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {
      setState(() {
        _value = widget.initialValue.clamp(widget.min, widget.max);
        _lastAction = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveState = widget.state;
    final isInteractive = effectiveState == SfCounterState.enabled;

    return MoleculePlaygroundScaffold(
      title: 'Counter',
      subtitle: effectiveState.label,
      specs: [
        'State: ${effectiveState.label}',
        'Value: $_value',
        'Min: ${widget.min}',
        'Max: ${widget.max}',
        'Size: 106 × 32 px',
        'Border radius: 8 px',
      ],
      footer: _lastAction == null
          ? null
          : Text(
              _lastAction!,
              style: AppTypeScaleToken.textSm.style(
                AppTypeWeight.regular,
                color: AppColors.brand600,
              ),
            ),
      child: SfCounter(
        value: _value,
        min: widget.min,
        max: widget.max,
        state: effectiveState,
        onChanged: isInteractive
            ? (value) => setState(() {
                _value = value;
                _lastAction = 'Value changed to $value';
              })
            : null,
        onDelete: isInteractive
            ? () => setState(() {
                _value = widget.min;
                _lastAction = 'Item deleted';
              })
            : null,
      ),
    );
  }
}

class CounterVariantsPage extends StatelessWidget {
  const CounterVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoleculeVariantsScaffold(
      title: 'Counter',
      sections: [
        MoleculeSection(
          title: 'Minimum',
          subtitle: 'Value at min — minus disabled, plus active.',
          child: SfCounter(value: 0, onChanged: (_) {}),
        ),
        MoleculeSection(
          title: 'Delete',
          subtitle: 'Value of 1 — trash icon replaces minus.',
          child: SfCounter(value: 1, onChanged: (_) {}, onDelete: () {}),
        ),
        MoleculeSection(
          title: 'Default',
          subtitle: 'Mid-range value — both actions active.',
          child: SfCounter(value: 2, onChanged: (_) {}),
        ),
        MoleculeSection(
          title: 'Maximum',
          subtitle: 'Value at max — plus disabled.',
          child: SfCounter(value: 10, max: 10, onChanged: (_) {}),
        ),
        MoleculeSection(
          title: 'Loading',
          subtitle: 'Async update in progress.',
          child: SfCounter(
            value: 2,
            state: SfCounterState.loading,
            onChanged: (_) {},
          ),
        ),
        MoleculeSection(
          title: 'Disabled',
          subtitle: 'Entire control is non-interactive.',
          child: SfCounter(
            value: 0,
            state: SfCounterState.disabled,
          ),
        ),
        MoleculeSection(
          title: 'Interactive demo',
          subtitle: 'Tap +/- to change value. Trash appears at 1.',
          child: _InteractiveCounterDemo(max: 10),
        ),
      ],
    );
  }
}

class _InteractiveCounterDemo extends StatefulWidget {
  const _InteractiveCounterDemo({required this.max});

  final int max;

  @override
  State<_InteractiveCounterDemo> createState() =>
      _InteractiveCounterDemoState();
}

class _InteractiveCounterDemoState extends State<_InteractiveCounterDemo> {
  int _value = 2;
  bool _loading = false;

  Future<void> _updateValue(int nextValue) async {
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() {
        _value = nextValue;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCounter(
      value: _value,
      max: widget.max,
      state: _loading ? SfCounterState.loading : SfCounterState.enabled,
      onChanged: _loading ? null : _updateValue,
      onDelete: _loading
          ? null
          : () {
              _updateValue(0);
            },
    );
  }
}
