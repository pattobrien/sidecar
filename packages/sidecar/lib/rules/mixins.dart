import 'package:meta/meta.dart';

import '../src/configurations/project/project.dart';
import '../src/rules/rules.dart';

mixin Configuration on BaseRule {
  late final Map<dynamic, dynamic>? ruleConfiguration;

  @override
  @mustCallSuper
  void refresh({
    required AnalysisConfiguration? config,
    required AnalysisPackageConfiguration? packageConfig,
  }) {
    ruleConfiguration = config?.configuration;
    super.refresh(packageConfig: packageConfig, config: config);
  }
}
