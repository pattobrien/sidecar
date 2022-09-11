import 'package:sidecar/sidecar.dart';

class RiverpodTypeCheckers {
  static const widgetRef =
      TypeChecker.fromName('WidgetRef', packageName: 'flutter_riverpod');

  static const consumerWidget =
      TypeChecker.fromName('ConsumerWidget', packageName: 'flutter_riverpod');

  static const consumerState =
      TypeChecker.fromName('ConsumerState', packageName: 'flutter_riverpod');

  static const providerOrFamily = TypeChecker.any([providerBase, _family]);

  static const ref = TypeChecker.fromName('Ref', packageName: 'riverpod');

  static const providerBase =
      TypeChecker.fromName('ProviderBase', packageName: 'riverpod');

  static const _family =
      TypeChecker.fromName('Family', packageName: 'riverpod');
}
