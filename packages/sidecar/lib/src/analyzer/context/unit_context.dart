import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

import '../../configurations/project/project_configuration.dart';

abstract class UnitContext {
  CompilationUnit get currentUnit;
  ProjectConfiguration get configuration;
  LineInfo get lineInfo;
  Uri get sourceUri;
  String get contents;
}

class UnitContextImpl implements UnitContext {
  const UnitContextImpl({
    required ProjectConfiguration configuration,
    required CompilationUnit currentUnit,
    required Uri sourceUri,
    LineInfo? lineInfo,
    required String contents,
  })  : _lineInfo = lineInfo,
        _unit = currentUnit,
        _uri = sourceUri,
        _contents = contents,
        _configuration = configuration;

  final LineInfo? _lineInfo;
  final CompilationUnit _unit;
  final Uri _uri;
  final String _contents;
  final ProjectConfiguration _configuration;

  @override
  ProjectConfiguration get configuration => _configuration;

  @override
  CompilationUnit get currentUnit => _unit;

  @override
  LineInfo get lineInfo => _lineInfo ?? currentUnit.lineInfo;

  @override
  Uri get sourceUri => _uri;

  @override
  String get contents => _contents;
}
