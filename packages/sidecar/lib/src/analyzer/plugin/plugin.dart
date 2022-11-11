import 'package:riverpod/riverpod.dart';

export 'analysis_contexts_provider.dart';
export 'analyzer_resource_provider.dart';
export 'node_registry_provider.dart';
export 'rule_constructors_provider.dart';
export 'rules.dart';
export 'sidecar_analyzer_comm_service.dart';

Future<int> getValue() async {
  return Future<int>.delayed(const Duration(seconds: 3), () => 1);
}

final getValueProvider = FutureProvider.autoDispose((ref) => getValue());

final valueProcessorProvider = FutureProvider.autoDispose((ref) async {
  print('getting value...');
  final value = await ref.watch(getValueProvider.future);
  print('got value.');
  return value * 2;
});

void main() async {
  final container = ProviderContainer();
  final first = await container.refresh(valueProcessorProvider.future);

  x(container);
  print('${DateTime.now().toIso8601String()} calculating...');
  container.invalidate(getValueProvider);
  final second = await container.refresh(valueProcessorProvider.future);
  print('${DateTime.now().toIso8601String()} result: $second');
}

void x(ProviderContainer container) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  print('${DateTime.now().toIso8601String()} invalidated');
  // container.invalidate(getValueProvider);
  container.invalidate(valueProcessorProvider);
}
