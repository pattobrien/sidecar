import 'dart:io';

import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../constants.dart';
import 'log_delegate/log_delegate.dart';
import '../plugin/protocol/sidecar_package.dart';

class ActivePackageService {
  const ActivePackageService(this._ref);

  final Ref _ref;

  void _log(String message) => _ref.read(logDelegateProvider).sidecarMessage;
  void _logError(Object e, [StackTrace? stackTrace]) =>
      _ref.read(logDelegateProvider).sidecarError;

  // is this needed for any external functions ?
  bool isValidDartProject(Uri root) =>
      File(p.join(root.toFilePath(), 'pubspec.yaml')).existsSync();

  // is this needed for any external functions ?
  PackageConfig _getPackageConfig(Uri root) {
    final path = p.join(root.toFilePath(), '.dart_tool', 'package_config.json');
    final contents = File(path).readAsBytesSync();
    return PackageConfig.parseBytes(contents, root);
  }

  List<SidecarPackage> getSidecarDependencies(Uri root) {
    _log('findAllSidecarDeps for ${root.toFilePath()} // ${root.path}');
    return _getPackageConfig(root)
        .packages
        .map<SidecarPackage?>((package) {
          try {
            // _log(
            //     'findAllSidecarDeps for name ${package.name} @ path ${package.root.toFilePath(windows: Platform.isWindows)} // ${package.root.normalizePath().path}');
            return parseLintPackage(package.name, package.root);
          } catch (e, stackTrace) {
            _logError('NON-FATAL ERROR: findAllSidecarDeps $e', stackTrace);
            return null;
          }
        })
        .whereType<SidecarPackage>()
        .toList();
  }

  /// Get the plugin package uri for the current Dart project.
  Package? getSidecarPluginUriForPackage(Uri root) {
    return _getPackageConfig(root).packages.firstWhereOrNull((package) {
      return package.name == kSidecarPluginName;
    });
  }
}

final activePackageServiceProvider = Provider(ActivePackageService.new);
