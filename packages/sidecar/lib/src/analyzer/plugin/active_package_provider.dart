import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../../services/active_project_service.dart';

final activePackageRootProvider =
    Provider<Uri>((ref) => throw UnimplementedError());

final workspaceScopeProvider = StateProvider<List<Uri>>((ref) => []);

final activePackageProvider = Provider<ActivePackage>((ref) {
  final root = ref.watch(activePackageRootProvider);
  final scope = ref.watch(workspaceScopeProvider);
  final service = ref.watch(activeProjectServiceProvider);
  final activePackage = service.getActivePackageFromUri(root);
  assert(activePackage != null,
      "active package should never be null from the analyzer's perspective.");
  return scope.isNotEmpty
      ? activePackage!.copyWith(workspaceScope: scope)
      : activePackage!;
});
