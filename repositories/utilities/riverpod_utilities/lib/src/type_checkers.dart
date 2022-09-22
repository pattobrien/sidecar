import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:sidecar/sidecar.dart';

class RiverpodTypeChecker {
  const RiverpodTypeChecker._();

  static bool isWidgetRef(InterfaceType? type) =>
      isTypeMatchFlutterRiverpod(type,
          type: 'WidgetRef', sourcePath: 'src/consumer.dart');

  static bool isConsumerWidget(InterfaceType? type) =>
      isTypeMatchFlutterRiverpod(type,
          type: 'ConsumerWidget', sourcePath: 'src/consumer.dart');

  static bool isConsumerState(InterfaceType? type) =>
      isTypeMatchFlutterRiverpod(type,
          type: 'ConsumerState', sourcePath: 'src/consumer.dart');

  static bool isRef(InterfaceType? type) => isTypeMatchRiverpod(type,
      type: 'Ref', sourcePath: 'src/framework/ref.dart');

  static bool isProvider(InterfaceType? type) => isTypeMatchRiverpod(type,
      type: 'ProviderBase', sourcePath: 'src/framework/provider_base.dart');

  static bool isFamily(InterfaceType? type) => isTypeMatchRiverpod(type,
      type: 'Family', sourcePath: 'src/framework/family.dart');

  static bool isProviderOrFamily(InterfaceType? type) =>
      isProvider(type) || isFamily(type);

  /// Check if an element is declared in the Riverpod package.
  ///
  static bool isElementMatch(
    Element? element, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(element,
            type: type, sourcePath: 'riverpod/$sourcePath', isFromFile: false)
        : TypeChecker.isMatch(element,
            type: type, sourcePath: 'riverpod/$sourcePath', isFromFile: false);
  }

  static bool isTypeMatchRiverpod(
    InterfaceType? interfaceType, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(interfaceType?.element2,
            type: type, sourcePath: 'riverpod/$sourcePath', isFromFile: false)
        : TypeChecker.isMatch(interfaceType?.element2,
            type: type, sourcePath: 'riverpod/$sourcePath', isFromFile: false);
  }

  static bool isTypeMatchFlutterRiverpod(
    InterfaceType? interfaceType, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(interfaceType?.element2,
            type: type,
            sourcePath: 'flutter_riverpod/$sourcePath',
            isFromFile: false)
        : TypeChecker.isMatch(interfaceType?.element2,
            type: type,
            sourcePath: 'flutter_riverpod/$sourcePath',
            isFromFile: false);
  }

  static bool isTypeMatchHooksRiverpod(
    InterfaceType? interfaceType, {
    required String type,
    required String sourcePath,
    bool checkSuperInterfaces = true,
  }) {
    return checkSuperInterfaces
        ? TypeChecker.isThisOrSuperMatch(interfaceType?.element2,
            type: type,
            sourcePath: 'hooks_riverpod/$sourcePath',
            isFromFile: false)
        : TypeChecker.isMatch(interfaceType?.element2,
            type: type,
            sourcePath: 'hooks_riverpod/$sourcePath',
            isFromFile: false);
  }
}
