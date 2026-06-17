import 'package:flutter/material.dart';

import '../foundation/app_colors.dart';
import '../foundation/app_spacing.dart';
import '../foundation/type_scale_preview.dart';

/// Pinch, scroll-wheel, and button zoom for Widgetbook previews.
class PreviewZoomSurface extends StatefulWidget {
  const PreviewZoomSurface({
    super.key,
    required this.child,
    this.initialScale = 3,
  });

  final Widget child;
  final double initialScale;

  @override
  State<PreviewZoomSurface> createState() => _PreviewZoomSurfaceState();
}

class _PreviewZoomSurfaceState extends State<PreviewZoomSurface> {
  late final TransformationController _controller;
  late double _scale;

  @override
  void initState() {
    super.initState();
    _scale = widget.initialScale;
    _controller = TransformationController()..value = _matrixForScale(_scale);
    _controller.addListener(_syncScaleFromMatrix);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_syncScaleFromMatrix)
      ..dispose();
    super.dispose();
  }

  Matrix4 _matrixForScale(double scale) {
    return Matrix4.identity()..scaleByDouble(scale, scale, 1, 1);
  }

  void _syncScaleFromMatrix() {
    final nextScale = _controller.value.getMaxScaleOnAxis();
    if ((nextScale - _scale).abs() > 0.01) {
      setState(() => _scale = nextScale);
    }
  }

  void _setScale(double scale) {
    final clamped = scale.clamp(0.5, 8.0);
    setState(() {
      _scale = clamped;
      _controller.value = _matrixForScale(clamped);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PreviewZoomToolbar(
          scale: _scale,
          onZoomOut: () => _setScale(_scale / 1.2),
          onZoomIn: () => _setScale(_scale * 1.2),
          onReset: () => _setScale(widget.initialScale),
          onScaleChanged: _setScale,
        ),
        const SizedBox(height: AppSpacing.spacing3),
        SizedBox(
          height: 420,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppSpacing.spacing2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.spacing2),
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: 0.5,
                maxScale: 8,
                boundaryMargin: const EdgeInsets.all(480),
                panEnabled: true,
                scaleEnabled: true,
                child: Center(child: widget.child),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewZoomToolbar extends StatelessWidget {
  const _PreviewZoomToolbar({
    required this.scale,
    required this.onZoomOut,
    required this.onZoomIn,
    required this.onReset,
    required this.onScaleChanged,
  });

  final double scale;
  final VoidCallback onZoomOut;
  final VoidCallback onZoomIn;
  final VoidCallback onReset;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSpacing.spacing2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing3,
          vertical: AppSpacing.spacing2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Scroll · pinch · or use controls to zoom. Drag to pan.',
              style: AppTypeScaleToken.textXs.style(
                AppTypeWeight.regular,
                color: AppColors.neutral600,
              ),
            ),
            const SizedBox(height: AppSpacing.spacing2),
            Row(
              children: [
                IconButton(
                  tooltip: 'Zoom out',
                  onPressed: onZoomOut,
                  icon: const Icon(Icons.remove, size: 20),
                ),
                Expanded(
                  child: Slider(
                    value: scale.clamp(0.5, 8.0),
                    min: 0.5,
                    max: 8,
                    divisions: 75,
                    label: '${(scale * 100).round()}%',
                    onChanged: onScaleChanged,
                  ),
                ),
                SizedBox(
                  width: 52,
                  child: Text(
                    '${(scale * 100).round()}%',
                    textAlign: TextAlign.center,
                    style: AppTypeScaleToken.textSm.style(
                      AppTypeWeight.semibold,
                      color: AppColors.neutral700,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Zoom in',
                  onPressed: onZoomIn,
                  icon: const Icon(Icons.add, size: 20),
                ),
                TextButton(onPressed: onReset, child: const Text('Reset')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
