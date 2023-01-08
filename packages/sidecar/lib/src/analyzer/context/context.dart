import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_options.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:package_config/package_config.dart';

import '../../../context/context.dart';
import '../../configurations/sidecar_spec/sidecar_spec_base.dart';
import '../../protocol/models/analysis_result.dart';
import '../../protocol/models/data_result.dart';

class SidecarContextImpl implements SidecarContext {
  const SidecarContextImpl(
    AnalysisContext context, {
    // required PackageConfig packageConfig,
    required SidecarSpec sidecarSpec,
    required Set<TotalDataResult> data,
    required Uri targetUri,
  })  : _context = context,
        // _packageConfig = packageConfig,
        _data = data,
        _sidecarSpec = sidecarSpec,
        _targetUri = targetUri;

  final AnalysisContext _context;
  // final PackageConfig _packageConfig;
  final Set<TotalDataResult> _data;
  final SidecarSpec _sidecarSpec;
  final Uri _targetUri;

  @override
  AnalysisOptions get analysisOptions => _context.analysisOptions;

  @override
  Future<List<String>> applyPendingFileChanges() =>
      _context.applyPendingFileChanges();

  @override
  void changeFile(String path) => _context.changeFile(path);

  @override
  AnalysisSession get currentSession => _context.currentSession;

  // @override
  // ResolvedUnitResult get currentUnit => throw UnimplementedError();

  @override
  Set<TotalDataResult> get data => _data;

  // @override
  // PackageConfig get packageConfig => _packageConfig;

  @override
  Folder? get sdkRoot => _context.sdkRoot;

  @override
  SidecarSpec get sidecarSpec => _sidecarSpec;

  @override
  Uri get targetRoot => _targetUri;

  @override
  SidecarContext copyWith({
    Set<TotalDataResult>? data,
  }) =>
      SidecarContextImpl(_context,
          sidecarSpec: _sidecarSpec,
          data: data ?? _data,
          targetUri: _targetUri);
}
