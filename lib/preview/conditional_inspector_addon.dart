import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook inspector that skips [Foundation] use cases.
class ConditionalInspectorAddon extends WidgetbookAddon<bool> {
  ConditionalInspectorAddon({this.enabled = false}) : super(name: 'Inspector');

  final bool enabled;

  static const _excludedPathPrefix = 'foundation/';

  @override
  List<Field> get fields => [
    BooleanField(name: 'isEnabled', initialValue: enabled),
  ];

  @override
  bool valueFromQueryGroup(Map<String, String> group) {
    return valueOf('isEnabled', group) ?? false;
  }

  @override
  Widget buildUseCase(
    BuildContext context,
    Widget child,
    bool setting,
  ) {
    if (!setting) return child;

    final path = WidgetbookState.of(context).path ?? '';
    if (path.startsWith(_excludedPathPrefix)) return child;

    return Inspector(
      isEnabled: true,
      child: child,
    );
  }
}
