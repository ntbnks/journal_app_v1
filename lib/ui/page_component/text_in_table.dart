import 'package:flutter/material.dart';

class TextInTable extends StatelessWidget {
  const TextInTable(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(text, textAlign: TextAlign.center);
}
