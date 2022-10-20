import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:sidecar/utilities.dart';

class FlutterTypeChecker {
  const FlutterTypeChecker._();

  static bool isSizedBox(InterfaceType? type) =>
      isTypeMatch(type, type: 'SizedBox', sourcePath: 'src/widgets/basic.dart');

  static bool isContainer(InterfaceType? type) => isTypeMatch(type,
      type: 'Container', sourcePath: 'src/widgets/container.dart');

  static bool isIconData(InterfaceType? type) => isTypeMatch(type,
      type: 'IconData', sourcePath: 'src/widgets/icon_data.dart');

  static bool isIcon(InterfaceType? type) =>
      isTypeMatch(type, type: 'Icon', sourcePath: 'src/widgets/icon.dart');

  static bool isText(InterfaceType? type) =>
      isTypeMatch(type, type: 'Text', sourcePath: 'src/widgets/text.dart');

  static bool isTextEditingController(InterfaceType? type) => isTypeMatch(type,
      type: 'TextEditingController',
      sourcePath: 'src/widgets/editable_text.dart');

  static bool isEdgeInsets(InterfaceType? type) => isTypeMatch(type,
      type: 'EdgeInsets', sourcePath: 'src/painting/edge_insets.dart');

  static bool isBorderRadius(InterfaceType? type) => isTypeMatch(type,
      type: 'BorderRadius', sourcePath: 'src/painting/border_radius.dart');

  static bool isBoxShadow(InterfaceType? type) => isTypeMatch(type,
      type: 'BoxShadow', sourcePath: 'src/painting/box_shadow.dart');

  static bool isTextStyle(InterfaceType? type) => isTypeMatch(type,
      type: 'TextStyle', sourcePath: 'src/painting/text_style.dart');

  static bool isStatefulWidget(
    InterfaceType? type, {
    bool checkSuperInterfaces = true,
  }) =>
      isTypeMatch(type,
          type: 'StatefulWidget',
          sourcePath: 'src/widgets/framework.dart',
          checkSuperInterfaces: checkSuperInterfaces);

  static bool isBuildContext(
    InterfaceType? type, {
    bool checkSuperInterfaces = true,
  }) =>
      isTypeMatch(type,
          type: 'BuildContext',
          sourcePath: 'src/widgets/framework.dart',
          checkSuperInterfaces: checkSuperInterfaces);

  static bool isStatelessWidget(
    InterfaceType? type, {
    bool checkSuperInterfaces = true,
  }) =>
      isTypeMatch(type,
          type: 'StatelessWidget',
          sourcePath: 'src/widgets/framework.dart',
          checkSuperInterfaces: checkSuperInterfaces);

  static bool isState(
    InterfaceType? type, {
    bool checkSuperInterfaces = true,
  }) =>
      isTypeMatch(type,
          type: 'State',
          sourcePath: 'src/widgets/framework.dart',
          checkSuperInterfaces: checkSuperInterfaces);

  static bool isWidget(
    InterfaceType? type, {
    bool checkSuperInterfaces = true,
  }) =>
      isTypeMatch(type,
          type: 'Widget',
          sourcePath: 'src/widgets/framework.dart',
          checkSuperInterfaces: checkSuperInterfaces);

  /// Check if an element is declared in the Flutter package.
  ///
  /// For example, a given ```sourcePath: material.dart```, this function will
  /// search within ```package:flutter/material.dart```.
  static bool isElementMatch(
    Element? element, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(element,
            type: type, sourcePath: 'flutter/$sourcePath', isFromFile: false)
        : TypeChecker.isMatch(element,
            type: type, sourcePath: 'flutter/$sourcePath', isFromFile: false);
  }

  static bool isTypeMatch(
    InterfaceType? interfaceType, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(interfaceType?.element2,
            type: type, sourcePath: 'flutter/$sourcePath', isFromFile: false)
        : TypeChecker.isMatch(interfaceType?.element2,
            type: type, sourcePath: 'flutter/$sourcePath', isFromFile: false);
  }
}
