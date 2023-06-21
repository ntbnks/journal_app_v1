import 'package:flutter/material.dart';

class CheckboxDefault extends StatelessWidget {
  const CheckboxDefault(
    this.value, {
    required this.title,
    required this.onChanged,
    super.key,
  });
  final bool value;
  final String title;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(title),
      onChanged: (v) => onChanged(v!),
    );
  }
}
