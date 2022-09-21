import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/sidecar.dart';

class WidgetsTypeChecker {
  const WidgetsTypeChecker();
  static const widget = TypeChecker.fromName('Widget', packageName: 'flutter');

  static const statelessWidget =
      TypeChecker.fromName('StatelessWidget', packageName: 'flutter');

  static const statefulWidget =
      TypeChecker.fromName('StatefulWidget', packageName: 'flutter');

  static const widgetState =
      TypeChecker.fromName('State', packageName: 'flutter');
}

class MaterialTypeChecker {
  const MaterialTypeChecker();
  static const color = TypeChecker.fromName('Color', packageName: 'flutter');
  static const edgeInsets =
      TypeChecker.fromName('EdgeInsets', packageName: 'flutter');
}

class FlutterTypeChecker {
  const FlutterTypeChecker();

  WidgetsTypeChecker get widgets => WidgetsTypeChecker();
  MaterialTypeChecker get material => MaterialTypeChecker();

  /// Check if an element is declared in the Flutter package.
  ///
  /// For example, a given ```sourcePath: material.dart```, this function will
  /// search within ```package:flutter/material.dart```.
  static bool isMatch(
    Element? element, {
    required String type,
    required String sourcePath,
  }) {
    if (element == null) return false;
    final uri = Uri(scheme: 'package', path: 'flutter/$sourcePath');
    return element.name == type && element.source?.uri == uri;
  }
}

const flutterTypeChecker = FlutterTypeChecker();
