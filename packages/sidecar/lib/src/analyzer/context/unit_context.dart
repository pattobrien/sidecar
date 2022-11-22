import 'package:analyzer/dart/analysis/results.dart';

import '../../configurations/project/project_configuration.dart';

abstract class UnitContext {
  ResolvedUnitResult get currentUnit;
  ProjectConfiguration get configuration;
}

class UnitContextImpl implements UnitContext {
  const UnitContextImpl({
    required ProjectConfiguration configuration,
    required ResolvedUnitResult currentUnit,
  })  : _unit = currentUnit,
        _configuration = configuration;

  final ResolvedUnitResult _unit;
  final ProjectConfiguration _configuration;

  @override
  ProjectConfiguration get configuration => _configuration;

  @override
  ResolvedUnitResult get currentUnit => _unit;
}
