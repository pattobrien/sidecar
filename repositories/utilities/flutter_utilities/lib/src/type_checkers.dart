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
}

class FlutterTypeChecker {
  const FlutterTypeChecker();

  WidgetsTypeChecker get widgets => WidgetsTypeChecker();
  MaterialTypeChecker get material => MaterialTypeChecker();
}

const flutterTypeChecker = FlutterTypeChecker();
