import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../application/analysis_results/file_report_provider.dart';
import '../constants.dart';
import '../plugin/plugin.dart';
import '../plugin/plugin_from_path.dart';
import '../reports/file_stats.dart';
import '../services/log_delegate/log_delegate.dart';
import '../services/plugin_generator/plugin_generator.dart';
import '../services/project_configuration_service/project_configuration.dart';
import '../services/project_configuration_service/project_configuration_service.dart';
import '../utils/utils.dart';
import '../version.dart';
import 'resolved_unit_service.dart';

class AnalysisContextService {
  AnalysisContextService(
    this.ref, {
    required this.context,
    required this.resolvedUnitService,
    required this.sidecarConfigurationService,
    required this.rootPackageConfigService,
  }) : root = context.contextRoot;

  final Ref ref;
  final AnalysisContext context;
  final ContextRoot root;

  final ResolvedUnitService resolvedUnitService;
  final ProjectConfigurationService sidecarConfigurationService;
  final PackageConfigurationService rootPackageConfigService;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  Future<bool> get initialization => _completer.future;

  final _completer = Completer<bool>();
  bool get isInitialized => _completer.isCompleted;
  final _packageConfigCompleter = Completer<void>();

  Future<bool> isValidContext() async {
    assert(_packageConfigCompleter.isCompleted, '');
    try {
      if (!context.isSidecarEnabled) return false;
      final rootPackageConfig = await rootPackageConfigService.initialize();
      final homeDirectory = Platform.environment['HOME']!;

      final pluginSource = rootPackageConfig.packages
          .firstWhere((package) => package.name == kSidecarPluginName);

      final pluginPubspec =
          File(p.join(pluginSource.root.path, 'pubspec.yaml'));

      final pubCacheRoot = p.join(homeDirectory, '.pub-cache');
      final pubCacheHosted = p.join(pubCacheRoot, 'hosted');
      final pubCacheGit = p.join(pubCacheRoot, 'git');
      final isPluginRunningFromPath = ref.read(isPluginFromPath);

      final pubOfficialCache = p.join(pubCacheHosted, 'pub.dartlang.org');

      if (p.isWithin(pubOfficialCache, pluginPubspec.path)) {
        // plugin package is from pub
        final folderName = pluginPubspec.parent.uri.pathSegments.last;

        if (folderName == '$kSidecarPluginName-$packageVersion') return true;
      } else if (p.isWithin(pubCacheHosted, pluginPubspec.path)) {
        //TODO: plugin package is from some other hosted dependency
      } else if (p.isWithin(pubCacheGit, pluginPubspec.path)) {
        //TODO: plugin package is from git
      } else if (!p.isWithin(pubCacheRoot, pluginPubspec.path)) {
        //TODO: not within pub root folder = from path
        if (isPluginRunningFromPath) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> initializeContext() async {
    // check if context is valid

    // parse ProjectConfig
    final projectConfig = await sidecarConfigurationService.parse();
    if (projectConfig == null) return _completer.complete(false);
    // check for annotations
  }

  Future<void> generateReport() async {
    // final reports = root
    //     .typedAnalyzedFiles()
    //     .map((file) => ref.read(fileReportProvider(file)).valueOrNull)
    //     .whereType<FileStats>();

    // ref.read(logDelegateProvider).generateReport(reports);
  }
}

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, AnalysisContext>(
  (ref, context) {
    final resolvedUnitService = ref.watch(resolvedUnitServiceProvider(context));

    final projectConfigurationService =
        ref.watch(projectConfigurationServiceProvider(context.contextRoot));

    final packageConfigurationService = ref
        .watch(packageConfigServiceProvider(context.contextRoot.root.toUri()));

    return AnalysisContextService(
      ref,
      context: context,
      resolvedUnitService: resolvedUnitService,
      sidecarConfigurationService: projectConfigurationService,
      rootPackageConfigService: packageConfigurationService,
    );
  },
  dependencies: [
    resolvedUnitServiceProvider,
    logDelegateProvider,
    isPluginFromPath,
    // fileReportProvider,
    projectConfigurationServiceProvider,
    packageConfigServiceProvider,
  ],
);
