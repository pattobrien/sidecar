import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_options.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';

import '../../../context/context.dart';
import '../../configurations/sidecar_spec/sidecar_spec_base.dart';

class SidecarContextImpl implements SidecarContext {
  const SidecarContextImpl(
    AnalysisContext context,
    SidecarSpec sidecarSpec, {
    required Uri targetUri,
  })  : _context = context,
        _sidecarSpec = sidecarSpec,
        _targetUri = targetUri;

  final AnalysisContext _context;
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

  @override
  Folder? get sdkRoot => _context.sdkRoot;

  @override
  SidecarSpec get sidecarSpec => _sidecarSpec;

  @override
  Uri get targetRoot => _targetUri;

  // @override
  // SidecarContext copyWith({
  //   Set<TotalDataResult>? data,
  // }) =>
  //     SidecarContextImpl(_context,
  //         sidecarSpec: _sidecarSpec,
  //         data: data ?? _data,
  //         targetUri: _targetUri);
}
