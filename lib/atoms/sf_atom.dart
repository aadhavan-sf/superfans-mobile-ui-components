enum SfAtomState {
  enabled('Default'),
  disabled('Disabled');

  const SfAtomState(this.label);

  final String label;

  bool get isDisabled => this == SfAtomState.disabled;
}

enum SfAtomSize {
  small('Small'),
  medium('Medium');

  const SfAtomSize(this.label);

  final String label;
}
