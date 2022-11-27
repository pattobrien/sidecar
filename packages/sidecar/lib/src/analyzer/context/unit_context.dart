import 'package:analyzer/dart/analysis/results.dart';

import '../../configurations/sidecar_spec/sidecar_spec_base.dart';

/// Context for a single unit, including info about the workspace as a whole.
abstract class UnitContext {
  ResolvedUnitResult get currentUnit;
  SidecarSpec get configuration;
}

class UnitContextImpl implements UnitContext {
  const UnitContextImpl({
    required SidecarSpec configuration,
    required ResolvedUnitResult currentUnit,
  })  : _unit = currentUnit,
        _configuration = configuration;

  final ResolvedUnitResult _unit;
  final SidecarSpec _configuration;

  @override
  SidecarSpec get configuration => _configuration;

  @override
  ResolvedUnitResult get currentUnit => _unit;
}
