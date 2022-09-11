import 'package:sidecar/sidecar.dart';

abstract class FlutterTypeCheckers {
  static const widget = TypeChecker.fromName('Widget', packageName: 'flutter');

  static const statelessWidget =
      TypeChecker.fromName('StatelessWidget', packageName: 'flutter');

  static const statefulWidget =
      TypeChecker.fromName('StatefulWidget', packageName: 'flutter');

  static const widgetState =
      TypeChecker.fromName('State', packageName: 'flutter');
}
