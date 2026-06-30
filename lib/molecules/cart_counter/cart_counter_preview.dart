import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/type_scale_preview.dart';
import '../../preview/molecule_preview.dart';
import 'sf_cart_counter.dart';

/// Always-interactive playground — Figma presets live under Variants only.
class CartCounterPlaygroundPage extends StatefulWidget {
  const CartCounterPlaygroundPage({
    super.key,
    required this.initialCount,
    required this.maxCount,
    this.loading = false,
    this.disabled = false,
  });

  final int initialCount;
  final int maxCount;
  final bool loading;
  final bool disabled;

  @override
  State<CartCounterPlaygroundPage> createState() =>
      _CartCounterPlaygroundPageState();
}

class _CartCounterPlaygroundPageState extends State<CartCounterPlaygroundPage> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  @override
  void didUpdateWidget(CartCounterPlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCount != oldWidget.initialCount) {
      _count = widget.initialCount;
    }
  }

  String get _footerMessage {
    if (widget.loading) {
      return 'Loading is on — turn off Loading to use +/-';
    }
    if (widget.disabled) {
      return 'Disabled is on — turn off Disabled to use +/-';
    }
    return 'Quantity: $_count';
  }

  @override
  Widget build(BuildContext context) {
    return MoleculePlaygroundScaffold(
      title: 'Cart counter',
      subtitle: 'Interactive',
      footer: Text(
        _footerMessage,
        style: AppTypeScaleToken.textSm.style(
          AppTypeWeight.regular,
          color: AppColors.neutral600,
        ),
      ),
      child: SfCartCounter(
        count: _count,
        loading: widget.loading,
        disabled: widget.disabled,
        maxCount: widget.maxCount,
        onIncrement: widget.loading || widget.disabled
            ? null
            : () => setState(() => _count += 1),
        onDecrement: widget.loading || widget.disabled
            ? null
            : () => setState(() => _count = (_count - 1).clamp(0, 999)),
        onRemove: widget.loading || widget.disabled
            ? null
            : () => setState(() => _count = 0),
      ),
    );
  }
}

class CartCounterVariantsPage extends StatelessWidget {
  const CartCounterVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MoleculeVariantsScaffold(
      title: 'Cart counter',
      sections: [
        MoleculeSection(
          title: 'Figma states',
          subtitle: 'All six variants from Mobile UI / Cart Counter.',
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: SfCartCounterDisplayState.values
                .map(
                  (state) => SfCartCounter(displayState: state),
                )
                .toList(),
          ),
        ),
        MoleculeSection(
          title: 'Interactive',
          subtitle:
              'Trash appears at quantity 1 or when count reaches max (10).',
          child: const _InteractiveCartCounterDemo(),
        ),
      ],
    );
  }
}

class _InteractiveCartCounterDemo extends StatefulWidget {
  const _InteractiveCartCounterDemo();

  @override
  State<_InteractiveCartCounterDemo> createState() =>
      _InteractiveCartCounterDemoState();
}

class _InteractiveCartCounterDemoState
    extends State<_InteractiveCartCounterDemo> {
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfCartCounter(
          count: _count,
          maxCount: 10,
          onIncrement: () => setState(() => _count += 1),
          onDecrement: () => setState(() => _count = (_count - 1).clamp(0, 999)),
          onRemove: () => setState(() => _count = 0),
        ),
        const SizedBox(height: 12),
        Text(
          'Quantity: $_count',
          style: AppTypeScaleToken.textSm.style(
            AppTypeWeight.regular,
            color: AppColors.neutral600,
          ),
        ),
      ],
    );
  }
}
