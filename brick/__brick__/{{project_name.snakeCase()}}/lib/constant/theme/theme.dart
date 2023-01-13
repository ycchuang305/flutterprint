import 'package:flutter/material.dart';

export 'color_schemes.dart';

extension ColorSchemesX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
