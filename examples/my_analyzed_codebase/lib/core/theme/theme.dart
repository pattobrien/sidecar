// APPROVED ICONS

import 'package:flutter/material.dart';

// import 'package:design_system_annotations/design_system_annotations.dart';
class CustomDesignSystem {
  static const Color primary = Colors.blue;
}

final myBrandTheme = ThemeData(
  primaryColor: CustomDesignSystem.primary,
  // accentColor: Colors.red,
);

/// Design system values to use for EdgeInsets
class GlobalInsets {
  static const double xsmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = 24;

  static const Color primary = Colors.blue;
  static const Color secondary = Colors.yellow;
}
