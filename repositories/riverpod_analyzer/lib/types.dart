import 'package:sidecar/sidecar.dart';

const providerBase =
    TypeChecker.fromName('ProviderBase', packageName: 'riverpod');

const alwaysAliveProviderListenable = TypeChecker.fromName(
  'AlwaysAliveProviderListenable',
  packageName: 'riverpod',
);

const _family = TypeChecker.fromName('Family', packageName: 'riverpod');

const container =
    TypeChecker.fromName('ProviderContainer', packageName: 'riverpod');

const asyncNotifier =
    TypeChecker.fromName('AsyncNotifierBase', packageName: 'riverpod');

const notifier = TypeChecker.fromName('NotifierBase', packageName: 'riverpod');

const codegenNotifier = TypeChecker.any([asyncNotifier, notifier]);

const providerOrFamily = TypeChecker.any([providerBase, _family]);

const widget = TypeChecker.fromName('Widget', packageName: 'flutter');

const widgetState = TypeChecker.fromName('State', packageName: 'flutter');

const widgetRef =
    TypeChecker.fromName('WidgetRef', packageName: 'flutter_riverpod');

const anyRef = TypeChecker.any([widgetRef, ref]);

const consumerWidget = TypeChecker.fromName(
  'ConsumerWidget',
  packageName: 'flutter_riverpod',
);

const consumerState = TypeChecker.fromName(
  'ConsumerState',
  packageName: 'flutter_riverpod',
);

const ref = TypeChecker.fromName('Ref', packageName: 'riverpod');

/// [Ref] methods that can make a provider depend on another provider.
const refBinders = {'read', 'watch', 'listen'};
