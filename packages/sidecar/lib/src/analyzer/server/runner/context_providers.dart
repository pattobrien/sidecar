import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../context/active_context.dart';
import '../../context/active_package.dart';

part 'context_providers.g.dart';

@Riverpod(keepAlive: true)
class RunnerActiveContexts extends _$RunnerActiveContexts {
  @override
  List<ActivePackage> build() {
    return [];
  }

  set update(List<ActivePackage> contexts) => state = contexts;
}

final runnerResourceProvider = Provider(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);
