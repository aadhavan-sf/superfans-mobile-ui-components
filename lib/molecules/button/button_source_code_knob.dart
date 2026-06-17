import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'button_source_code.dart';

const buttonSourceCodeKnobLabel = 'Flutter source code';

class _SourceCodeDisplayField extends Field<String> {
  _SourceCodeDisplayField({
    required super.name,
    required super.initialValue,
  }) : super(
         defaultValue: '',
         type: FieldType.string,
         codec: FieldCodec(
           toParam: (value) => value,
           toValue: (param) => param,
         ),
       );

  @override
  Widget toWidget(BuildContext context, String group, String? value) {
    return ButtonSourceCodePanel(sourceCode: value ?? initialValue ?? '');
  }
}

class ButtonSourceCodeKnob extends Knob<String> {
  ButtonSourceCodeKnob({
    required super.label,
    required super.initialValue,
  });

  @override
  List<Field> get fields {
    return [
      _SourceCodeDisplayField(
        name: label,
        initialValue: initialValue,
      ),
    ];
  }

  @override
  String valueFromQueryGroup(Map<String, String> group) {
    return initialValue;
  }
}

extension ButtonSourceCodeKnobBuilder on KnobsBuilder {
  void buttonSourceCode({
    required String sourceCode,
    String label = buttonSourceCodeKnobLabel,
  }) {
    onKnobAdded(
      ButtonSourceCodeKnob(
        label: label,
        initialValue: sourceCode,
      ),
    );
  }
}
