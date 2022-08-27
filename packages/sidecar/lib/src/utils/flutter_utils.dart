import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'utils.dart';

class FlutterUtils {
  static const _nameBuildContext = 'BuildContext';
  static const _nameStatefulWidget = 'StatefulWidget';
  static const _nameWidget = 'Widget';
  static const _nameContainer = 'Container';
  static const _nameSizedBox = 'SizedBox';

  final String widgetsUri;

  final Uri _uriBasic;
  final Uri _uriContainer;
  final Uri _uriFramework;
  final Uri _uriFoundation;

  FlutterUtils(String uriPrefix)
      : widgetsUri = '$uriPrefix/widgets.dart',
        _uriBasic = Uri.parse('$uriPrefix/src/widgets/basic.dart'),
        _uriContainer = Uri.parse('$uriPrefix/src/widgets/container.dart'),
        _uriFramework = Uri.parse('$uriPrefix/src/widgets/framework.dart'),
        _uriFoundation = Uri.parse('$uriPrefix/src/foundation/constants.dart');

  bool hasWidgetAsAscendant(InterfaceElement? element,
      [Set<InterfaceElement>? alreadySeen]) {
    alreadySeen ??= {};
    if (element == null || !alreadySeen.add(element)) {
      return false;
    }
    if (_isExactWidget(element, _nameWidget, _uriFramework)) {
      return true;
    }
    return hasWidgetAsAscendant(element.supertype?.element2, alreadySeen);
  }

  bool isBuildContext(DartType? type, {bool skipNullable = false}) {
    if (type is! InterfaceType) {
      return false;
    }
    if (skipNullable && type.nullabilitySuffix == NullabilitySuffix.question) {
      return false;
    }
    return _isExactWidget(type.element2, _nameBuildContext, _uriFramework);
  }

  bool isExactWidget(ClassElement element) =>
      _isExactWidget(element, _nameWidget, _uriFramework);

  bool isExactWidgetTypeContainer(DartType? type) =>
      type is InterfaceType &&
      _isExactWidget(type.element2, _nameContainer, _uriContainer);

  bool isExactWidgetTypeSizedBox(DartType? type) =>
      type is InterfaceType &&
      _isExactWidget(type.element2, _nameSizedBox, _uriBasic);

  bool isKDebugMode(Element? element) =>
      element != null &&
      element.name == 'kDebugMode' &&
      element.source?.uri == _uriFoundation;

  bool isStatefulWidget(ClassElement? element) {
    if (element == null) {
      return false;
    }
    if (_isExactWidget(element, _nameStatefulWidget, _uriFramework)) {
      return true;
    }
    for (var type in element.allSupertypes) {
      if (_isExactWidget(type.element2, _nameStatefulWidget, _uriFramework)) {
        return true;
      }
    }
    return false;
  }

  bool isWidget(InterfaceElement element) {
    if (_isExactWidget(element, _nameWidget, _uriFramework)) {
      return true;
    }
    for (var type in element.allSupertypes) {
      if (_isExactWidget(type.element2, _nameWidget, _uriFramework)) {
        return true;
      }
    }
    return false;
  }

  bool isWidgetType(DartType? type) =>
      type is InterfaceType && isWidget(type.element2);

  bool _isExactWidget(InterfaceElement element, String type, Uri uri) =>
      element.name == type && element.source.uri == uri;
}

extension AstNodeXX on AstNode {
  bool isInsideBuildMethod() {
    final node = thisOrAncestorMatching((node) {
      Logger.logLine(
          'ANCESTOR: ${node.runtimeType} w/ SOURCE ${node.toSource()}');
      if (node is MethodDeclaration) {
        Logger.logLine('FOUND METHOD: ${node.toSource()}');
        final parent = node.parent;
        final isBuildMethod = node.name.name == 'build';
        final isParentClassDeclaration = parent is ClassDeclaration;
        Logger.logLine(
            'isBuildMethod: $isBuildMethod / isParentClassDeclaration: $isParentClassDeclaration');
        if (isBuildMethod && isParentClassDeclaration) {
          final flutter = FlutterUtils('package:flutter');
          final isWidget = flutter.isWidget(parent.declaredElement2!);
          // final supertypes = parent.declaredElement2?. ?? [];

          // for (final element in supertypes) {
          //   print(element.getDisplayString(withNullability: false));
          // }

          // final isWidget = supertypes.firstWhereOrNull((element) =>
          //         element.getDisplayString(withNullability: false) ==
          //         'Widget') !=
          //     null;

          Logger.logLine('isWidget: $isWidget ');
          return isWidget;
          // return true;
        }
        return false;
      } else {
        return false;
      }
    });
    return node != null;
  }
}
