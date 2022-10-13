import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:package_config/package_config.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';

final contextSidecarPluginPackageProvider =
    Provider.family<Package?, ContextRoot>((ref, root) {
  final service = ref.watch(activePackageServiceProvider);
  return service.getSidecarPluginUriForPackage(root.root.toUri());
});
