import 'package:flutter/material.dart';

enum PaletteColor { green, red }

class Pal {
  static const lightGreen = Color.fromRGBO(197, 225, 165, 1);
  static const defaultGreen = Color.fromRGBO(56, 144, 56, 1);
  static const defaultGreenGradient = Color.fromRGBO(128, 192, 72, 1);
  static const defaultGreenHighlight = Color.fromRGBO(160, 208, 80, 1);
  static const lightestGreen = Color.fromRGBO(220, 237, 188, 1);

  static const defaultRed = Color.fromRGBO(144, 56, 56, 1);
  static const defaultRedGradient = Color.fromRGBO(192, 72, 128, 1);
  static const defaultRedHighlight = Color.fromRGBO(208, 80, 160, 1);

  static const defaultDisabled = Color.fromRGBO(88, 104, 88, 1);
  static const defaultDisabledGradient = Color.fromRGBO(128, 144, 128, 1);
  static const defaultDisabledHighlight = Color.fromRGBO(160, 192, 160, 1);
}
