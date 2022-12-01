import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../protocol/active_package.dart';

part 'context_providers.g.dart';

@Riverpod(keepAlive: true)
class RunnerActiveContexts extends _$RunnerActiveContexts {
  @override
  List<ActivePackage> build() {
    return [];
  }

  // ignore: avoid_setters_without_getters
  set update(List<ActivePackage> contexts) => state = contexts;
}

final runnerResourceProvider = Provider<ResourceProvider>(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);
